#!/bin/bash

# Project Transformer - Automatically transforms copied projects
# Usage: ./transform-project.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print colored output
print_header() { echo -e "${PURPLE}╔════════════════════════════════════════╗${NC}"; echo -e "${PURPLE}║   $1${NC}"; echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}"; }
print_info() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Get project info
get_project_info() {
    echo -e "${CYAN}🚀 Project Transformation Wizard${NC}\n"

    # Get current directory name as default
    CURRENT_DIR=$(basename "$PWD")

    # Get project details
    read -p "$(echo -e ${BLUE})Enter new project name (kebab-case) [${CURRENT_DIR}]: $(echo -e ${NC})" NEW_NAME
    NEW_NAME=${NEW_NAME:-$CURRENT_DIR}

    read -p "$(echo -e ${BLUE})Enter project title (Title Case): $(echo -e ${NC})" NEW_TITLE

    read -p "$(echo -e ${BLUE})Enter project description: $(echo -e ${NC})" NEW_DESCRIPTION

    read -p "$(echo -e ${BLUE})Enter main color (hex or name) [#10b981]: $(echo -e ${NC})" NEW_COLOR
    NEW_COLOR=${NEW_COLOR:-#10b981}

    read -p "$(echo -e ${BLUE})Enter version [0.1.0]: $(echo -e ${NC})" NEW_VERSION
    NEW_VERSION=${NEW_VERSION:-0.1.0}

    # Detect old project
    if [ -f "package.json" ]; then
        OLD_NAME=$(grep '"name"' package.json | head -1 | cut -d '"' -f 4)
        OLD_TITLE=$(echo "$OLD_NAME" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    else
        read -p "$(echo -e ${BLUE})Enter OLD project name to replace: $(echo -e ${NC})" OLD_NAME
        read -p "$(echo -e ${BLUE})Enter OLD project title to replace: $(echo -e ${NC})" OLD_TITLE
    fi

    # Get transformation type
    echo -e "\n${CYAN}Select transformation type:${NC}"
    echo "1) Complete rebrand (new identity)"
    echo "2) Feature pivot (same brand, new purpose)"
    echo "3) Clone variation (similar with tweaks)"
    echo "4) Custom transformation"
    read -p "Choice [1-4]: " TRANSFORM_TYPE
}

# Clean git history
clean_git() {
    print_info "Cleaning git history..."
    if [ -d ".git" ]; then
        print_warning "Git repository found. Options:"
        echo "1) Keep git history"
        echo "2) Start fresh (delete history)"
        echo "3) Archive old history"
        read -p "Choice [1-3]: " GIT_CHOICE

        case $GIT_CHOICE in
            2)
                rm -rf .git
                git init
                print_success "Git history cleared"
                ;;
            3)
                mv .git .git.backup
                git init
                print_success "Old git history archived to .git.backup"
                ;;
            *)
                print_info "Keeping git history"
                ;;
        esac
    fi
}

