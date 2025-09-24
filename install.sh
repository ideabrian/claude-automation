#!/bin/bash

# Claude Automation Framework - Universal Installer
# This script creates a portable automation framework for any project

set -e

FRAMEWORK_VERSION="1.0.0"
GITHUB_REPO="https://github.com/yourusername/claude-automation"
LOCAL_FRAMEWORK_PATH="$HOME/.claude-automation"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_info() { echo -e "${BLUE}ℹ ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Detect project characteristics
detect_project_type() {
    local project_type="unknown"

    # Node.js/JavaScript
    if [ -f "package.json" ]; then
        project_type="node"
        if grep -q '"react"' package.json 2>/dev/null; then
            project_type="react"
        elif grep -q '"vue"' package.json 2>/dev/null; then
            project_type="vue"
        elif grep -q '"@angular/core"' package.json 2>/dev/null; then
            project_type="angular"
        elif grep -q '"next"' package.json 2>/dev/null; then
            project_type="nextjs"
        fi
    # Python
    elif [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        project_type="python"
        if [ -f "manage.py" ]; then
            project_type="django"
        elif grep -q 'fastapi' requirements.txt 2>/dev/null; then
            project_type="fastapi"
        elif grep -q 'flask' requirements.txt 2>/dev/null; then
            project_type="flask"
        fi
    # Ruby
    elif [ -f "Gemfile" ]; then
        project_type="ruby"
        if [ -f "config/routes.rb" ]; then
            project_type="rails"
        fi
    # Go
    elif [ -f "go.mod" ]; then
        project_type="go"
    # Rust
    elif [ -f "Cargo.toml" ]; then
        project_type="rust"
    # PHP
    elif [ -f "composer.json" ]; then
        project_type="php"
        if grep -q '"laravel/framework"' composer.json 2>/dev/null; then
            project_type="laravel"
        fi
    fi

    echo "$project_type"
}

# Detect deployment platform
detect_deployment_platform() {
    local platform="unknown"

    if [ -f "vercel.json" ] || [ -d ".vercel" ]; then
        platform="vercel"
    elif [ -f "netlify.toml" ] || [ -d ".netlify" ]; then
        platform="netlify"
    elif [ -f "wrangler.toml" ]; then
        platform="cloudflare"
    elif [ -f "Dockerfile" ]; then
        platform="docker"
    elif [ -f "Procfile" ]; then
        platform="heroku"
    elif [ -f ".github/workflows/deploy.yml" ]; then
        platform="github-actions"
    elif [ -f "serverless.yml" ]; then
        platform="serverless"
    fi

    echo "$platform"
}

# Detect test framework
detect_test_framework() {
    local framework="none"

    if [ -f "package.json" ]; then
        if grep -q '"jest"' package.json 2>/dev/null; then
            framework="jest"
        elif grep -q '"mocha"' package.json 2>/dev/null; then
            framework="mocha"
        elif grep -q '"vitest"' package.json 2>/dev/null; then
            framework="vitest"
        elif grep -q '"cypress"' package.json 2>/dev/null; then
            framework="cypress"
        fi
    elif [ -f "requirements.txt" ]; then
        if grep -q 'pytest' requirements.txt 2>/dev/null; then
            framework="pytest"
        elif grep -q 'unittest' requirements.txt 2>/dev/null; then
            framework="unittest"
        fi
    elif [ -f "Gemfile" ]; then
        if grep -q 'rspec' Gemfile 2>/dev/null; then
            framework="rspec"
        fi
    fi

    echo "$framework"
}

# Create core command files
create_core_commands() {
    local commands_dir=".claude/commands"
    mkdir -p "$commands_dir"

    # Deploy command
    cat > "$commands_dir/deploy.md" << 'EOF'
---
description: Universal deployment pipeline
---
Deploy the project:

1. **Pre-deployment checks**
   - Run tests if available
   - Check for uncommitted changes
   - Validate environment variables

2. **Build process**
   - Install dependencies
   - Run build command
   - Optimize assets

3. **Deployment**
   - Deploy to detected platform
   - Verify deployment
   - Update status

4. **Post-deployment**
   - Update changelog
   - Create deployment tag
   - Notify team (if configured)

Platform detected: DEPLOYMENT_PLATFORM
EOF

    # Fix command
    cat > "$commands_dir/fix.md" << 'EOF'
---
description: Bug fix workflow with documentation
---
Fix the bug: $ARGUMENTS

Steps:
1. **Analysis**
   - Create TodoWrite plan
   - Search for related code
   - Identify root cause

2. **Implementation**
   - Apply the fix
   - Add tests if missing
   - Verify fix works

3. **Documentation**
   - Update changelog
   - Document root cause
   - Add to known issues if needed

4. **Commit**
   - Use format: "fix: $1"
   - Reference issue number if applicable
EOF

    # Feature command
    cat > "$commands_dir/feature.md" << 'EOF'
---
description: New feature development workflow
---
Implement feature: $ARGUMENTS

Requirements:
1. **Planning**
   - Break down into TodoWrite tasks
   - Review existing patterns
   - Design approach

2. **Development**
   - Implement following conventions
   - Add comprehensive tests
   - Ensure accessibility

3. **Documentation**
   - Update README if needed
   - Add to changelog
   - Document API changes

4. **Review**
   - Self-review checklist
   - Run all tests
   - Check performance impact

5. **Commit**
   - Use format: "feat: $1"
EOF

    # Test command
    cat > "$commands_dir/test.md" << 'EOF'
---
description: Run all available tests and checks
---
Execute comprehensive testing:

1. **Unit Tests**
   - Run test framework: TEST_FRAMEWORK
   - Check coverage
   - Verify all pass

2. **Linting**
   - Run linter if available
   - Auto-fix when possible
   - Report issues

3. **Type Checking**
   - Run type checker if available
   - Report type errors

4. **Build Test**
   - Ensure project builds
   - Check bundle size
   - Verify no errors

5. **Security**
   - Check for vulnerabilities
   - Scan dependencies
   - Check for secrets

Report all findings with severity levels.
EOF

    # Release command
    cat > "$commands_dir/release.md" << 'EOF'
---
description: Create a new release
---
Create release version $1:

1. **Version Update**
   - Update version in package files
   - Update changelog date

2. **Quality Checks**
   - Run full test suite
   - Verify build succeeds
   - Check documentation

3. **Release Process**
   - Create git tag v$1
   - Build release artifacts
   - Deploy to production

4. **Documentation**
   - Generate release notes
   - Update changelog
   - Notify stakeholders

5. **Commit and Push**
   - Commit: "chore(release): v$1"
   - Push tags to remote
EOF

    print_success "Created core commands"
}

# Create CLAUDE.md with project context
create_claude_md() {
    local project_type="$1"
    local deploy_platform="$2"
    local test_framework="$3"

    cat > "CLAUDE.md" << EOF
# Claude Code Project Context

## Project Information
- **Type**: $project_type
- **Deployment**: $deploy_platform
- **Testing**: $test_framework
- **Created**: $(date +%Y-%m-%d)
- **Framework Version**: $FRAMEWORK_VERSION

## Available Commands
\`\`\`
/deploy     - Deploy to $deploy_platform
/fix        - Fix bugs with documentation
/feature    - Add new features
/test       - Run $test_framework tests
/release    - Create versioned release
/review     - Code review
/ideas      - Generate project ideas
\`\`\`

## Project Conventions
- Use TodoWrite for task planning
- Follow existing code patterns
- Update changelog for all changes
- Create meaningful commit messages
- Test before deploying

## Development Workflow
1. Create feature/fix with slash command
2. Implement following conventions
3. Test thoroughly
4. Update documentation
5. Deploy with /deploy

## Notes
[Add project-specific notes here]

---
*Powered by Claude Automation Framework v$FRAMEWORK_VERSION*
EOF

    print_success "Created CLAUDE.md"
}

# Create framework configuration
create_config() {
    local project_type="$1"

    cat > ".claude/config.yml" << EOF
# Claude Automation Framework Configuration
version: $FRAMEWORK_VERSION
project:
  type: $project_type
  detected_at: $(date +%Y-%m-%d)

automation:
  enabled: true

  commits:
    format: conventional
    types:
      - feat
      - fix
      - docs
      - style
      - refactor
      - perf
      - test
      - chore

  changelog:
    enabled: true
    file: CHANGELOG.md
    sections:
      - Added
      - Changed
      - Fixed
      - Removed

  testing:
    run_before_deploy: true
    coverage_threshold: 80

  deployment:
    require_clean_git: true
    require_tests_pass: true
    create_tag: true

quality:
  linting:
    enabled: true
    fix_on_commit: true

  formatting:
    enabled: true
    tool: auto-detect

tracking:
  todos:
    use_todowrite: true

  metrics:
    track_bundle_size: true
    track_performance: true
EOF

    print_success "Created configuration"
}

# Main installation function
main() {
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║   Claude Automation Framework Setup    ║${NC}"
    echo -e "${BLUE}║           Version $FRAMEWORK_VERSION              ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo

    # Detect project characteristics
    print_info "Analyzing project..."

    PROJECT_TYPE=$(detect_project_type)
    DEPLOY_PLATFORM=$(detect_deployment_platform)
    TEST_FRAMEWORK=$(detect_test_framework)

    print_info "Detected project type: ${GREEN}$PROJECT_TYPE${NC}"
    print_info "Detected deployment: ${GREEN}$DEPLOY_PLATFORM${NC}"
    print_info "Detected testing: ${GREEN}$TEST_FRAMEWORK${NC}"
    echo

    # Create directory structure
    print_info "Creating .claude directory structure..."
    mkdir -p .claude/commands
    mkdir -p .claude/templates
    mkdir -p .claude/workflows

    # Create command files
    print_info "Installing commands..."
    create_core_commands

    # Update commands with detected values
    sed -i.bak "s/DEPLOYMENT_PLATFORM/$DEPLOY_PLATFORM/g" .claude/commands/deploy.md
    sed -i.bak "s/TEST_FRAMEWORK/$TEST_FRAMEWORK/g" .claude/commands/test.md
    rm .claude/commands/*.bak 2>/dev/null || true

    # Create CLAUDE.md
    print_info "Creating project context..."
    create_claude_md "$PROJECT_TYPE" "$DEPLOY_PLATFORM" "$TEST_FRAMEWORK"

    # Create configuration
    print_info "Creating configuration..."
    create_config "$PROJECT_TYPE"

    # Create .gitignore entries
    if [ -f ".gitignore" ]; then
        if ! grep -q ".claude/config.local.yml" .gitignore; then
            echo -e "\n# Claude Automation Framework" >> .gitignore
            echo ".claude/config.local.yml" >> .gitignore
            echo ".claude/cache/" >> .gitignore
            print_success "Updated .gitignore"
        fi
    fi

    # Success message
    echo
    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║        Installation Complete! 🎉        ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo
    echo "Next steps:"
    echo "  1. Review ${BLUE}CLAUDE.md${NC} and add project notes"
    echo "  2. Check ${BLUE}.claude/commands/${NC} for available commands"
    echo "  3. Try ${GREEN}/deploy${NC} or ${GREEN}/test${NC} in Claude Code"
    echo "  4. Customize ${BLUE}.claude/config.yml${NC} as needed"
    echo
    echo "Get started: Open Claude Code and type ${GREEN}/help${NC}"
    echo
}

# Run the installer
main "$@"