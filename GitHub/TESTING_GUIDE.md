# Testing Guide for GitHub MCP Server

This guide helps you test the GitHub MCP Server setup to ensure everything is working correctly.

## 🧪 Testing Checklist

Use this checklist to verify your GitHub MCP Server installation:

### 1. Environment Setup Tests

- [ ] `.env` file exists with `GITHUB_PERSONAL_ACCESS_TOKEN`
- [ ] Token format is correct (starts with `ghp_`)
- [ ] `.env` is listed in `.gitignore`
- [ ] `.env.example` exists with placeholder values

### 2. GitHub API Access Tests

Test if your token can access GitHub API:

```bash
# Windows PowerShell
$token = (Get-Content .env | Where-Object { $_ -match 'GITHUB_PERSONAL_ACCESS_TOKEN=(.+)' } | ForEach-Object { $_ -replace 'GITHUB_PERSONAL_ACCESS_TOKEN=', '' }).Trim()
$headers = @{ Authorization = "Bearer $token" }
Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
```

```bash
# macOS/Linux
TOKEN=$(grep GITHUB_PERSONAL_ACCESS_TOKEN .env | cut -d '=' -f2)
curl -H "Authorization: Bearer $TOKEN" https://api.github.com/user
```

**Expected Result:** Should return your GitHub user information.

### 3. Repository Access Tests

Test if you can list your repositories:

```bash
# Windows PowerShell
$token = (Get-Content .env | Where-Object { $_ -match 'GITHUB_PERSONAL_ACCESS_TOKEN=(.+)' } | ForEach-Object { $_ -replace 'GITHUB_PERSONAL_ACCESS_TOKEN=', '' }).Trim()
$headers = @{ Authorization = "Bearer $token" }
Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Headers $headers | Select-Object -First 5 | Select-Object name, private, updated_at
```

```bash
# macOS/Linux
TOKEN=$(grep GITHUB_PERSONAL_ACCESS_TOKEN .env | cut -d '=' -f2)
curl -H "Authorization: Bearer $TOKEN" https://api.github.com/user/repos | jq '.[] | {name, private, updated_at}' | head -20
```

**Expected Result:** Should list your GitHub repositories.

### 4. Claude Desktop Integration Tests

#### Test 1: Check Configuration File

**Windows:**
```bash
Get-Content "$env:APPDATA\Claude\claude_desktop_config.json"
```

**macOS:**
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Expected Result:** Should show MCP server configuration.

#### Test 2: Restart Claude Desktop

1. Quit Claude Desktop completely
2. Reopen Claude Desktop
3. Check for the 🔌 icon or tools indicator

#### Test 3: Test MCP Commands

In Claude Desktop, try these prompts:

1. **List repositories:**
   ```
   Can you list my GitHub repositories?
   ```

2. **Get repository details:**
   ```
   Show me details about my MCP-Server repository
   ```

3. **List issues:**
   ```
   What are the open issues in patelajay005/MCP-Server?
   ```

4. **Search code:**
   ```
   Search for "GitHub" in my MCP-Server repository
   ```

5. **Create an issue (optional):**
   ```
   Create a test issue in my MCP-Server repository with title "Test Issue" and body "This is a test"
   ```

### 5. Common Test Scenarios

#### Scenario 1: New Repository
```
Create a test repository named "mcp-test-repo" with description "Testing MCP Server"
```

#### Scenario 2: File Operations
```
List files in the main branch of my MCP-Server repository
```

#### Scenario 3: Pull Requests
```
Show me all open pull requests in patelajay005/MCP-Server
```

#### Scenario 4: Commits
```
Show me the latest commits in my MCP-Server repository
```

---

## 🔍 Troubleshooting Tests

### Test: Token Validation

```bash
# Check if token is valid
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.github.com/user
```

**If fails:** Token is invalid or expired. Generate a new token.

### Test: Permissions

```bash
# Check token scopes
curl -I -H "Authorization: Bearer YOUR_TOKEN" https://api.github.com/user
# Look for X-OAuth-Scopes header
```

**Expected Scopes:** `repo`, `user`, `workflow` (minimum)

