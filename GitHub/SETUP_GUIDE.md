# GitHub MCP Server - Complete Setup Guide

**The Complete Step-by-Step Guide to Setting Up GitHub MCP Server**

This guide will walk you through everything from initial setup to testing your GitHub MCP Server installation.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step-by-Step Setup](#step-by-step-setup)
3. [Platform-Specific Instructions](#platform-specific-instructions)
4. [Configuration](#configuration)
5. [Testing](#testing)
6. [Advanced Configuration](#advanced-configuration)
7. [Troubleshooting](#troubleshooting)
8. [Next Steps](#next-steps)

---

## Prerequisites

### Required

✅ **GitHub Account**
- If you don't have one: [Sign up at GitHub](https://github.com/signup)

✅ **Claude Desktop Application**
- Download from: [https://claude.ai/download](https://claude.ai/download)
- Install and run at least once before setup

✅ **GitHub Personal Access Token (PAT)**
- We'll create this in Step 1 below

### System Requirements

**Windows:**
- Windows 10 or later
- PowerShell 5.1 or later
- Administrator access (for installation)

**macOS:**
- macOS 10.15 (Catalina) or later
- Terminal access
- Homebrew (recommended, optional)

**Linux:**
- Any modern Linux distribution
- Bash shell
- curl or wget

---

## Step-by-Step Setup

### Step 1: Get Your GitHub Personal Access Token

Your GitHub token allows the MCP server to access your repositories securely.

1. **Go to GitHub Token Creation Page:**
   - Visit: [https://github.com/settings/tokens/new](https://github.com/settings/tokens/new)
   - Or navigate: GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)

2. **Configure Your Token:**
   - **Note/Name:** `GitHub MCP Server` (or any name you prefer)
   - **Expiration:** Choose based on your security preference (90 days recommended)
   
3. **Select Required Scopes:**
   - ✅ **repo** - Full control of private repositories
     - Allows access to all your repositories
     - Required for creating issues, PRs, etc.
   - ✅ **workflow** - Update GitHub Action workflows
     - Required to trigger and manage workflows
   - ✅ **read:org** - Read org and team membership
     - Required for organization operations

4. **Generate and Copy Token:**
   - Click "Generate token" at the bottom
   - **IMPORTANT:** Copy the token immediately
   - You won't be able to see it again!
   - It should start with `ghp_`

5. **Save Your Token Securely:**
   - We'll use it in Step 3

---

### Step 2: Clone This Repository

```bash
# Clone the repository
git clone https://github.com/patelajay005/github-mcp-server-setup.git

# Navigate into the directory
cd github-mcp-server-setup

# List files to verify
ls
```

You should see files like:
- `setup-windows.ps1` or `setup-unix.sh`
- `.env.example`
- `README.md`
- Setup scripts and documentation

---

### Step 3: Configure Your Environment

1. **Create your `.env` file:**

**Windows (PowerShell):**
```powershell
Copy-Item .env.example .env
```

**macOS/Linux (Terminal):**
```bash
cp .env.example .env
```

2. **Edit the `.env` file:**

**Windows:**
```powershell
notepad .env
```

**macOS/Linux:**
```bash
nano .env
# or
vi .env
# or use your favorite editor
```

3. **Add your GitHub token:**

Replace `your_github_token_here` with the token you copied in Step 1:

```env
GITHUB_PERSONAL_ACCESS_TOKEN=ghp_your_actual_token_here
```

4. **Save and close the file**

⚠️ **SECURITY NOTE:** Never commit this `.env` file to Git! The `.gitignore` file protects it.

---

### Step 4: Run the Setup Script

Choose your platform and follow the instructions:

#### Windows Setup

1. **Open PowerShell as Administrator:**
   - Press `Win + X`
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

2. **Navigate to the project directory:**
   ```powershell
   cd path\to\github-mcp-server-setup
   ```

3. **Run the setup script:**
   ```powershell
   .\setup-windows.ps1
   ```

4. **Follow the prompts:**
   - The script will download the GitHub MCP Server
   - Install it to `%LOCALAPPDATA%\Programs\github-mcp-server`
   - Configure Claude Desktop automatically

5. **Wait for completion:**
   - You should see "Setup Complete!" message

#### macOS Setup

**Option A: Using Homebrew (Recommended)**

```bash
# Install GitHub MCP Server via Homebrew
brew install github/github/github-mcp-server

# Run our configuration script
chmod +x setup-unix.sh
./setup-unix.sh
```

**Option B: Manual Installation**

```bash
# Make the script executable
chmod +x setup-unix.sh

# Run the setup script
./setup-unix.sh
```

The script will:
- Download the GitHub MCP Server binary
- Install it to `/usr/local/bin` (may require sudo)
- Configure Claude Desktop with your token

#### Linux Setup

```bash
# Make the script executable
chmod +x setup-unix.sh

# Run the setup script
./setup-unix.sh
```

The script will:
- Download the appropriate Linux binary
- Install it to `/usr/local/bin` (may require sudo)
- Configure Claude Desktop

---

### Step 5: Restart Claude Desktop

**IMPORTANT:** You MUST restart Claude Desktop for changes to take effect.

1. **Completely Quit Claude Desktop:**
   - Don't just close the window
   - **Windows:** Right-click taskbar icon → "Quit" or use Task Manager
   - **macOS:** Cmd+Q or Claude menu → "Quit Claude"
   - **Linux:** Close the application completely

2. **Verify it's closed:**
   - Check Task Manager / Activity Monitor
   - Ensure no Claude processes are running

3. **Reopen Claude Desktop:**
   - Launch Claude Desktop normally
   - Wait for it to fully load

4. **Look for MCP Connection:**
   - Some versions show an MCP indicator
   - The GitHub server should connect automatically

---

### Step 6: Test Your Setup

In Claude Desktop, try these commands:

**Basic Test:**
```
List my GitHub repositories
```

**Expected Result:** Claude should show your repositories with details.

**Additional Tests:**
```
Show me my starred repositories
```

```
Search for issues in github/github-mcp-server
```

```
What GitHub tools are available?
```

If these work, **congratulations!** 🎉 Your setup is complete!

---

## Platform-Specific Instructions

### Windows Detailed Steps

**Binary Location:**
```
C:\Users\<YourUsername>\AppData\Local\Programs\github-mcp-server\github-mcp-server.exe
```

**Claude Config Location:**
```
C:\Users\<YourUsername>\AppData\Roaming\Claude\claude_desktop_config.json
```

**View Config:**
```powershell
Get-Content $env:APPDATA\Claude\claude_desktop_config.json
```

**Test Binary:**
```powershell
$env:GITHUB_PERSONAL_ACCESS_TOKEN = "your_token"
& "$env:LOCALAPPDATA\Programs\github-mcp-server\github-mcp-server.exe"
```

### macOS Detailed Steps

**Binary Location (Homebrew):**
```
/opt/homebrew/bin/github-mcp-server
# or
/usr/local/bin/github-mcp-server
```

**Claude Config Location:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**View Config:**
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Test Binary:**
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
github-mcp-server
```

### Linux Detailed Steps

**Binary Location:**
```
/usr/local/bin/github-mcp-server
```

**Claude Config Location:**
```
~/.config/Claude/claude_desktop_config.json
```

**View Config:**
```bash
cat ~/.config/Claude/claude_desktop_config.json
```

**Test Binary:**
```bash
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
github-mcp-server
```

---

## Configuration

### Claude Desktop Configuration Format

The setup script creates this configuration:

```json
{
  "mcpServers": {
    "github": {
      "command": "<path_to_github_mcp_server>",
      "args": [],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<your_token>"
      }
    }
  }
}
```

### Manual Configuration

If the automatic setup doesn't work, manually edit the Claude Desktop config:

**Windows:**
```powershell
notepad %APPDATA%\Claude\claude_desktop_config.json
```

**macOS/Linux:**
```bash
# macOS
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
nano ~/.config/Claude/claude_desktop_config.json
```

**Add this configuration:**
```json
{
  "mcpServers": {
    "github": {
      "command": "/path/to/github-mcp-server",
      "args": [],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

**Important:**
- Windows paths need double backslashes: `C:\\Users\\...`
- Use the actual full path to the binary
- Use your actual GitHub token

---

## Testing

### Verify Installation

**1. Check Binary Exists:**

Windows:
```powershell
Test-Path "$env:LOCALAPPDATA\Programs\github-mcp-server\github-mcp-server.exe"
```

macOS/Linux:
```bash
which github-mcp-server
# or
ls -l /usr/local/bin/github-mcp-server
```

**2. Check Config File:**

Windows:
```powershell
Test-Path "$env:APPDATA\Claude\claude_desktop_config.json"
```

macOS/Linux:
```bash
# macOS
ls -l ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
ls -l ~/.config/Claude/claude_desktop_config.json
```

**3. Test Token:**

```bash
# All platforms (use Git Bash on Windows or PowerShell with proper syntax)
curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user
```

Should return your GitHub user information.

### Test Commands in Claude

Try these in order:

1. **Basic test:**
   ```
   List my GitHub repositories
   ```

2. **Search test:**
   ```
   Search for recent issues in github/github-mcp-server
   ```

3. **Info test:**
   ```
   Tell me about the github-mcp-server repository
   ```

4. **List tools:**
   ```
   What GitHub operations can you perform?
   ```

---

## Advanced Configuration

### Read-Only Mode

If you only want to browse GitHub without making changes:

```json
{
  "mcpServers": {
    "github": {
      "command": "/path/to/github-mcp-server",
      "args": ["--read-only"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
      }
    }
  }
}
```

### Dynamic Toolsets (Beta)

Load tools on-demand instead of all at once:

```json
{
  "mcpServers": {
    "github": {
      "command": "/path/to/github-mcp-server",
      "args": ["--dynamic-toolsets"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
      }
    }
  }
}
```

### Lockdown Mode

Limit content from public repositories:

```json
{
  "mcpServers": {
    "github": {
      "command": "/path/to/github-mcp-server",
      "args": ["--lockdown-mode"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
      }
    }
  }
}
```

### Multiple Configurations

You can combine options:

```json
"args": ["--read-only", "--dynamic-toolsets"]
```

---

## Troubleshooting

### Common Issues

**Issue: "Command not found" or "Cannot find executable"**

**Solution:**
1. Verify the binary exists at the expected location
2. Check the path in `claude_desktop_config.json`
3. On Windows, ensure backslashes are escaped: `C:\\Users\\...`
4. Re-run the setup script

**Issue: "Authentication failed" or "401 Unauthorized"**

**Solution:**
1. Verify your token in the `.env` file
2. Check token hasn't expired at: https://github.com/settings/tokens
3. Ensure token has required scopes: `repo`, `workflow`, `read:org`
4. Test token with curl:
   ```bash
   curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user
   ```

**Issue: "Server not responding"**

**Solution:**
1. Completely quit and restart Claude Desktop
2. Check Claude logs:
   - Windows: `%APPDATA%\Claude\logs`
   - macOS: `~/Library/Logs/Claude`
   - Linux: `~/.config/Claude/logs`
3. Verify the binary runs manually (see platform-specific test commands above)

**Issue: "Tools not appearing in Claude"**

**Solution:**
1. Verify `claude_desktop_config.json` syntax is valid (use a JSON validator)
2. Check that Claude Desktop has been restarted (not just closed)
3. Look for error messages in Claude Desktop
4. Try regenerating the config with the setup script

### Getting More Help

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

Or check:
- **GitHub MCP Server Issues:** https://github.com/github/github-mcp-server/issues
- **MCP Documentation:** https://modelcontextprotocol.io

---

## Next Steps

### 1. Explore Example Prompts

See [EXAMPLE_PROMPTS.md](EXAMPLE_PROMPTS.md) for 50+ example commands like:

```
Create a summary of my GitHub activity this week
Find all TODO comments in my repositories
Analyze the security of my repositories
Create an issue in my-repo titled "Feature Request"
```

### 2. Learn the Quick Commands

Check [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for a quick reference card.

### 3. Customize Your Setup

- Add more MCP servers
- Configure read-only mode for safety
- Set up multiple GitHub accounts (if needed)

### 4. Automate Your Workflow

Use Claude to automate common GitHub tasks:
- Weekly activity summaries
- Automated issue triage
- PR review assistance
- Code search and analysis

---

## Security Best Practices

✅ **DO:**
- Keep your `.env` file secure
- Rotate tokens regularly (every 90 days)
- Use minimum required token scopes
- Revoke tokens you're not using
- Add `.env` to `.gitignore` (already done)

❌ **DON'T:**
- Commit `.env` to Git
- Share your token publicly
- Use tokens with more permissions than needed
- Leave old tokens active

**Manage Tokens:** https://github.com/settings/tokens

---

## Summary

You've successfully:
- ✅ Created a GitHub Personal Access Token
- ✅ Cloned this repository
- ✅ Configured your environment
- ✅ Installed GitHub MCP Server
- ✅ Configured Claude Desktop
- ✅ Tested the setup

**Now you can:**
- 🚀 Manage repositories through Claude
- 🐛 Create and manage issues
- 🔄 Work with pull requests
- 🔍 Search code across repositories
- ⚙️ Trigger GitHub Actions
- And much more!

---

## Additional Resources

- **GitHub MCP Server:** https://github.com/github/github-mcp-server
- **MCP Protocol:** https://modelcontextprotocol.io
- **GitHub API:** https://docs.github.com/rest
- **Claude Desktop:** https://claude.ai

---

**Happy coding! 🎉**

If you found this guide helpful, please ⭐ star this repository!

**Questions or issues?** Create an issue in this repository.

