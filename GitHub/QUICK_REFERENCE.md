# GitHub MCP Server - Quick Reference Card

## 🎯 Your Setup at a Glance

**Location:** `C:\Code\MCP\GIT Hub`  
**Your GitHub:** [https://github.com/patelajay005](https://github.com/patelajay005)

---

## ⚡ Quick Setup (3 Steps)

### 1. Get Token
Visit: [https://github.com/settings/tokens/new](https://github.com/settings/tokens/new)

**Required Scopes:**
- ✅ `repo` - Full control of private repositories
- ✅ `workflow` - Update GitHub Action workflows  
- ✅ `read:org` - Read org and team membership

### 2. Run Setup
```powershell
# Open PowerShell as Administrator
cd "C:\Code\MCP\GIT Hub"
.\setup.ps1
```

### 3. Restart Claude
- Quit Claude Desktop completely
- Reopen it
- Done! 🎉

---

## 📁 What's in This Directory?

| File | Purpose |
|------|---------|
| `START_HERE.md` | **Start here!** Complete overview |
| `QUICK_START.md` | 5-minute setup guide |
| `README.md` | Full documentation |
| `TROUBLESHOOTING.md` | Problem solutions |
| `EXAMPLE_PROMPTS.md` | 50+ example prompts |
| `setup.ps1` | Windows setup script |
| `setup.sh` | macOS/Linux setup script |
| `claude_desktop_config_example.json` | Config template |

---

## ✅ Test Commands

After setup, try these in Claude:

```
List my GitHub repositories
```

```
Show me my starred repositories
```

```
Search for recent issues in github/github-mcp-server
```

```
Create an issue in owner/repo titled "Test"
```

---

## 🔧 Configuration Location

**Claude Desktop Config:**
```
Windows: %APPDATA%\Claude\claude_desktop_config.json
macOS: ~/Library/Application Support/Claude/claude_desktop_config.json
Linux: ~/.config/Claude/claude_desktop_config.json
```

**Example Config:**
```json
{
  "mcpServers": {
    "github": {
      "command": "C:\\path\\to\\github-mcp-server.exe",
      "args": [],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

---

## 🛠️ Common Commands

### Repository Operations
```
List my repositories
Fork owner/repo to my account
Create a new repository called "my-project"
```

### Issue Management
```
List open issues in owner/repo
Create an issue in owner/repo titled "Bug: Something broke"
Add comment to issue #123 in owner/repo
```

### Pull Requests
```
List my open pull requests
Get details of PR #456 in owner/repo
Review PR #789 in owner/repo
```

### Code Search
```
Search for "function authenticate" in owner/repo
Find all TODO comments in owner/repo
Show me the README file in owner/repo
```

### Workflows
```
List GitHub Actions workflows in owner/repo
Trigger the "build" workflow in owner/repo
```

---

## 🚨 Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| Command not found | Check path in config file |
| Auth failed | Verify token has correct scopes |
| Server not responding | Restart Claude Desktop |
| No tools showing | Check config syntax, restart Claude |
| Permission denied | Check repo access & token scopes |

See `TROUBLESHOOTING.md` for detailed solutions.

---

## 🔒 Security Reminders

- ❌ Never commit your token to Git
- ✅ The `.gitignore` file protects you
- 🔄 Rotate tokens regularly
- 🗑️ Revoke unused tokens at: [https://github.com/settings/tokens](https://github.com/settings/tokens)

---

## 📚 More Resources

- **Official Repo:** [github.com/github/github-mcp-server](https://github.com/github/github-mcp-server)
- **MCP Docs:** [modelcontextprotocol.io](https://modelcontextprotocol.io)
- **GitHub API:** [docs.github.com/rest](https://docs.github.com/rest)

---

## 🎓 Example Use Cases

**Project Management:**
```
Show me all open issues assigned to me across all repos
```

**Code Review:**
```
Review PR #123 in owner/repo and summarize the changes
```

**Research:**
```
Find popular Python machine learning repositories
```

**Automation:**
```
Create a weekly summary of my GitHub activity
```

**Security:**
```
List security advisories for npm published this month
```

---

## 💡 Pro Tips

1. **Be specific:** Include repository owner and name
2. **Chain operations:** Ask for multiple things in one prompt
3. **Use examples:** Check `EXAMPLE_PROMPTS.md` for ideas
4. **Start simple:** Test basic commands first
5. **Ask Claude:** "What can I do with GitHub MCP?" for suggestions

---

**Ready to start?** Open `START_HERE.md` for the full guide!

*Last Updated: November 24, 2025*

