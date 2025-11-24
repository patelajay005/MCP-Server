#!/bin/bash
# GitHub MCP Server Setup Script for macOS and Linux

set -e

echo ""
echo "========================================"
echo "  GitHub MCP Server Setup"
echo "========================================"
echo ""

# Configuration
VERSION="v0.21.0"
TEMP_DIR="$(mktemp -d)"

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
    Darwin*)    
        PLATFORM="darwin"
        CLAUDE_CONFIG_DIR="$HOME/Library/Application Support/Claude"
        ;;
    Linux*)     
        PLATFORM="linux"
        CLAUDE_CONFIG_DIR="$HOME/.config/Claude"
        ;;
    *)          
        echo "Error: Unsupported OS: ${OS}"
        exit 1
        ;;
esac

case "${ARCH}" in
    x86_64)     ARCH="x86_64";;
    aarch64)    ARCH="arm64";;
    arm64)      ARCH="arm64";;
    *)          
        echo "Error: Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

echo "Detected: ${PLATFORM}/${ARCH}"
echo ""

# Step 1: Check for .env file
echo "[1/6] Checking for GitHub token..."
if [[ ! -f ".env" ]]; then
    echo "Error: .env file not found!"
    echo ""
    echo "Please create a .env file with your GitHub Personal Access Token:"
    echo "  1. Copy .env.example to .env"
    echo "  2. Edit .env and add your token"
    echo "  3. Get token from: https://github.com/settings/tokens/new"
    echo ""
    exit 1
fi

# Load token from .env
TOKEN=""
while IFS='=' read -r key value; do
    if [[ $key == "GITHUB_PERSONAL_ACCESS_TOKEN" ]]; then
        TOKEN="${value//[$'\r\n']/}"
        TOKEN="${TOKEN# }"
        TOKEN="${TOKEN% }"
        break
    fi
done < .env

if [[ -z "$TOKEN" ]] || [[ "$TOKEN" == "your_github_token_here" ]]; then
    echo "Error: GitHub token not found or not configured in .env file!"
    echo ""
    echo "Please edit .env and add your GitHub Personal Access Token"
    echo "Get your token from: https://github.com/settings/tokens/new"
    echo ""
    exit 1
fi

echo "Token found: ${TOKEN:0:8}..."
echo ""

