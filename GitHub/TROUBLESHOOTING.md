# Troubleshooting Guide - GitHub MCP Server

## Common Issues and Solutions

### 1. "Command not found" or "Cannot find executable"

**Symptoms:**
- Claude Desktop shows "MCP server failed to start"
- Error message mentions missing command or file

**Solutions:**

**Windows:**
1. Verify the path in your config:
   ```powershell
   Test-Path "C:\Program Files\github-mcp-server\github-mcp-server.exe"
   ```
2. If false, find where you extracted the file
3. Update `claude_desktop_config.json` with the correct path
4. Remember to escape backslashes: `C:\\Program Files\\...`

**macOS/Linux:**
1. Check if the binary exists:
   ```bash
   which github-mcp-server
   # or
   ls -l /usr/local/bin/github-mcp-server
   ```
2. Verify it's executable:
   ```bash
   chmod +x /usr/local/bin/github-mcp-server
   ```

### 2. "Authentication failed" or "401 Unauthorized"

**Symptoms:**
- Tools fail with authentication errors
- "Bad credentials" message

**Solutions:**

1. **Verify your token is correct:**
   - No extra spaces before/after
   - Complete token string copied
   - Token hasn't been revoked

2. **Check token scopes:**
   - Visit: https://github.com/settings/tokens
   - Click on your token
   - Ensure these scopes are enabled:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
     - ✅ `read:org` (Read org and team membership)

3. **Test your token manually:**
   ```bash
   curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user
   ```
   Should return your user information.

4. **Generate a new token:**
   - Old token might be expired or revoked
   - Create a new one at: https://github.com/settings/tokens/new

### 3. "Server not responding" or "Connection timeout"

**Symptoms:**
- Claude shows "MCP server is not responding"
- Long delays before errors

**Solutions:**

1. **Restart Claude Desktop:**
   - Completely quit Claude (not just close window)
   - Reopen Claude Desktop

2. **Check Claude logs:**
   - **Windows:** `%APPDATA%\Claude\logs`
   - **macOS:** `~/Library/Logs/Claude`
   - **Linux:** `~/.config/Claude/logs`
   - Look for error messages

3. **Test the server manually:**
   ```bash
   # Set your token temporarily
   export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
   
   # Run the server
   github-mcp-server
   ```
   Should show no errors and wait for input.

4. **Check firewall/antivirus:**
   - Some security software blocks local server communication
   - Try temporarily disabling to test

### 4. "Permission denied" errors

**Symptoms:**
- Cannot create/modify issues, PRs, etc.
- "Resource not accessible by personal access token"

**Solutions:**

1. **Verify repository access:**
   - You need appropriate permissions on the repository
   - For private repos, token needs `repo` scope
   - For organizations, you might need admin approval

2. **Check organization settings:**
   - Some orgs restrict token access
   - Visit: https://github.com/settings/connections/applications
   - Check if your organization has approved the token

3. **Use fine-grained tokens (alternative):**
   - Create a fine-grained token with specific repo access
   - Visit: https://github.com/settings/tokens?type=beta

### 5. Config file not loading

**Symptoms:**
- GitHub tools not appearing in Claude
- Server not starting

**Solutions:**

1. **Verify config file location:**
   - **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
   - **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
   - **Linux:** `~/.config/Claude/claude_desktop_config.json`

2. **Check JSON syntax:**
   - Use a JSON validator: https://jsonlint.com
   - Common mistakes:
     - Missing commas between properties
     - Extra commas at end of objects
     - Unescaped backslashes in paths

3. **Example valid config:**
   ```json
   {
     "mcpServers": {
       "github": {
         "command": "path/to/github-mcp-server",
         "args": [],
         "env": {
           "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
         }
       }
     }
   }
   ```

### 6. "Too many requests" or "Rate limit exceeded"

**Symptoms:**
- Error 429 responses
- "API rate limit exceeded" message

**Solutions:**

1. **Wait for rate limit reset:**
   - GitHub has rate limits: 5,000 requests/hour for authenticated users
   - Check remaining: https://api.github.com/rate_limit

2. **Optimize your queries:**
   - Use more specific searches
   - Avoid repeated requests
   - Cache results when possible

