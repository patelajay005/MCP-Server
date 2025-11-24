# Branch Protection Setup Guide

This guide explains how to set up branch protection rules for the `main` branch on GitHub.

## 🔒 Why Branch Protection?

Branch protection ensures:
- ✅ No direct commits to `main`
- ✅ All changes go through pull requests
- ✅ Code review before merging
- ✅ Maintain code quality and stability
- ✅ Track all changes through PRs

---

## 📋 Steps to Enable Branch Protection

### Step 1: Access Repository Settings

1. Go to your repository: https://github.com/patelajay005/MCP-Server
2. Click **"Settings"** tab (top right)
3. In the left sidebar, click **"Branches"** (under "Code and automation")

### Step 2: Add Branch Protection Rule

1. Under "**Branch protection rules**", click **"Add branch protection rule"**
2. In "**Branch name pattern**", enter: `main`

### Step 3: Configure Protection Rules

Select these recommended options:

#### ✅ **Require a pull request before merging**
- ☑️ Check this box
- Under this, check:
  - ☑️ **Require approvals** (set to at least 1 reviewer)
  - ☑️ **Dismiss stale pull request approvals when new commits are pushed**
  - ☐ Require review from Code Owners (optional)

#### ✅ **Require status checks to pass before merging**
- ☐ Leave unchecked (unless you have CI/CD set up)

#### ✅ **Require conversation resolution before merging**
- ☑️ Check this box (ensures all comments are addressed)

#### ✅ **Require linear history**
- ☑️ Check this box (keeps history clean)

#### ✅ **Require deployments to succeed before merging**
- ☐ Leave unchecked (unless you have deployments)

#### ✅ **Lock branch**
- ☐ Leave unchecked (allows merges via PR)

#### ✅ **Do not allow bypassing the above settings**
- ☑️ Check this box (enforces rules for everyone)

#### ✅ **Restrict who can push to matching branches**
- ☑️ Check this box
- Add yourself and any other admins who should have override access
- ⚠️ Even with this, you should still use PRs!

#### ✅ **Allow force pushes**
- ☐ Leave unchecked (prevents force pushes to main)

#### ✅ **Allow deletions**
- ☐ Leave unchecked (prevents accidental deletion of main)

### Step 4: Save Protection Rules

1. Scroll to the bottom
2. Click **"Create"** button

---

## 🎯 Recommended Configuration Summary

```
Branch protection rule for: main

✅ Require pull request before merging
   ✅ Require approvals: 1
   ✅ Dismiss stale reviews
   
✅ Require conversation resolution before merging

✅ Require linear history

✅ Do not allow bypassing the above settings

✅ Restrict who can push to matching branches
   - patelajay005 (you)

❌ Allow force pushes: Disabled
❌ Allow deletions: Disabled
```

---

## 🌿 Branch Strategy After Protection

### Branch Hierarchy

```
main (protected)
  ↑
  └── Pull Request (requires review)
        ↑
        development
          ↑
          └── Pull Request
                ↑
                feature/your-feature
```

### Workflow

1. **Create feature branch from `development`:**
   ```bash
   git checkout development
   git pull origin development
   git checkout -b feature/new-feature
   ```

2. **Make changes and commit:**
   ```bash
   git add .
   git commit -m "feature: Add new MCP server"
   git push origin feature/new-feature
   ```

3. **Create PR: `feature/new-feature` → `development`**
   - Go to GitHub
   - Create pull request
   - Get review
   - Merge to `development`

4. **When ready for release, create PR: `development` → `main`**
   - Create pull request from `development` to `main`
   - Review changes
   - Merge to `main`

---

## 🚫 What Happens If You Try to Push Directly to Main?

After protection is enabled:

```bash
git checkout main
git add file.txt
git commit -m "update"
git push origin main
```

**Result:**
```
remote: error: GH006: Protected branch update failed for refs/heads/main.
remote: error: Required status check(s) expected but not present
To https://github.com/patelajay005/MCP-Server.git
 ! [remote rejected] main -> main (protected branch hook declined)
error: failed to push some refs to 'https://github.com/patelajay005/MCP-Server.git'
```

**Solution:** Use pull requests!

---

## 📊 Branch Status

Current branches in repository:

| Branch | Status | Purpose |
|--------|--------|---------|
| `main` | Protected | Production-ready, stable code |
| `development` | Active | Integration branch for features |
| `feature/*` | Temporary | Individual features/fixes |

---

## 🔄 Typical Release Flow

### Development Cycle

1. Developer creates feature branch from `development`
2. Developer works on feature
3. Developer creates PR to `development`
4. Code review and approval
5. Merge to `development`

### Release Cycle

1. When `development` is stable and tested
2. Create PR from `development` to `main`
3. Final review
4. Merge to `main`
5. Create a GitHub Release (optional but recommended)
6. Tag the release (e.g., `v1.0.0`)

---

## 📝 Example: Adding a New MCP Server

### Step-by-Step Process

```bash
# 1. Start from development
git checkout development
git pull origin development

# 2. Create feature branch
git checkout -b feature/gitlab-mcp-server

# 3. Add GitLab MCP server folder and files
mkdir GitLab
# ... create all necessary files ...

# 4. Commit changes
git add .
git commit -m "feature: Add GitLab MCP server setup"

# 5. Push feature branch
git push origin feature/gitlab-mcp-server

# 6. Create PR on GitHub
# Go to: https://github.com/patelajay005/MCP-Server
# Click "Compare & pull request"
# Base: development, Compare: feature/gitlab-mcp-server
# Create pull request

# 7. After approval and merge, delete feature branch
git checkout development
git pull origin development
git branch -d feature/gitlab-mcp-server
git push origin --delete feature/gitlab-mcp-server
```

---

## 🛡️ Security Benefits

With branch protection:
- ✅ All changes are tracked through PRs
- ✅ Code review before production
- ✅ Prevents accidental commits to main
- ✅ Maintains clean commit history
- ✅ Easy to revert changes if needed
- ✅ Better collaboration

---

## 📞 Need Help?

If you encounter issues with branch protection:
1. Check your GitHub repository settings
2. Verify you have admin access
3. Review the protection rules
4. Consult GitHub documentation: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches

---

## ✅ Verification

After setting up protection, test it:

```bash
# Try to push directly to main (should fail)
git checkout main
echo "test" > test.txt
git add test.txt
git commit -m "test"
git push origin main
# Should be rejected ✅
```

---

**Repository:** https://github.com/patelajay005/MCP-Server  
**Setup Date:** November 24, 2025  
**Protection Status:** To be enabled following this guide

