# Contributing to MCP-Server

Thank you for your interest in contributing to the MCP-Server collection!

## 🔒 Branch Protection Policy

The `main` branch is **protected** and requires pull requests for all changes.

### Branch Strategy

```
main            ← Protected branch (production-ready)
  ↑
  PR (Pull Request)
  ↑
development     ← Active development branch
  ↑
feature/*       ← Feature branches
```

---

## 📋 How to Contribute

### 1. Fork or Clone the Repository

```bash
git clone https://github.com/patelajay005/MCP-Server.git
cd MCP-Server
```

### 2. Create a Feature Branch from `development`

```bash
# Switch to development branch
git checkout development

# Pull latest changes
git pull origin development

# Create your feature branch
git checkout -b feature/your-feature-name
```

**Branch naming conventions:**
- `feature/` - New features (e.g., `feature/gitlab-mcp-setup`)
- `fix/` - Bug fixes (e.g., `fix/setup-script-error`)
- `docs/` - Documentation updates (e.g., `docs/update-readme`)
- `refactor/` - Code refactoring (e.g., `refactor/organize-scripts`)

### 3. Make Your Changes

```bash
# Make your changes to files
# Test your changes thoroughly

# Stage your changes
git add .

# Commit with a meaningful message
git commit -m "feature: Add GitLab MCP server setup"
```

**Commit message format:**
```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feature:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

### 4. Push to Your Branch

```bash
git push origin feature/your-feature-name
```

### 5. Create a Pull Request

1. Go to: https://github.com/patelajay005/MCP-Server
2. Click "**Compare & pull request**" button
3. **Base branch:** `development` (not `main`!)
4. **Compare branch:** your feature branch
5. Fill in the PR template:
   - **Title:** Clear, descriptive title
   - **Description:** What changes were made and why
   - **Testing:** How you tested the changes
6. Click "**Create pull request**"

### 6. Code Review Process

- Your PR will be reviewed
- Address any requested changes
- Once approved, it will be merged into `development`
- Periodically, `development` will be merged to `main`

---

## 🚫 Direct Commits to Main

**Direct commits to `main` are NOT allowed.**

All changes must go through:
1. Feature branch → PR → `development`
2. `development` → PR → `main` (periodic releases)

---

## 📝 Pull Request Checklist

Before creating a PR, ensure:

- [ ] Code follows the project's style guidelines
- [ ] Documentation is updated (if applicable)
- [ ] No sensitive data (tokens, passwords) in commits
- [ ] `.env.example` is updated (if environment variables changed)
- [ ] Setup scripts tested on target platform
- [ ] README or guides updated with new features
- [ ] No merge conflicts with target branch
- [ ] Commit messages are clear and descriptive

---

## 🔍 What to Contribute

### Current Priorities

1. **New MCP Server Setups**
   - GitLab MCP Server
   - Jira MCP Server
   - Slack MCP Server
   - Custom MCP Servers

2. **Improvements to Existing Setups**
   - Better error handling in scripts
   - Additional platform support
   - More example prompts
   - Enhanced documentation

3. **Documentation**
   - Video tutorials
   - Troubleshooting guides
   - Use case examples
   - Translation to other languages

### Directory Structure for New MCP Servers

When adding a new MCP server, follow this structure:

```
MCP-Server/
└── NewServer/              # Name of the MCP server
    ├── README.md           # Overview and quick start
    ├── SETUP_GUIDE.md      # Detailed setup instructions
    ├── PREREQUISITES.md    # Requirements
    ├── .env.example        # Environment template
    ├── .gitignore          # Protection rules
    ├── setup-windows.ps1   # Windows setup script
    ├── setup-unix.sh       # macOS/Linux setup script
    ├── EXAMPLE_PROMPTS.md  # Example commands
    ├── TROUBLESHOOTING.md  # Common issues
    └── QUICK_REFERENCE.md  # Quick commands
```

---

## 🐛 Reporting Issues

Found a bug? Have a suggestion?

1. Check if the issue already exists
2. If not, create a new issue with:
   - Clear title
   - Detailed description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - System information (OS, version, etc.)
   - Relevant logs or screenshots

---

## 💬 Questions?

- Open an issue for discussion
- Check existing issues and PRs
- Review the documentation

---

## 📜 Code of Conduct

Be respectful and professional:
- Be welcoming to newcomers
- Respect differing viewpoints
- Accept constructive criticism
- Focus on what's best for the community

---

## 🙏 Thank You!

Your contributions help make MCP server setup easier for everyone!

---

**Repository:** https://github.com/patelajay005/MCP-Server  
**Maintained by:** [patelajay005](https://github.com/patelajay005)

