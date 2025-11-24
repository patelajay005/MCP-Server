# GitHub MCP Server Setup Script for Windows
# This script automatically downloads, installs, and configures GitHub MCP Server for Claude Desktop

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GitHub MCP Server Setup for Windows  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$version = "v0.21.0"
$downloadUrl = "https://github.com/github/github-mcp-server/releases/download/$version/github-mcp-server_Windows_x86_64.zip"
$installDir = "$env:LOCALAPPDATA\Programs\github-mcp-server"
$zipPath = "$env:TEMP\github-mcp-server.zip"
$exePath = "$installDir\github-mcp-server.exe"
$claudeConfigDir = "$env:APPDATA\Claude"
$claudeConfigPath = "$claudeConfigDir\claude_desktop_config.json"

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Not running as administrator. Installation may fail if permissions are required." -ForegroundColor Yellow
    Write-Host ""
}

# Step 1: Check for .env file
Write-Host "[1/6] Checking for GitHub token..." -ForegroundColor Yellow
if (-not (Test-Path ".env")) {
    Write-Host "Error: .env file not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please create a .env file with your GitHub Personal Access Token:" -ForegroundColor Yellow
    Write-Host "  1. Copy .env.example to .env" -ForegroundColor White
    Write-Host "  2. Edit .env and add your token" -ForegroundColor White
    Write-Host "  3. Get token from: https://github.com/settings/tokens/new" -ForegroundColor White
    Write-Host ""
    exit 1
}

# Load token from .env
$token = ""
$envContent = Get-Content ".env"
foreach ($line in $envContent) {
    if ($line -match "^GITHUB_PERSONAL_ACCESS_TOKEN=(.+)$") {
        $token = $Matches[1].Trim()
        break
    }
}

if (-not $token -or $token -eq "your_github_token_here") {
    Write-Host "Error: GitHub token not found or not configured in .env file!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please edit .env and add your GitHub Personal Access Token" -ForegroundColor Yellow
    Write-Host "Get your token from: https://github.com/settings/tokens/new" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host "Token found: $($token.Substring(0, 8))..." -ForegroundColor Green
Write-Host ""

# Step 2: Validate token
Write-Host "[2/6] Validating GitHub token..." -ForegroundColor Yellow
try {
    $headers = @{
        Authorization = "token $token"
        Accept = "application/vnd.github.v3+json"
    }
    $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers -ErrorAction Stop
    Write-Host "Token valid! Authenticated as: $($user.login)" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "Error: Invalid GitHub token!" -ForegroundColor Red
    Write-Host "Please check your token and ensure it has the required scopes." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Step 3: Download GitHub MCP Server
Write-Host "[3/6] Downloading GitHub MCP Server $version..." -ForegroundColor Yellow

# Create installation directory
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop
    Write-Host "Download complete!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "Error downloading GitHub MCP Server: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please check your internet connection and try again." -ForegroundColor Yellow
    Write-Host "Or download manually from: https://github.com/github/github-mcp-server/releases" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Step 4: Extract and install
Write-Host "[4/6] Installing GitHub MCP Server..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $zipPath -DestinationPath $installDir -Force -ErrorAction Stop
    Remove-Item $zipPath
    Write-Host "Installation complete!" -ForegroundColor Green
    Write-Host "Installed to: $exePath" -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "Error extracting files: $_" -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Verify installation
if (-not (Test-Path $exePath)) {
    Write-Host "Error: Installation failed. Binary not found at expected location." -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Step 5: Configure Claude Desktop
Write-Host "[5/6] Configuring Claude Desktop..." -ForegroundColor Yellow

# Create Claude config directory if needed
if (-not (Test-Path $claudeConfigDir)) {
    New-Item -ItemType Directory -Path $claudeConfigDir -Force | Out-Null
}

# Escape backslashes for JSON
$exePathJson = $exePath -replace '\\', '\\'

# Create configuration object
$config = @{
    mcpServers = @{
        github = @{
            command = $exePathJson
            args = @()
            env = @{
                GITHUB_PERSONAL_ACCESS_TOKEN = $token
            }
        }
    }
}

# Check if config exists and merge
if (Test-Path $claudeConfigPath) {
    Write-Host "Existing Claude config found. Updating..." -ForegroundColor Yellow
    try {
        $existingConfig = Get-Content $claudeConfigPath -Raw | ConvertFrom-Json
        
        if (-not $existingConfig.mcpServers) {
            $existingConfig | Add-Member -NotePropertyName mcpServers -NotePropertyValue @{} -Force
        }
        
        $existingConfig.mcpServers.github = $config.mcpServers.github
        $config = $existingConfig
    } catch {
        Write-Host "Warning: Could not parse existing config. Creating new one..." -ForegroundColor Yellow
    }
}

# Write configuration
try {
    $config | ConvertTo-Json -Depth 10 | Set-Content -Path $claudeConfigPath -Encoding UTF8
    Write-Host "Claude Desktop configured!" -ForegroundColor Green
    Write-Host "Config file: $claudeConfigPath" -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "Error writing Claude config: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please manually create the config file at:" -ForegroundColor Yellow
    Write-Host "  $claudeConfigPath" -ForegroundColor White
    Write-Host ""
    exit 1
}

# Step 6: Verify setup
Write-Host "[6/6] Verifying setup..." -ForegroundColor Yellow

$allGood = $true

# Check binary
if (Test-Path $exePath) {
    Write-Host "  Binary installed" -ForegroundColor Green -NoNewline
    Write-Host " - $exePath" -ForegroundColor Gray
} else {
    Write-Host "  Binary NOT found" -ForegroundColor Red
    $allGood = $false
}

# Check config
if (Test-Path $claudeConfigPath) {
    Write-Host "  Claude config created" -ForegroundColor Green -NoNewline
    Write-Host " - $claudeConfigPath" -ForegroundColor Gray
} else {
    Write-Host "  Claude config NOT found" -ForegroundColor Red
    $allGood = $false
}

# Check token
if ($token) {
    Write-Host "  GitHub token configured" -ForegroundColor Green -NoNewline
    Write-Host " - Token: $($token.Substring(0, 10))..." -ForegroundColor Gray
} else {
    Write-Host "  GitHub token NOT configured" -ForegroundColor Red
    $allGood = $false
}

Write-Host ""

if ($allGood) {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  Setup Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  1. RESTART Claude Desktop (completely quit and reopen)" -ForegroundColor White
    Write-Host "  2. Wait for Claude to fully start" -ForegroundColor White
    Write-Host "  3. Try asking: 'List my GitHub repositories'" -ForegroundColor White
    Write-Host ""
    Write-Host "Documentation:" -ForegroundColor Yellow
    Write-Host "  - SETUP_GUIDE.md    - Complete setup guide" -ForegroundColor White
    Write-Host "  - EXAMPLE_PROMPTS.md - 50+ example commands" -ForegroundColor White
    Write-Host "  - TROUBLESHOOTING.md - Problem solving" -ForegroundColor White
    Write-Host ""
    Write-Host "If you encounter issues, see TROUBLESHOOTING.md" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "  Setup incomplete - please fix errors  " -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "See TROUBLESHOOTING.md for help" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