# Step 2: Validate token
echo "[2/6] Validating GitHub token..."
if command -v curl &> /dev/null; then
    USER_INFO=$(curl -s -H "Authorization: token $TOKEN" https://api.github.com/user)
    USERNAME=$(echo "$USER_INFO" | grep -o '"login": *"[^"]*"' | head -1 | sed 's/"login": *"\(.*\)"/\1/')
    
    if [[ -n "$USERNAME" ]]; then
        echo "Token valid! Authenticated as: $USERNAME"
        echo ""
    else
        echo "Error: Invalid GitHub token!"
        echo "Please check your token and ensure it has the required scopes."
        echo ""
        exit 1
    fi
else
    echo "Warning: curl not found. Skipping token validation."
    echo ""
fi

# Step 3: Check for Homebrew on macOS
if [[ "$PLATFORM" == "darwin" ]] && command -v brew &> /dev/null; then
    echo "[3/6] Homebrew detected. Checking for GitHub MCP Server..."
    
    if brew list github-mcp-server &> /dev/null 2>&1; then
        echo "GitHub MCP Server already installed via Homebrew."
        echo "Updating to latest version..."
        brew upgrade github-mcp-server || brew install github/github/github-mcp-server
    else
        echo "Installing GitHub MCP Server via Homebrew..."
        brew tap github/github 2>/dev/null || true
        brew install github/github/github-mcp-server
    fi
    
    INSTALL_PATH="$(brew --prefix github-mcp-server 2>/dev/null)/bin/github-mcp-server" || INSTALL_PATH="/opt/homebrew/bin/github-mcp-server"
    
    if [[ ! -f "$INSTALL_PATH" ]]; then
        INSTALL_PATH="/usr/local/bin/github-mcp-server"
    fi
    
    echo "Installed at: $INSTALL_PATH"
    echo ""
else
    # Manual installation
    echo "[3/6] Downloading GitHub MCP Server ${VERSION}..."
    
    INSTALL_DIR="/usr/local/bin"
    INSTALL_PATH="$INSTALL_DIR/github-mcp-server"
    
    # Check if we need sudo
    if [[ ! -w "$INSTALL_DIR" ]]; then
        SUDO="sudo"
        echo "Note: sudo access required for installation to $INSTALL_DIR"
    else
        SUDO=""
    fi
    
    # Construct download URL
    if [[ "$PLATFORM" == "darwin" ]]; then
        DOWNLOAD_URL="https://github.com/github/github-mcp-server/releases/download/${VERSION}/github-mcp-server_Darwin_${ARCH}.tar.gz"
    else
        DOWNLOAD_URL="https://github.com/github/github-mcp-server/releases/download/${VERSION}/github-mcp-server_Linux_${ARCH}.tar.gz"
    fi
    
    echo "Downloading from: $DOWNLOAD_URL"
    
    if command -v wget &> /dev/null; then
        wget -q --show-progress -O "$TEMP_DIR/github-mcp-server.tar.gz" "$DOWNLOAD_URL"
    elif command -v curl &> /dev/null; then
        curl -L --progress-bar -o "$TEMP_DIR/github-mcp-server.tar.gz" "$DOWNLOAD_URL"
    else
        echo "Error: Neither wget nor curl found. Please install one of them."
        exit 1
    fi
    
    echo "Download complete!"
    echo ""
    
    # Step 4: Extract and install
    echo "[4/6] Installing GitHub MCP Server..."
    tar -xzf "$TEMP_DIR/github-mcp-server.tar.gz" -C "$TEMP_DIR"
    
    $SUDO mv "$TEMP_DIR/github-mcp-server" "$INSTALL_PATH"
    $SUDO chmod +x "$INSTALL_PATH"
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    echo "Installation complete!"
    echo "Installed to: $INSTALL_PATH"
    echo ""
fi

# Verify installation
if [[ ! -f "$INSTALL_PATH" ]]; then
    echo "Error: Installation failed. Binary not found at expected location."
    exit 1
fi

# Step 5: Configure Claude Desktop
echo "[5/6] Configuring Claude Desktop..."

CLAUDE_CONFIG_PATH="$CLAUDE_CONFIG_DIR/claude_desktop_config.json"

# Create Claude config directory if needed
mkdir -p "$CLAUDE_CONFIG_DIR"

# Check if config exists
if [[ -f "$CLAUDE_CONFIG_PATH" ]]; then
    echo "Existing Claude config found. Creating backup..."
    cp "$CLAUDE_CONFIG_PATH" "$CLAUDE_CONFIG_PATH.backup"
    
    # Use jq if available to merge configs
    if command -v jq &> /dev/null; then
        jq ".mcpServers.github = {\"command\": \"$INSTALL_PATH\", \"args\": [], \"env\": {\"GITHUB_PERSONAL_ACCESS_TOKEN\": \"$TOKEN\"}}" \
            "$CLAUDE_CONFIG_PATH" > "$CLAUDE_CONFIG_PATH.tmp" && mv "$CLAUDE_CONFIG_PATH.tmp" "$CLAUDE_CONFIG_PATH"
    else
        # If jq not available, create new config (this will overwrite)
        echo "Warning: jq not found. Creating new config (existing config backed up)..."
        cat > "$CLAUDE_CONFIG_PATH" << EOF
{
  "mcpServers": {
    "github": {
      "command": "$INSTALL_PATH",
      "args": [],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "$TOKEN"
      }
    }
  }
}
EOF
    fi
else
    # Create new config
    cat > "$CLAUDE_CONFIG_PATH" << EOF
{
  "mcpServers": {
    "github": {
      "command": "$INSTALL_PATH",
      "args": [],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "$TOKEN"
      }
    }
  }
}
EOF
fi

echo "Claude Desktop configured!"
echo "Config file: $CLAUDE_CONFIG_PATH"
echo ""

# Step 6: Verify setup
echo "[6/6] Verifying setup..."

ALL_GOOD=true

# Check binary
if [[ -f "$INSTALL_PATH" ]]; then
    echo "  ✓ Binary installed - $INSTALL_PATH"
else
    echo "  ✗ Binary NOT found"
    ALL_GOOD=false
fi

# Check config
if [[ -f "$CLAUDE_CONFIG_PATH" ]]; then
    echo "  ✓ Claude config created - $CLAUDE_CONFIG_PATH"
else
    echo "  ✗ Claude config NOT found"
    ALL_GOOD=false
fi

# Check token
if [[ -n "$TOKEN" ]]; then
    echo "  ✓ GitHub token configured - Token: ${TOKEN:0:10}..."
else
    echo "  ✗ GitHub token NOT configured"
    ALL_GOOD=false
fi

echo ""

if [[ "$ALL_GOOD" == true ]]; then
    echo "========================================"
    echo "  Setup Complete!"
    echo "========================================"
    echo ""
    echo "Next steps:"
    echo "  1. RESTART Claude Desktop (completely quit and reopen)"
    echo "  2. Wait for Claude to fully start"
    echo "  3. Try asking: 'List my GitHub repositories'"
    echo ""
    echo "Documentation:"
    echo "  - SETUP_GUIDE.md    - Complete setup guide"
    echo "  - EXAMPLE_PROMPTS.md - 50+ example commands"
    echo "  - TROUBLESHOOTING.md - Problem solving"
    echo ""
    echo "If you encounter issues, see TROUBLESHOOTING.md"
    echo ""
else
    echo "========================================"
    echo "  Setup incomplete - please fix errors"
    echo "========================================"
    echo ""
    echo "See TROUBLESHOOTING.md for help"
    echo ""
    exit 1
fi

