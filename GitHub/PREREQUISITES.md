# Prerequisites for GitHub MCP Server Setup

**Before you begin setup, ensure you have all of these requirements met.**

---

## ✅ Required Prerequisites

### 1. GitHub Account 🔑

**What:** A GitHub account to access repositories  
**Why:** The MCP server needs to connect to GitHub on your behalf  
**Get it:** [Sign up at GitHub](https://github.com/signup) (free)  
**Verify:** You can log in at [github.com](https://github.com)

---

### 2. GitHub Personal Access Token (PAT) 🎫

**What:** A secure token that authenticates the MCP server  
**Why:** Allows the server to access your repositories securely  
**Get it:** [Create token](https://github.com/settings/tokens/new)

**Required Scopes:**
- ✅ `repo` - Full control of private repositories
- ✅ `workflow` - Update GitHub Action workflows
- ✅ `read:org` - Read org and team membership

**Note:** You'll create this during setup (Step 1 of SETUP_GUIDE.md)

**Security:** Never share this token or commit it to Git!

---

### 3. MCP-Compatible Client (Claude Desktop Recommended) 💬

**What:** An application that supports the Model Context Protocol (MCP)  
**Why:** The GitHub MCP Server needs a host application to communicate with  
**Recommended:** [Claude Desktop](https://claude.ai/download) by Anthropic

**About Claude Desktop:**
- ✅ **Primary MCP host** supported by this repository
- ✅ Available for Windows, macOS, and Linux
- ✅ Version 0.5.0 or later required
- ✅ Setup scripts auto-configure for Claude Desktop

**Alternative MCP Clients:**
While this repository is configured for Claude Desktop, the GitHub MCP Server follows the standard MCP protocol and can work with other MCP-compatible clients:
- Other AI assistants that support MCP
- Custom MCP implementations
- Future MCP-compatible applications

**Note:** If using a different MCP client, you'll need to manually configure it following the MCP protocol specification.

**For This Setup:**
- Download and install [Claude Desktop](https://claude.ai/download)
- Run it at least once before setup
- Verify it opens successfully

---

## 💻 System Requirements

### For Windows Users

**Operating System:**
- ✅ Windows 10 or later
- ✅ Windows 11 (recommended)

**Software:**
- ✅ PowerShell 5.1 or later (included with Windows 10+)
- ✅ Administrator access (needed for installation)

**Check PowerShell Version:**
```powershell
$PSVersionTable.PSVersion
# Should show 5.1 or higher
```

---

### For macOS Users

**Operating System:**
- ✅ macOS 10.15 (Catalina) or later
- ✅ macOS 11 (Big Sur) or later recommended

**Software:**
- ✅ Terminal (built-in)
- ✅ Homebrew (optional but recommended)

**Install Homebrew (optional):**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Architecture Support:**
- ✅ Intel (x86_64)
- ✅ Apple Silicon (M1/M2/M3)

---

### For Linux Users

**Operating System:**
- ✅ Any modern Linux distribution
  - Ubuntu 20.04+
  - Debian 10+
  - Fedora 34+
  - CentOS 8+
  - Arch Linux
  - Others should work fine

**Software:**
- ✅ Bash shell (usually pre-installed)
- ✅ curl or wget (for downloading)
- ✅ tar (for extracting)
- ✅ sudo access (for installation)

**Check Requirements:**
```bash
# Check if curl or wget is available
which curl || which wget

# Check if tar is available
which tar
```

---

## 🌐 Network Requirements

### Internet Connection
- ✅ Active internet connection required
- ✅ Access to github.com
- ✅ Access to api.github.com
- ✅ Ability to download from GitHub releases

### Firewall/Proxy
- ✅ Allow outbound HTTPS (port 443) to:
  - `github.com`
  - `api.github.com`
  - `ghcr.io` (for container images if using Docker)
- ✅ If behind corporate proxy, ensure it allows GitHub access

---

## 🔧 Optional but Recommended

### For Windows
- ✅ **Windows Terminal** - Better terminal experience
  - Download from Microsoft Store
  - Optional but provides better UI

### For macOS
- ✅ **Homebrew** - Package manager for easier installation
  - Recommended for automatic updates
  - Makes installation much simpler

### For All Platforms
- ✅ **Git** - For cloning this repository
  - Windows: [Download Git](https://git-scm.com/download/win)
  - macOS: Included with Xcode Command Line Tools
  - Linux: `sudo apt install git` or equivalent
  
- ✅ **Text Editor** - For editing `.env` file
  - Windows: Notepad (built-in) or VS Code
  - macOS: TextEdit (built-in) or VS Code
  - Linux: nano, vim, or VS Code

---

## 📦 Storage Requirements

**Disk Space Needed:**
- GitHub MCP Server binary: ~20-50 MB (varies by platform)
- Claude Desktop: ~200-500 MB
- This repository (cloned): ~1 MB
- **Total:** ~300-600 MB free space recommended

---

## 🎯 Skills/Knowledge Required

### Minimal Technical Knowledge Needed

**Required:**
- ✅ Ability to open a terminal/command prompt
- ✅ Ability to copy and paste commands
- ✅ Ability to edit a text file

**NOT Required:**
- ❌ Programming knowledge
- ❌ Understanding of MCP protocol
- ❌ Deep technical expertise
- ❌ Command-line expertise

**Note:** The setup scripts automate everything!

---

## ✅ Pre-Setup Checklist

Before running the setup, verify:

### Account Checks
- [ ] I have a GitHub account
- [ ] I can log in to GitHub
- [ ] I have access to my GitHub repositories

### Software Checks
- [ ] Claude Desktop is installed
- [ ] Claude Desktop opens successfully
- [ ] I have a terminal/PowerShell available

### System Checks
- [ ] My OS meets the minimum version
- [ ] I have internet connectivity
- [ ] I can access github.com
- [ ] I have ~500 MB free disk space

### Permission Checks
- [ ] **Windows:** I can run PowerShell as Administrator
- [ ] **macOS/Linux:** I have sudo access (if needed)

### Preparation Checks
- [ ] I've cloned or downloaded this repository
- [ ] I can see the setup scripts (setup-windows.ps1 or setup-unix.sh)
- [ ] I'm ready to create a GitHub Personal Access Token

---

## ❓ Frequently Asked Questions

### Q: Do I need a paid GitHub account?
**A:** No! A free GitHub account works perfectly. The MCP server works with both free and paid GitHub accounts.

### Q: Do I need a paid Claude Desktop subscription?
**A:** Check Claude's current offerings. MCP support may vary by plan.

### Q: Can I use this on a work computer behind a corporate firewall?
**A:** Yes, but you may need IT approval to:
- Install software (Claude Desktop, MCP Server)
- Access GitHub API
- Run PowerShell scripts (Windows)

### Q: Do I need programming knowledge?
**A:** No! The setup scripts automate everything. Just follow the steps.

### Q: Can I use multiple GitHub accounts?
**A:** You can only configure one token at a time, but you can create tokens for different accounts and switch between them.

### Q: What if I don't have administrator access?
**A:** 
- **Windows:** You may be able to install to user directories
- **macOS/Linux:** You can install to `~/bin` or `~/.local/bin`
- Or ask your system administrator to install for you

### Q: Do I need Docker?
**A:** No! This setup uses native binaries, not Docker.

---

## 🚀 Ready to Start?

If you've met all the prerequisites above, you're ready to begin!

### Next Steps:

1. **Read:** [SETUP_GUIDE.md](SETUP_GUIDE.md) for complete instructions
2. **Or Quick Start:** [README.md](README.md) for a faster setup
3. **Have Questions?** [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

### What You'll Do During Setup:

1. ✅ Create GitHub Personal Access Token (5 minutes)
2. ✅ Run automated setup script (2 minutes)
3. ✅ Restart Claude Desktop (30 seconds)
4. ✅ Test with a simple command (30 seconds)

**Total Time: ~10 minutes**

---

## 🔒 Security Requirements

### Keep These Secure:
- 🔑 Your GitHub Personal Access Token
- 🔑 Your `.env` file (contains the token)
- 🔑 Claude Desktop configuration file

### Best Practices:
- ✅ Never share your GitHub token
- ✅ Never commit `.env` to Git (it's in `.gitignore`)
- ✅ Rotate tokens every 90 days
- ✅ Use minimum required token scopes
- ✅ Revoke tokens you're not using

---

## 📞 Need Help?

### Before Setup:
- Check this prerequisites list
- Read the [README.md](README.md)
- Review [SETUP_GUIDE.md](SETUP_GUIDE.md)

### During Setup:
- Follow [SETUP_GUIDE.md](SETUP_GUIDE.md) step by step
- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) if errors occur

### After Setup:
- Try [EXAMPLE_PROMPTS.md](EXAMPLE_PROMPTS.md) for ideas
- Use [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for commands

---

## ✅ Summary

**Absolute Minimums:**
1. GitHub account
2. GitHub Personal Access Token  
3. Claude Desktop installed
4. Supported OS (Windows 10+, macOS 10.15+, Linux)
5. Internet connection

**That's it!** Everything else is automated by the setup scripts.

---

**Ready?** Head to [SETUP_GUIDE.md](SETUP_GUIDE.md) to begin! 🚀

---

*Last Updated: November 24, 2025*  
*Difficulty: Easy (Automated Setup)*  
*Time Required: ~10 minutes*