3. **Check if token is being shared:**
   - Each user should have their own token
   - Shared tokens hit limits faster

### 7. Docker-specific issues

**Symptoms:**
- Docker container fails to start
- "Cannot connect to Docker daemon"

**Solutions:**

1. **Verify Docker is running:**
   ```bash
   docker ps
   ```

2. **Pull latest image:**
   ```bash
   docker pull ghcr.io/github/github-mcp-server:latest
   ```

3. **Check environment variables:**
   ```bash
   docker run -i --rm \
     -e GITHUB_PERSONAL_ACCESS_TOKEN=your_token \
     ghcr.io/github/github-mcp-server
   ```

4. **Try running interactively:**
   ```bash
   docker run -it --rm \
     -e GITHUB_PERSONAL_ACCESS_TOKEN=your_token \
     ghcr.io/github/github-mcp-server
   ```

### 8. Tools not appearing in Claude

**Symptoms:**
- Claude doesn't recognize GitHub commands
- No MCP tools available

**Solutions:**

1. **Verify server is configured:**
   - Check `claude_desktop_config.json` exists
   - Server configuration is under `mcpServers`

2. **Restart Claude Desktop:**
   - Fully quit and reopen
   - Config is only read on startup

3. **Check Claude's MCP status:**
   - In Claude Desktop, look for MCP indicator
   - Should show "GitHub" server connected

4. **Test with explicit prompt:**
   - "List my GitHub repositories"
   - "What MCP tools are available?"

### 9. Binary won't run on macOS

**Symptoms:**
- "cannot be opened because the developer cannot be verified"
- Security warning prevents execution

**Solutions:**

1. **Remove quarantine attribute:**
   ```bash
   xattr -d com.apple.quarantine /path/to/github-mcp-server
   ```

2. **Or allow in System Preferences:**
   - System Preferences → Security & Privacy
   - Click "Allow Anyway" for github-mcp-server

3. **Install via Homebrew (recommended):**
   ```bash
   brew install github/github/github-mcp-server
   ```
   Homebrew-installed binaries are automatically trusted.

### 10. Slow performance

**Symptoms:**
- Requests take very long
- Timeouts occur frequently

**Solutions:**

1. **Check internet connection:**
   - GitHub API requires good connectivity
   - Test: `ping api.github.com`

2. **Use read-only mode for browsing:**
   ```json
   {
     "mcpServers": {
       "github": {
         "command": "path/to/github-mcp-server",
         "args": ["--read-only"],
         "env": {
           "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
         }
       }
     }
   }
   ```

3. **Enable dynamic toolsets (beta):**
   - Loads tools on-demand instead of all at once
   - Add `"args": ["--dynamic-toolsets"]`

## Getting More Help

### Check Logs

**Claude Desktop Logs:**
- Windows: `%APPDATA%\Claude\logs\`
- macOS: `~/Library/Logs/Claude/`
- Linux: `~/.config/Claude/logs/`

### Test Manually

Run the server directly to see errors:

```bash
# Set token
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"

# Run server
github-mcp-server

# Should wait for input without errors
```

### GitHub API Status

Check if GitHub is experiencing issues:
- https://www.githubstatus.com

### Community Resources

- **GitHub MCP Server Issues:** https://github.com/github/github-mcp-server/issues
- **MCP Documentation:** https://modelcontextprotocol.io
- **GitHub API Status:** https://www.githubstatus.com

### Debug Mode

Run with verbose logging:

```bash
export GITHUB_MCP_DEBUG=1
export GITHUB_PERSONAL_ACCESS_TOKEN="your_token"
github-mcp-server
```

## Still Having Issues?

1. **Gather information:**
   - Operating system and version
   - GitHub MCP Server version
   - Claude Desktop version
   - Error messages from logs
   - Your configuration (with token redacted!)

2. **Search existing issues:**
   - https://github.com/github/github-mcp-server/issues

3. **Create a new issue:**
   - Provide all gathered information
   - Include steps to reproduce
   - Redact all tokens and sensitive data

## Security Notes

- **Never share your token publicly**
- **Never commit tokens to version control**
- **Rotate tokens regularly**
- **Use minimal required scopes**
- **Revoke tokens you're not using:** https://github.com/settings/tokens

