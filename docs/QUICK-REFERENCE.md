# 🎯 Claude Automation - Quick Reference Card

## Installation (30 seconds)
```bash
curl -sSL https://claude-automation.dev/install.sh | bash
```

## Essential Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/deploy` | Deploy to production | `/deploy` |
| `/test` | Run all tests | `/test` |
| `/fix` | Fix a bug | `/fix login-error` |
| `/feature` | Add new feature | `/feature dark-mode` |
| `/release` | Create release | `/release 1.2.0` |
| `/review` | Code review | `/review` |

## Command Workflows

### 🚀 Daily Development
```
Morning:  /test                    # Start clean
Work:     /feature new-feature     # Build feature
Check:    /test                    # Verify works
Ship:     /deploy                  # Deploy it
```

### 🐛 Bug Fix
```
/fix "bug description"    # Start fix workflow
/test                     # Verify fix works
/deploy                   # Ship immediately
```

### 📦 Release
```
/test                     # Ensure quality
/review                   # Review code
/release 1.0.0           # Create release
```

## Project Detection

| Detects | Examples |
|---------|----------|
| **Languages** | JS, Python, Ruby, Go, Rust |
| **Frameworks** | React, Vue, Django, Rails |
| **Platforms** | Vercel, Netlify, CloudFlare |
| **Testing** | Jest, PyTest, RSpec |
| **Databases** | PostgreSQL, MySQL, MongoDB |

## File Structure
```
.claude/
├── commands/     # Your slash commands
├── config.yml    # Configuration
├── templates/    # Reusable templates
└── workflows/    # Multi-step workflows
```

## Customization

### Edit Commands
```bash
# Edit any command
nano .claude/commands/deploy.md
```

### Add New Command
```bash
echo "---
description: My command
---
Do something: \$1" > .claude/commands/mycommand.md
```

### Configure Behavior
```yaml
# .claude/config.yml
automation:
  testing:
    run_before_deploy: true
  deployment:
    create_tag: true
```

## Commit Conventions

| Type | When to Use |
|------|------------|
| `feat:` | New feature |
| `fix:` | Bug fix |
| `docs:` | Documentation |
| `refactor:` | Code restructuring |
| `test:` | Adding tests |
| `chore:` | Maintenance |

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Commands not showing | Restart Claude Code |
| Wrong detection | Edit CLAUDE.md manually |
| Deploy fails | Check credentials |
| Tests fail | Run `/test` for details |

## Best Practices

✅ **DO:**
- Use `/test` before `/deploy`
- Let framework update changelog
- Use TodoWrite for complex tasks
- Follow generated commit format

❌ **DON'T:**
- Skip testing
- Edit changelog manually
- Deploy with uncommitted changes
- Ignore framework suggestions

## Keyboard Shortcuts

| Action | Command |
|--------|---------|
| Deploy quickly | `/deploy` |
| Fix last bug | `/fix` |
| Emergency test | `/test` |
| Quick release | `/release patch` |

## Platform-Specific

### Vercel
```
/deploy → vercel --prod
```

### Netlify
```
/deploy → netlify deploy --prod
```

### CloudFlare
```
/deploy → wrangler publish
```

### Docker
```
/deploy → docker build && docker push
```

## Version Management

| Version Type | Command | Use Case |
|--------------|---------|----------|
| Patch (0.0.X) | `/release 1.0.1` | Bug fixes |
| Minor (0.X.0) | `/release 1.1.0` | Features |
| Major (X.0.0) | `/release 2.0.0` | Breaking |

## Getting Help

- **Docs**: `https://claude-automation.dev`
- **GitHub**: `github.com/claude-automation`
- **Discord**: `discord.gg/claude-auto`
- **Email**: `help@claude-automation.dev`

---

**Remember:** The framework adapts to YOUR project. Same commands work everywhere!

*Print this page and keep it handy!* 🖨️