# 🤖 Claude Automation Framework

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/ideabrian/claude-automation)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-purple.svg)](https://claude.ai/code)

**Universal automation framework for Claude Code - AI-powered workflows for any project**

Transform any codebase into an AI-automated powerhouse in under 30 seconds. The framework automatically detects your tech stack and provides consistent commands across all your projects.

## ✨ Features

- 🚀 **30-second installation** - Works instantly
- 🎯 **Smart detection** - Automatically identifies your stack
- 🔄 **Universal commands** - Same commands work everywhere
- 📚 **Self-documenting** - Generates docs as you work
- 🛠️ **Zero configuration** - Just install and go
- 🌍 **Any language** - JavaScript, Python, Ruby, Go, Rust, and more
- 📦 **Any framework** - React, Vue, Django, Rails, Laravel, and more
- ☁️ **Any platform** - Vercel, Netlify, CloudFlare, AWS, and more
- 🔄 **Project Transformer** - Transform any project into something new in minutes

## 🚀 Quick Start

### Install in 30 Seconds

```bash
# Option 1: Direct installation
curl -sSL https://raw.githubusercontent.com/ideabrian/claude-automation/main/install.sh | bash

# Option 2: Clone and install
git clone https://github.com/ideabrian/claude-automation.git
cd claude-automation
./install.sh

# Option 3: Using aliases (if configured)
claude-auto        # Install framework in current project
transform          # Transform current project
clone-transform    # Clone and transform in one step
```

### Use Immediately

Open Claude Code and type:

```
/deploy          # Deploy your project
/test            # Run all tests
/feature login   # Add login feature
/fix bug-123     # Fix a bug
/release 1.0.0   # Create release
```

## 📖 How It Works

1. **Detects** your project type, framework, and deployment platform
2. **Adapts** commands to work with your specific stack
3. **Automates** repetitive tasks with AI-powered workflows
4. **Documents** everything automatically as you work

### Supported Technologies

<table>
<tr>
<td>

**Languages**
- JavaScript/TypeScript
- Python
- Ruby
- Go
- Rust
- PHP
- Java
- C#

</td>
<td>

**Frameworks**
- React/Next.js
- Vue/Nuxt
- Angular
- Django/FastAPI
- Rails
- Laravel
- Express

</td>
<td>

**Platforms**
- Vercel
- Netlify
- CloudFlare
- AWS
- Heroku
- Docker
- Kubernetes

</td>
<td>

**Testing**
- Jest
- Vitest
- Mocha
- PyTest
- RSpec
- Go Test

</td>
</tr>
</table>

## 📚 Documentation

- [User Guide](CLAUDE-AUTOMATION-USER-GUIDE.md) - Complete documentation
- [Quick Reference](CLAUDE-QUICK-REFERENCE.md) - Printable cheat sheet
- [Framework Design](CLAUDE-AUTOMATION-FRAMEWORK.md) - Technical details
- [Project Transformer Guide](PROJECT-TRANSFORMER-GUIDE.md) - Transform projects into new ones
- [Transformation Templates](TRANSFORMATION-TEMPLATES.md) - Pre-made transformation templates

## 🎯 Core Commands

| Command | Purpose | What It Does |
|---------|---------|--------------|
| `/deploy` | Deploy to production | Tests, builds, deploys, tags, and documents |
| `/test` | Run all tests | Unit, integration, coverage, linting, security |
| `/fix` | Fix bugs | Guided workflow with tests and documentation |
| `/feature` | Add features | Structured development with best practices |
| `/release` | Create releases | Version bump, changelog, tag, deploy |

## 🔧 Installation Details

The installer will:

1. Analyze your project to detect:
   - Programming language
   - Framework
   - Testing tools
   - Deployment platform
   - Package manager

2. Create these files:
```
.claude/
├── commands/       # Your slash commands
│   ├── deploy.md   # Adapted to your platform
│   ├── test.md     # Adapted to your test framework
│   ├── fix.md      # Bug fix workflow
│   ├── feature.md  # Feature development
│   └── release.md  # Release management
├── config.yml      # Configuration
└── workflows/      # Multi-step automations

CLAUDE.md          # Project context for AI
```

3. Commands automatically adapt:
   - `/deploy` knows whether to use Vercel, Netlify, or CloudFlare
   - `/test` knows whether to run Jest, PyTest, or RSpec
   - `/feature` follows your project's patterns

## 🎨 Customization

### Edit Commands

Commands are simple markdown files in `.claude/commands/`:

```markdown
# .claude/commands/deploy.md
---
description: Deploy to production
---
1. Run tests
2. Build project
3. Deploy to CloudFlare  # Automatically detected!
4. Update changelog
5. Create git tag
```

### Add Custom Commands

Create new commands easily:

```bash
echo "---
description: My custom command
---
Do something: \$ARGUMENTS" > .claude/commands/custom.md
```

## 💡 Example Workflows

### Daily Development
```bash
/test            # Start with clean slate
/feature auth    # Build authentication
/test            # Verify it works
/deploy          # Ship to production
```

### Bug Fix
```bash
/fix "users can't login"  # Structured fix workflow
/test                      # Verify fix
/deploy                    # Deploy immediately
```

### Release
```bash
/test            # Full test suite
/release 2.0.0   # Create release
# Automatically: versions, tags, deploys, documents
```

### Project Transformation
```bash
# Transform existing project
transform        # Interactive transformation wizard

# Or clone and transform in one step
clone-transform fastfiles my-new-app

# Follow prompts to transform into:
# - E-commerce platform
# - Prediction market
# - Chat application
# - Survey platform
# - And more!
```

## 🌟 Real Results

> "Cut deployment time by 90%. What took 30 minutes is now just `/deploy`."
> — Development Team

> "Junior devs now follow best practices automatically. Game changer!"
> — Tech Lead

> "We use it on 50+ projects. Same commands everywhere!"
> — Enterprise Team

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
git clone https://github.com/ideabrian/claude-automation.git
cd claude-automation
npm install
npm test
```

## 📄 License

MIT License - Free for personal and commercial use.

## 🔗 Links

- [GitHub Repository](https://github.com/ideabrian/claude-automation)
- [Issue Tracker](https://github.com/ideabrian/claude-automation/issues)
- [Discussions](https://github.com/ideabrian/claude-automation/discussions)

## 🙏 Acknowledgments

Built with inspiration from the developer community and powered by Claude Code's excellent slash command system.

---

<div align="center">

**Ready to automate your development?**

Install in 30 seconds and transform how you code!

```bash
curl -sSL https://raw.githubusercontent.com/ideabrian/claude-automation/main/install.sh | bash
```

⭐ Star this repo if it helps your workflow!

</div>