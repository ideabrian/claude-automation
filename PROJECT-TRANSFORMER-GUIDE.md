# 🔄 Project Transformer - Complete Guide

Transform any project into something new in minutes!

## 🚀 Quick Start

### One-Line Transform (New Alias!)
```bash
# In any copied project
transform

# Or clone and transform in one step
clone-transform fastfiles my-new-app
```

## 📋 What It Does

### Automated Steps (Script)
1. ✅ Updates project name everywhere
2. ✅ Changes version to fresh start
3. ✅ Replaces all string references
4. ✅ Cleans old documentation
5. ✅ Updates package.json
6. ✅ Creates new README
7. ✅ Manages git history
8. ✅ Generates Claude prompt

### Manual Steps (Claude)
1. 🤖 Refactors components
2. 🤖 Updates UI/UX
3. 🤖 Implements new features
4. 🤖 Modifies backend
5. 🤖 Completes transformation

## 🎯 Usage Examples

### Example 1: File Sharing → Betting Platform
```bash
# Clone and transform
clone-transform fastfiles futr-bet

# Interactive prompts:
Enter new project name: futr-bet
Enter project title: FutrBet
Enter description: Prediction markets for friends
Enter main color: #10b981
Enter version: 0.1.0

# Automated transformation runs...
✅ Project transformed!

# Then in Claude:
[Paste TRANSFORM-PROMPT.md content]
```

### Example 2: Local Project Transform
```bash
# Copy existing project
cp -R my-old-project my-new-project
cd my-new-project

# Run transformer
transform

# Answer prompts
# Get TRANSFORM-PROMPT.md for Claude
```

### Example 3: GitHub Clone & Transform
```bash
# Clone from GitHub and transform
clone-transform https://github.com/user/project new-version

# Transformer runs automatically
```

## 🛠️ Installation

### Already Installed!
The aliases are in your `~/.aliases`:
- `transform` - Run transformer in current directory
- `clone-transform` - Clone and transform in one step

### Manual Installation
```bash
# Get the script
curl -O https://raw.githubusercontent.com/ideabrian/claude-automation/main/transform-project.sh
chmod +x transform-project.sh
./transform-project.sh
```

## 📚 Templates Available

### Quick Templates
1. **Prediction Market** (like Polymarket)
2. **E-Commerce** (simple store)
3. **Survey Platform** (forms/polls)
4. **Chat Application** (real-time)
5. **Event Planner** (RSVPs)
6. **Analytics Dashboard**
7. **Game Platform**
8. **Knowledge Base** (wiki)
9. **Finance Tracker**

See `TRANSFORMATION-TEMPLATES.md` for full details.

## 🔧 Configuration Options

### Transform Types
1. **Complete Rebrand** - New identity
2. **Feature Pivot** - Same brand, new purpose
3. **Clone Variation** - Similar with tweaks
4. **Custom** - Your own transformation

### Git Options
1. **Keep History** - Preserve commits
2. **Fresh Start** - Delete history
3. **Archive** - Backup old history

## 📝 Generated Files

### TRANSFORM-PROMPT.md
Complete instructions for Claude to finish the transformation.

### TRANSFORMATION-REPORT.md
Summary of all changes made and pending tasks.

## 💡 Pro Workflow

### Optimal Process
```bash
# 1. Clone source
clone-transform fastfiles my-app

# 2. Answer prompts thoughtfully
Project name: my-app
Title: MyApp
Description: [Clear description helps Claude]

# 3. Review generated files
cat TRANSFORM-PROMPT.md
cat TRANSFORMATION-REPORT.md

# 4. Open Claude Code
claude

# 5. Paste TRANSFORM-PROMPT.md content

# 6. Let Claude complete transformation

# 7. Test everything
npm run dev

# 8. Deploy when ready
/deploy
```

## 🎨 Customization

### Edit Script Behavior
```bash
# Edit the transformer
nano ~/.local/bin/transform-project.sh

# Or edit local copy
nano transform-project.sh
```

### Add Custom Templates
```bash
# Add to TRANSFORMATION-TEMPLATES.md
# Create your own transformation patterns
```

## 🔍 Troubleshooting

### Common Issues

**"Command not found"**
```bash
source ~/.zshrc
# Or open new terminal
```

**"No project detected"**
```bash
# Make sure you're in a project directory
# Must have package.json, Gemfile, or requirements.txt
```

**"Replacements not working"**
```bash
# Check OLD_NAME detection
# Manually specify if needed
```

## 🚦 Best Practices

### Do's ✅
- Run in project root
- Review generated prompts
- Test after transformation
- Commit changes incrementally
- Keep templates updated

### Don'ts ❌
- Transform production code directly
- Skip Claude completion step
- Ignore git history options
- Rush through prompts

## 📊 Success Metrics

Good transformation:
- ✅ < 5 minutes automated
- ✅ < 15 minutes with Claude
- ✅ All references updated
- ✅ Clean git history
- ✅ Working application

## 🎉 Real Examples

### FastFiles → FutrBet
- Time: 18 minutes total
- Changes: 47 files
- New features: Betting system
- Result: Working prediction market

### React Starter → Dashboard
- Time: 12 minutes
- Changes: 23 files
- New features: Analytics
- Result: Full dashboard app

## 🔗 Resources

- Script: `transform-project.sh`
- Templates: `TRANSFORMATION-TEMPLATES.md`
- Aliases: `~/.aliases`
- Claude Framework: https://github.com/ideabrian/claude-automation

## 💬 Commands Reference

```bash
# Transform current project
transform

# Clone and transform
clone-transform source destination

# Check Claude automation
claude-info

# Install Claude automation
claude-auto
```

---

**Ready to transform projects in minutes instead of hours!** 🚀

Just type `transform` or `clone-transform` and follow the prompts!