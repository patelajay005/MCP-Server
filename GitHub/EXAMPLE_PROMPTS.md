# Example Prompts for GitHub MCP Server

Once you have the GitHub MCP Server set up, try these prompts in Claude Desktop!

## Getting Started - Basic Commands

### Repository Management

```
List my GitHub repositories
```

```
Show me the repositories I've starred recently
```

```
Search for Python repositories about machine learning
```

```
What are the most popular repositories with the topic "mcp-server"?
```

### Issues

```
List open issues in github/github-mcp-server
```

```
Show me issues assigned to me
```

```
Create an issue in patelajay005/my-project titled "Add README" with description "We need a comprehensive README file"
```

```
Search for issues about "authentication" in owner/repo
```

```
Show me the most commented issues in owner/repo
```

### Pull Requests

```
List my open pull requests
```

```
Show pull requests that need my review
```

```
Get details of pull request #123 in owner/repo
```

```
List the review comments on PR #456 in owner/repo
```

### Code Search

```
Search for "async function" in owner/repo
```

```
Find all files that import React in owner/repo
```

```
Show me TODO comments in owner/repo
```

```
Search for API endpoints in owner/repo
```

## Advanced Use Cases

### Repository Analysis

```
Analyze the github/github-mcp-server repository:
- How many open issues are there?
- What are the most common labels?
- Who are the top contributors?
```

```
Compare the issues and PRs between two repositories: owner/repo1 and owner/repo2
```

```
What GitHub Actions workflows does owner/repo use?
```

### Project Management

```
Create a new repository called "my-awesome-project" with description "An awesome new project" and initialize it with a README
```

```
Fork the repository owner/repo to my account
```

```
Create a branch called "feature/new-feature" from the main branch in owner/repo
```

```
Create an issue in owner/repo with title "Bug: Login fails" and add it to the project board
```

### Code Review Assistance

```
Review pull request #123 in owner/repo and summarize:
- What changes were made?
- Are there any potential issues?
- What do the review comments say?
```

```
Get the diff for pull request #456 in owner/repo and explain the changes
```

```
List all unresolved review comments on PR #789 in owner/repo
```

### Security & Compliance

```
List security advisories for the npm ecosystem published in the last month
```

```
Check if owner/repo has any security vulnerabilities
```

```
Search for security advisories with severity "high" or "critical"
```

### Workflow Automation

```
List all GitHub Actions workflows in owner/repo
```

```
Show me the recent workflow runs for owner/repo
```

```
Get the status of workflow run #12345 in owner/repo
```

```
Trigger the "build" workflow in owner/repo on the main branch
```

### User & Organization Management

```
Search for users with expertise in Python located in Seattle
```

```
Show me the repositories of user patelajay005
```

```
List the members of the organization my-org
```

### Gists

```
Search for gists about "docker compose"
```

```
Create a gist with a Python script that prints "Hello World"
```

```
List my public gists
```

## Complex Workflows

### Bug Triage Workflow

```
I want to triage bugs in owner/repo:
1. List all issues with the "bug" label that have no assignee
2. For each bug, show me the description and any comments
3. Help me categorize them by priority based on the content
```

### Release Preparation

```
Help me prepare a release for owner/repo:
1. List all merged PRs since the last release
2. Categorize them into features, bug fixes, and documentation
3. Create a draft release notes
```

### Dependency Analysis

```
Search for all package.json files in owner/repo and analyze:
- What are the main dependencies?
- Are there any deprecated packages?
- What's the Node.js version requirement?
```

### Code Quality Check

```
Analyze code quality in owner/repo:
1. Search for TODO and FIXME comments
2. Find any console.log statements in JavaScript files
3. Look for error handling patterns
```

### Team Activity Summary

```
Create a summary of team activity for owner/repo in the last week:
- How many PRs were created and merged?
- How many issues were opened and closed?
- Who were the most active contributors?
```

## Working with Your Own Repositories

Replace `patelajay005` with your username and customize these:

```
Show me all issues assigned to me across all my repositories
```

```
List all my repositories that haven't been updated in the last 6 months
```

```
Which of my repositories have the most stars?
```

```
Show me all PRs where I'm requested as a reviewer
```

```
Create a new private repository called "patelajay005/new-project" with a Node.js .gitignore
```

## Collaborative Development

```
Show me who has contributed to owner/repo and what they've worked on
```

```
List all discussions in owner/repo
```

```
Find issues in owner/repo that are labeled "good first issue" or "help wanted"
```

```
Show me the contribution guidelines for owner/repo
```

## Tips for Effective Prompts

### Be Specific
❌ Bad: "Show issues"
✅ Good: "Show open issues with the 'bug' label in owner/repo"

### Provide Context
❌ Bad: "Create an issue"
✅ Good: "Create an issue in patelajay005/my-project titled 'Add tests' with description 'We need unit tests for the auth module'"

### Chain Operations
```
For the repository owner/repo:
1. First, show me all open issues
2. Then, show me which ones have no assignee
3. Finally, help me write a comment for issue #123 asking for more details
```

### Ask for Analysis
```
Analyze the pull request #456 in owner/repo:
- What files were changed?
- What's the purpose of these changes?
- Are there any potential issues or concerns?
- What do the reviewers say?
```

### Combine Multiple Sources
```
Compare the GitHub Actions workflows in repo1 vs repo2 and tell me:
- Which one has better CI/CD practices?
- What unique features does each have?
```

## Experimentation Ideas

1. **Build a personal dashboard:**
   "Create a summary of all my GitHub activity today"

2. **Automate code reviews:**
   "Review all open PRs in owner/repo and summarize the key changes"

3. **Project planning:**
   "Help me plan the next sprint by analyzing open issues in owner/repo"

4. **Documentation helper:**
   "Find all TODO comments in owner/repo and create issues for them"

5. **Learning from code:**
   "Search for authentication patterns in popular Node.js repositories"

## Remember

- The GitHub MCP server respects your GitHub permissions
- Read-only operations don't require confirmation
- Write operations (creating issues, PRs, etc.) should be done carefully
- Rate limits apply (5,000 requests/hour for authenticated users)

## Need More Ideas?

Ask Claude: "What can I do with the GitHub MCP server?" for more suggestions tailored to your needs!