### Test: Rate Limits

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" https://api.github.com/rate_limit
```

**Expected Result:** Should show remaining API calls.

---

## ✅ Success Indicators

Your setup is working correctly if:

1. ✅ GitHub API responds with your user information
2. ✅ You can list your repositories
3. ✅ Claude Desktop shows MCP tools/plugins icon
4. ✅ Claude can execute GitHub commands
5. ✅ No authentication errors

---

## 🚫 Common Issues

### Issue 1: "Authentication failed"
**Solution:** Check if token is correct in `.env` file

### Issue 2: "Rate limit exceeded"
**Solution:** Wait an hour or use a token (5000 requests/hour with token vs 60 without)

### Issue 3: "Repository not found"
**Solution:** Check token has `repo` scope

### Issue 4: Claude doesn't show MCP tools
**Solution:** 
- Restart Claude Desktop
- Check `claude_desktop_config.json` syntax
- Verify GitHub MCP server path is correct

---

## 📊 Test Report Template

After testing, document your results:

```
Testing Date: [DATE]
Tester: [YOUR NAME]

Environment Setup: ✅ / ❌
GitHub API Access: ✅ / ❌
Repository Access: ✅ / ❌
Claude Integration: ✅ / ❌
MCP Commands: ✅ / ❌

Issues Found:
1. [Issue description]
2. [Issue description]

Notes:
[Any additional notes]
```

---

## 🔄 Automated Testing Script

### Windows PowerShell

```powershell
# Test script for GitHub MCP Server
Write-Host "Testing GitHub MCP Server Setup..." -ForegroundColor Cyan

# Test 1: Check .env file
if (Test-Path ".env") {
    Write-Host "✅ .env file exists" -ForegroundColor Green
    $token = (Get-Content .env | Where-Object { $_ -match 'GITHUB_PERSONAL_ACCESS_TOKEN=(.+)' } | ForEach-Object { $_ -replace 'GITHUB_PERSONAL_ACCESS_TOKEN=', '' }).Trim()
    if ($token -match '^ghp_') {
        Write-Host "✅ Token format is correct" -ForegroundColor Green
    } else {
        Write-Host "❌ Token format is incorrect" -ForegroundColor Red
    }
} else {
    Write-Host "❌ .env file not found" -ForegroundColor Red
}

# Test 2: GitHub API
try {
    $headers = @{ Authorization = "Bearer $token" }
    $user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
    Write-Host "✅ GitHub API access successful" -ForegroundColor Green
    Write-Host "   Logged in as: $($user.login)" -ForegroundColor Cyan
} catch {
    Write-Host "❌ GitHub API access failed" -ForegroundColor Red
}

# Test 3: Repository access
try {
    $repos = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Headers $headers
    Write-Host "✅ Repository access successful" -ForegroundColor Green
    Write-Host "   Found $($repos.Count) repositories" -ForegroundColor Cyan
} catch {
    Write-Host "❌ Repository access failed" -ForegroundColor Red
}

Write-Host "`nTesting complete!" -ForegroundColor Green
```

### macOS/Linux Bash

```bash
#!/bin/bash
# Test script for GitHub MCP Server

echo "Testing GitHub MCP Server Setup..."

# Test 1: Check .env file
if [ -f ".env" ]; then
    echo "✅ .env file exists"
    TOKEN=$(grep GITHUB_PERSONAL_ACCESS_TOKEN .env | cut -d '=' -f2)
    if [[ $TOKEN == ghp_* ]]; then
        echo "✅ Token format is correct"
    else
        echo "❌ Token format is incorrect"
    fi
else
    echo "❌ .env file not found"
fi

# Test 2: GitHub API
if curl -s -H "Authorization: Bearer $TOKEN" https://api.github.com/user > /dev/null; then
    echo "✅ GitHub API access successful"
    USER=$(curl -s -H "Authorization: Bearer $TOKEN" https://api.github.com/user | jq -r '.login')
    echo "   Logged in as: $USER"
else
    echo "❌ GitHub API access failed"
fi

# Test 3: Repository access
REPOS=$(curl -s -H "Authorization: Bearer $TOKEN" https://api.github.com/user/repos | jq '. | length')
if [ "$REPOS" -gt 0 ]; then
    echo "✅ Repository access successful"
    echo "   Found $REPOS repositories"
else
    echo "❌ Repository access failed"
fi

echo ""
echo "Testing complete!"
```

---

## 📚 Additional Resources

- **GitHub API Documentation:** https://docs.github.com/en/rest
- **MCP Protocol:** https://modelcontextprotocol.io/
- **Claude Desktop:** https://claude.ai/desktop
- **Troubleshooting:** See `TROUBLESHOOTING.md` in this directory

---

**Last Updated:** November 24, 2025  
**Version:** 1.0  
**Maintainer:** [patelajay005](https://github.com/patelajay005)