# Update package files
update_package_files() {
    print_info "Updating package files..."

    # Update package.json
    if [ -f "package.json" ]; then
        # Use temporary file for replacements
        cp package.json package.json.tmp

        # Update name
        sed -i '' "s/\"name\": \".*\"/\"name\": \"$NEW_NAME\"/" package.json.tmp

        # Update version
        sed -i '' "s/\"version\": \".*\"/\"version\": \"$NEW_VERSION\"/" package.json.tmp

        # Update description
        if grep -q '"description"' package.json.tmp; then
            sed -i '' "s/\"description\": \".*\"/\"description\": \"$NEW_DESCRIPTION\"/" package.json.tmp
        fi

        mv package.json.tmp package.json
        print_success "Updated package.json"
    fi

    # Update README
    if [ -f "README.md" ]; then
        echo "# $NEW_TITLE

$NEW_DESCRIPTION

## 🚀 Quick Start

\`\`\`bash
# Install dependencies
npm install

# Start development
npm run dev

# Build for production
npm run build
\`\`\`

## 📦 Version

$NEW_VERSION

---

*Transformed from $OLD_TITLE using Project Transformer*" > README.md
        print_success "Updated README.md"
    fi
}

# Replace strings throughout project
replace_strings() {
    print_info "Replacing project references..."

    # Define file extensions to search
    EXTENSIONS="js,jsx,ts,tsx,html,css,json,md,yml,yaml,toml"

    # Count replacements
    COUNT=0

    # Replace in all relevant files
    for ext in ${EXTENSIONS//,/ }; do
        if ls *.$ext 1> /dev/null 2>&1 || find . -name "*.$ext" 2>/dev/null | grep -q .; then
            find . -type f -name "*.$ext" ! -path "*/node_modules/*" ! -path "*/.git/*" -exec sed -i '' "s/$OLD_NAME/$NEW_NAME/g" {} \;
            find . -type f -name "*.$ext" ! -path "*/node_modules/*" ! -path "*/.git/*" -exec sed -i '' "s/$OLD_TITLE/$NEW_TITLE/g" {} \;
            ((COUNT++))
        fi
    done

    print_success "Replaced strings in $COUNT file types"
}

# Clean old files
clean_old_files() {
    print_info "Cleaning old project files..."

    # Remove old documentation
    DOCS_TO_REMOVE=(
        "CLAUDE-AUTOMATION-*.md"
        "FRAMEWORK-*.md"
        "*fastfiles*.md"
        "*FastFiles*.md"
    )

    for pattern in "${DOCS_TO_REMOVE[@]}"; do
        if ls $pattern 1> /dev/null 2>&1; then
            rm -f $pattern
            print_success "Removed $pattern"
        fi
    done

    # Clear dist/build folders
    if [ -d "dist" ]; then
        rm -rf dist/*
        print_success "Cleared dist folder"
    fi

    if [ -d "build" ]; then
        rm -rf build/*
        print_success "Cleared build folder"
    fi
}

# Create Claude prompt file
create_claude_prompt() {
    print_info "Creating Claude transformation prompt..."

    cat > TRANSFORM-PROMPT.md << EOF
# 🔄 Transform $OLD_TITLE to $NEW_TITLE

Please complete the transformation of this project with these requirements:

## Project Identity
- **Old Name**: $OLD_NAME / $OLD_TITLE
- **New Name**: $NEW_NAME / $NEW_TITLE
- **Description**: $NEW_DESCRIPTION
- **Version**: $NEW_VERSION
- **Primary Color**: $NEW_COLOR

## Automated Changes Already Made
✅ Package.json updated
✅ README.md created
✅ String replacements done
✅ Old documentation removed

## Still Needed from Claude

### 1. Component Transformation
- Rename/refactor main components to match new purpose
- Update component logic for new functionality
- Remove old feature-specific code

### 2. UI/UX Updates
- Update color scheme to use $NEW_COLOR
- Change all UI text and labels
- Update icons and imagery
- Adjust layouts for new purpose

### 3. Backend Changes
- Update API endpoints
- Modify database schema if needed
- Adjust CloudFlare Workers
- Update environment variables

### 4. Feature Implementation
Based on new purpose: $NEW_DESCRIPTION
- Identify core features needed
- Reuse existing infrastructure
- Build new functionality

### 5. Documentation
- Update inline comments
- Create new user guide
- Update API documentation
- Add setup instructions

## Transformation Type: Type $TRANSFORM_TYPE

Please use TodoWrite to track all changes and make systematic updates.
Start by analyzing what exists, then transform each component methodically.

EOF

    print_success "Created TRANSFORM-PROMPT.md"
}

# Generate transformation report
generate_report() {
    print_info "Generating transformation report..."

    cat > TRANSFORMATION-REPORT.md << EOF
# 📊 Project Transformation Report

## Summary
- **Date**: $(date +%Y-%m-%d)
- **From**: $OLD_TITLE ($OLD_NAME)
- **To**: $NEW_TITLE ($NEW_NAME)
- **Version**: $NEW_VERSION

## Changes Made

### Automated
- [x] Package.json updated
- [x] README.md regenerated
- [x] String replacements completed
- [x] Old documentation cleaned
- [x] Git history managed

### Pending (for Claude)
- [ ] Component refactoring
- [ ] UI/UX updates
- [ ] Backend modifications
- [ ] Feature implementation
- [ ] Documentation updates

## Next Steps
1. Open Claude Code
2. Use TRANSFORM-PROMPT.md
3. Let Claude complete transformation
4. Test all features
5. Deploy new project

## Files Modified
- package.json
- README.md
- $(find . -type f -name "*.tsx" ! -path "*/node_modules/*" | wc -l) TypeScript files
- $(find . -type f -name "*.ts" ! -path "*/node_modules/*" | wc -l) TypeScript files
- $(find . -type f -name "*.css" ! -path "*/node_modules/*" | wc -l) CSS files

## Notes
Transformation type: $TRANSFORM_TYPE
Primary color: $NEW_COLOR

---
*Generated by Project Transformer*
EOF

    print_success "Created TRANSFORMATION-REPORT.md"
}

# Main execution
main() {
    print_header "   PROJECT TRANSFORMER   "
    echo

    # Check if in a project directory
    if [ ! -f "package.json" ] && [ ! -f "Gemfile" ] && [ ! -f "requirements.txt" ]; then
        print_error "No project detected in current directory"
        exit 1
    fi

    # Get project information
    get_project_info

    echo
    print_header "   Starting Transformation   "
    echo

    # Execute transformation steps
    clean_git
    update_package_files
    replace_strings
    clean_old_files
    create_claude_prompt
    generate_report

    echo
    print_header "   Transformation Complete!   "
    echo

    print_success "Project transformed from $OLD_TITLE to $NEW_TITLE"
    print_info "Version: $NEW_VERSION"
    echo

    echo -e "${CYAN}Next steps:${NC}"
    echo "1. Review TRANSFORMATION-REPORT.md"
    echo "2. Open Claude Code"
    echo "3. Paste contents of TRANSFORM-PROMPT.md"
    echo "4. Let Claude complete the transformation"
    echo

    # Offer to install Claude automation
    read -p "Install Claude Automation Framework? (y/n): " INSTALL_CLAUDE
    if [ "$INSTALL_CLAUDE" = "y" ]; then
        curl -sSL https://raw.githubusercontent.com/ideabrian/claude-automation/main/install.sh | bash
    fi

    # Offer to commit changes
    if [ -d ".git" ]; then
        read -p "Commit transformation? (y/n): " COMMIT_CHANGES
        if [ "$COMMIT_CHANGES" = "y" ]; then
            git add -A
            git commit -m "transform: From $OLD_TITLE to $NEW_TITLE v$NEW_VERSION

Automated transformation:
- Updated package identity
- Replaced project references
- Cleaned old documentation
- Prepared for Claude completion

Next: Claude will complete component transformation"
            print_success "Changes committed"
        fi
    fi

    print_success "Transformation complete! 🎉"
}

# Run main function
main "$@"