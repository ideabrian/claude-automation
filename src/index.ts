/**
 * Claude Automation Framework - Core Implementation
 * Universal development automation for all projects
 */

import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';
import { execSync } from 'child_process';

// ============================================================================
// Type Definitions
// ============================================================================

interface ProjectEnvironment {
  type: ProjectType;
  framework?: Framework;
  deployment?: DeploymentPlatform;
  testing?: TestFramework;
  database?: Database;
  packageManager?: PackageManager;
  language: Language;
}

interface AutomationConfig {
  version: string;
  project: ProjectConfig;
  automation: AutomationSettings;
  quality: QualitySettings;
  tracking: TrackingSettings;
}

interface ProjectConfig {
  name: string;
  type: string;
  environment: ProjectEnvironment;
}

interface AutomationSettings {
  changelog: ChangelogConfig;
  commits: CommitConfig;
  testing: TestingConfig;
  deployment: DeploymentConfig;
  documentation: DocumentationConfig;
}

interface Command {
  name: string;
  description: string;
  template: string;
  adapters?: AdapterMap;
}

interface AdapterMap {
  [key: string]: CommandAdapter;
}

interface CommandAdapter {
  detect: () => boolean;
  adapt: (template: string) => string;
}

// ============================================================================
// Enums
// ============================================================================

enum ProjectType {
  React = 'react',
  Vue = 'vue',
  Angular = 'angular',
  Next = 'nextjs',
  Nuxt = 'nuxt',
  Node = 'node',
  Python = 'python',
  Django = 'django',
  FastAPI = 'fastapi',
  Rails = 'rails',
  Laravel = 'laravel',
  Go = 'go',
  Rust = 'rust',
  Unknown = 'unknown'
}

enum Framework {
  Express = 'express',
  Fastify = 'fastify',
  Koa = 'koa',
  NestJS = 'nestjs',
  Flask = 'flask',
  FastAPI = 'fastapi',
  Django = 'django',
  Rails = 'rails',
  Gin = 'gin',
  Actix = 'actix'
}

enum DeploymentPlatform {
  Vercel = 'vercel',
  Netlify = 'netlify',
  CloudFlare = 'cloudflare',
  AWS = 'aws',
  Heroku = 'heroku',
  Docker = 'docker',
  Kubernetes = 'kubernetes',
  GitHubPages = 'github-pages'
}

enum TestFramework {
  Jest = 'jest',
  Vitest = 'vitest',
  Mocha = 'mocha',
  Cypress = 'cypress',
  Playwright = 'playwright',
  PyTest = 'pytest',
  RSpec = 'rspec',
  GoTest = 'go-test',
  CargoTest = 'cargo-test'
}

enum PackageManager {
  NPM = 'npm',
  Yarn = 'yarn',
  PNPM = 'pnpm',
  Bun = 'bun',
  Pip = 'pip',
  Poetry = 'poetry',
  Bundler = 'bundler',
  Cargo = 'cargo',
  Go = 'go'
}

enum Language {
  JavaScript = 'javascript',
  TypeScript = 'typescript',
  Python = 'python',
  Ruby = 'ruby',
  Go = 'go',
  Rust = 'rust',
  PHP = 'php',
  Java = 'java',
  CSharp = 'csharp'
}

// ============================================================================
// Detection System
// ============================================================================

export class EnvironmentDetector {
  private projectRoot: string;

  constructor(projectRoot: string = process.cwd()) {
    this.projectRoot = projectRoot;
  }

  /**
   * Detect complete project environment
   */
  async detectEnvironment(): Promise<ProjectEnvironment> {
    return {
      type: await this.detectProjectType(),
      framework: await this.detectFramework(),
      deployment: await this.detectDeploymentPlatform(),
      testing: await this.detectTestFramework(),
      database: await this.detectDatabase(),
      packageManager: await this.detectPackageManager(),
      language: await this.detectLanguage()
    };
  }

  /**
   * Detect project type based on files and dependencies
   */
  private async detectProjectType(): Promise<ProjectType> {
    const checks: Array<[() => boolean, ProjectType]> = [
      [() => this.hasFile('package.json') && this.hasDependency('react'), ProjectType.React],
      [() => this.hasFile('package.json') && this.hasDependency('vue'), ProjectType.Vue],
      [() => this.hasFile('angular.json'), ProjectType.Angular],
      [() => this.hasFile('next.config.js') || this.hasFile('next.config.ts'), ProjectType.Next],
      [() => this.hasFile('nuxt.config.js') || this.hasFile('nuxt.config.ts'), ProjectType.Nuxt],
      [() => this.hasFile('manage.py'), ProjectType.Django],
      [() => this.hasDependency('fastapi', 'requirements.txt'), ProjectType.FastAPI],
      [() => this.hasFile('config/routes.rb'), ProjectType.Rails],
      [() => this.hasFile('artisan'), ProjectType.Laravel],
      [() => this.hasFile('go.mod'), ProjectType.Go],
      [() => this.hasFile('Cargo.toml'), ProjectType.Rust],
      [() => this.hasFile('package.json'), ProjectType.Node],
      [() => this.hasFile('requirements.txt') || this.hasFile('setup.py'), ProjectType.Python]
    ];

    for (const [check, type] of checks) {
      if (check()) return type;
    }

    return ProjectType.Unknown;
  }

  /**
   * Detect deployment platform
   */
  private async detectDeploymentPlatform(): Promise<DeploymentPlatform | undefined> {
    const checks: Array<[() => boolean, DeploymentPlatform]> = [
      [() => this.hasFile('vercel.json') || this.hasDir('.vercel'), DeploymentPlatform.Vercel],
      [() => this.hasFile('netlify.toml') || this.hasDir('.netlify'), DeploymentPlatform.Netlify],
      [() => this.hasFile('wrangler.toml'), DeploymentPlatform.CloudFlare],
      [() => this.hasFile('Dockerfile'), DeploymentPlatform.Docker],
      [() => this.hasFile('Procfile'), DeploymentPlatform.Heroku],
      [() => this.hasFile('serverless.yml'), DeploymentPlatform.AWS],
      [() => this.hasFile('kubernetes.yml') || this.hasDir('k8s'), DeploymentPlatform.Kubernetes]
    ];

    for (const [check, platform] of checks) {
      if (check()) return platform;
    }

    return undefined;
  }

  /**
   * Detect test framework
   */
  private async detectTestFramework(): Promise<TestFramework | undefined> {
    const checks: Array<[() => boolean, TestFramework]> = [
      [() => this.hasDependency('jest'), TestFramework.Jest],
      [() => this.hasDependency('vitest'), TestFramework.Vitest],
      [() => this.hasDependency('mocha'), TestFramework.Mocha],
      [() => this.hasDependency('cypress'), TestFramework.Cypress],
      [() => this.hasDependency('playwright'), TestFramework.Playwright],
      [() => this.hasDependency('pytest', 'requirements.txt'), TestFramework.PyTest],
      [() => this.hasDependency('rspec', 'Gemfile'), TestFramework.RSpec]
    ];

    for (const [check, framework] of checks) {
      if (check()) return framework;
    }

    return undefined;
  }

  /**
   * Detect package manager
   */
  private async detectPackageManager(): Promise<PackageManager> {
    if (this.hasFile('bun.lockb')) return PackageManager.Bun;
    if (this.hasFile('pnpm-lock.yaml')) return PackageManager.PNPM;
    if (this.hasFile('yarn.lock')) return PackageManager.Yarn;
    if (this.hasFile('package-lock.json')) return PackageManager.NPM;
    if (this.hasFile('poetry.lock')) return PackageManager.Poetry;
    if (this.hasFile('Pipfile.lock')) return PackageManager.Pip;
    if (this.hasFile('Gemfile.lock')) return PackageManager.Bundler;
    if (this.hasFile('Cargo.lock')) return PackageManager.Cargo;
    if (this.hasFile('go.sum')) return PackageManager.Go;

    return PackageManager.NPM; // Default
  }

  /**
   * Detect programming language
   */
  private async detectLanguage(): Promise<Language> {
    if (this.hasFile('tsconfig.json')) return Language.TypeScript;
    if (this.hasFile('package.json')) return Language.JavaScript;
    if (this.hasFile('requirements.txt') || this.hasFile('setup.py')) return Language.Python;
    if (this.hasFile('Gemfile')) return Language.Ruby;
    if (this.hasFile('go.mod')) return Language.Go;
    if (this.hasFile('Cargo.toml')) return Language.Rust;
    if (this.hasFile('composer.json')) return Language.PHP;
    if (this.hasFile('pom.xml') || this.hasFile('build.gradle')) return Language.Java;
    if (this.hasFile('*.csproj')) return Language.CSharp;

    return Language.JavaScript; // Default
  }

  /**
   * Check if file exists
   */
  private hasFile(filename: string): boolean {
    try {
      return fs.existsSync(path.join(this.projectRoot, filename));
    } catch {
      return false;
    }
  }

  /**
   * Check if directory exists
   */
  private hasDir(dirname: string): boolean {
    try {
      const stats = fs.statSync(path.join(this.projectRoot, dirname));
      return stats.isDirectory();
    } catch {
      return false;
    }
  }

  /**
   * Check if dependency exists
   */
  private hasDependency(dep: string, file: string = 'package.json'): boolean {
    try {
      const content = fs.readFileSync(path.join(this.projectRoot, file), 'utf-8');
      return content.includes(dep);
    } catch {
      return false;
    }
  }

  /**
   * Detect database
   */
  private async detectDatabase(): Promise<string | undefined> {
    // Check environment variables
    if (process.env.DATABASE_URL) {
      if (process.env.DATABASE_URL.includes('postgres')) return 'postgresql';
      if (process.env.DATABASE_URL.includes('mysql')) return 'mysql';
      if (process.env.DATABASE_URL.includes('mongodb')) return 'mongodb';
    }

    // Check config files
    if (this.hasFile('database.yml')) {
      const content = fs.readFileSync(path.join(this.projectRoot, 'database.yml'), 'utf-8');
      if (content.includes('postgresql')) return 'postgresql';
      if (content.includes('mysql')) return 'mysql';
      if (content.includes('sqlite')) return 'sqlite';
    }

    // Check dependencies
    if (this.hasDependency('pg')) return 'postgresql';
    if (this.hasDependency('mysql')) return 'mysql';
    if (this.hasDependency('mongoose')) return 'mongodb';
    if (this.hasDependency('sqlite3')) return 'sqlite';

    return undefined;
  }
}

// ============================================================================
// Command System
// ============================================================================

export class CommandManager {
  private commands: Map<string, Command> = new Map();
  private environment: ProjectEnvironment;

  constructor(environment: ProjectEnvironment) {
    this.environment = environment;
    this.loadCoreCommands();
  }

  /**
   * Load core commands that work across all projects
   */
  private loadCoreCommands(): void {
    this.registerCommand({
      name: 'deploy',
      description: 'Deploy project to production',
      template: this.getDeployTemplate(),
      adapters: this.getDeployAdapters()
    });

    this.registerCommand({
      name: 'test',
      description: 'Run all tests',
      template: this.getTestTemplate(),
      adapters: this.getTestAdapters()
    });

    this.registerCommand({
      name: 'fix',
      description: 'Fix a bug with documentation',
      template: this.getFixTemplate()
    });

    this.registerCommand({
      name: 'feature',
      description: 'Add a new feature',
      template: this.getFeatureTemplate()
    });

    this.registerCommand({
      name: 'release',
      description: 'Create a new release',
      template: this.getReleaseTemplate()
    });
  }

  /**
   * Register a new command
   */
  registerCommand(command: Command): void {
    this.commands.set(command.name, command);
  }

  /**
   * Get command template adapted for current environment
   */
  getCommand(name: string): string {
    const command = this.commands.get(name);
    if (!command) {
      throw new Error(`Command '${name}' not found`);
    }

    let template = command.template;

    // Apply adapters based on environment
    if (command.adapters) {
      for (const [key, adapter] of Object.entries(command.adapters)) {
        if (adapter.detect()) {
          template = adapter.adapt(template);
        }
      }
    }

    // Replace environment variables
    template = this.replaceEnvironmentVars(template);

    return template;
  }

  /**
   * Replace environment variables in template
   */
  private replaceEnvironmentVars(template: string): string {
    const replacements: Record<string, string> = {
      PROJECT_TYPE: this.environment.type,
      FRAMEWORK: this.environment.framework || 'none',
      DEPLOYMENT: this.environment.deployment || 'manual',
      TEST_FRAMEWORK: this.environment.testing || 'none',
      DATABASE: this.environment.database || 'none',
      PACKAGE_MANAGER: this.environment.packageManager || 'npm',
      LANGUAGE: this.environment.language
    };

    let result = template;
    for (const [key, value] of Object.entries(replacements)) {
      result = result.replace(new RegExp(`{{${key}}}`, 'g'), value);
    }

    return result;
  }

  /**
   * Get deploy command template
   */
  private getDeployTemplate(): string {
    return `Deploy to {{DEPLOYMENT}}:

1. Pre-deployment checks
2. Build project using {{PACKAGE_MANAGER}}
3. Run tests with {{TEST_FRAMEWORK}}
4. Deploy to {{DEPLOYMENT}}
5. Verify deployment
6. Update changelog
7. Create deployment tag`;
  }

  /**
   * Get test command template
   */
  private getTestTemplate(): string {
    return `Run tests with {{TEST_FRAMEWORK}}:

1. Run unit tests
2. Run integration tests
3. Check code coverage
4. Run linting
5. Run type checking
6. Generate test report`;
  }

  /**
   * Get fix command template
   */
  private getFixTemplate(): string {
    return `Fix bug: $ARGUMENTS

1. Create TodoWrite plan
2. Search for related code
3. Implement fix
4. Add tests
5. Update changelog
6. Commit with: "fix: $1"`;
  }

  /**
   * Get feature command template
   */
  private getFeatureTemplate(): string {
    return `Add feature: $ARGUMENTS

1. Plan with TodoWrite
2. Implement following patterns
3. Add comprehensive tests
4. Update documentation
5. Update changelog
6. Commit with: "feat: $1"`;
  }

  /**
   * Get release command template
   */
  private getReleaseTemplate(): string {
    return `Create release $1:

1. Update version
2. Run all tests
3. Build for production
4. Create git tag
5. Deploy to production
6. Generate release notes
7. Update changelog`;
  }

  /**
   * Get deployment adapters for different platforms
   */
  private getDeployAdapters(): AdapterMap {
    return {
      vercel: {
        detect: () => this.environment.deployment === DeploymentPlatform.Vercel,
        adapt: (template) => template.replace('Deploy to {{DEPLOYMENT}}', 'Deploy to Vercel using `vercel --prod`')
      },
      netlify: {
        detect: () => this.environment.deployment === DeploymentPlatform.Netlify,
        adapt: (template) => template.replace('Deploy to {{DEPLOYMENT}}', 'Deploy to Netlify using `netlify deploy --prod`')
      },
      cloudflare: {
        detect: () => this.environment.deployment === DeploymentPlatform.CloudFlare,
        adapt: (template) => template.replace('Deploy to {{DEPLOYMENT}}', 'Deploy to CloudFlare using `wrangler publish`')
      }
    };
  }

  /**
   * Get test adapters for different frameworks
   */
  private getTestAdapters(): AdapterMap {
    return {
      jest: {
        detect: () => this.environment.testing === TestFramework.Jest,
        adapt: (template) => template.replace('Run tests with {{TEST_FRAMEWORK}}', 'Run tests with Jest using `npm test`')
      },
      vitest: {
        detect: () => this.environment.testing === TestFramework.Vitest,
        adapt: (template) => template.replace('Run tests with {{TEST_FRAMEWORK}}', 'Run tests with Vitest using `npm run test`')
      },
      pytest: {
        detect: () => this.environment.testing === TestFramework.PyTest,
        adapt: (template) => template.replace('Run tests with {{TEST_FRAMEWORK}}', 'Run tests with PyTest using `pytest`')
      }
    };
  }
}

// ============================================================================
// Framework Installer
// ============================================================================

export class FrameworkInstaller {
  private projectRoot: string;
  private environment: ProjectEnvironment;

  constructor(projectRoot: string = process.cwd()) {
    this.projectRoot = projectRoot;
  }

  /**
   * Install the framework to a project
   */
  async install(): Promise<void> {
    console.log('🚀 Installing Claude Automation Framework...\n');

    // Detect environment
    const detector = new EnvironmentDetector(this.projectRoot);
    this.environment = await detector.detectEnvironment();

    console.log(`📦 Project Type: ${this.environment.type}`);
    console.log(`🚀 Deployment: ${this.environment.deployment || 'not detected'}`);
    console.log(`🧪 Testing: ${this.environment.testing || 'not detected'}`);
    console.log(`📝 Language: ${this.environment.language}\n`);

    // Create directory structure
    this.createDirectoryStructure();

    // Install commands
    this.installCommands();

    // Create configuration
    this.createConfiguration();

    // Create CLAUDE.md
    this.createClaudeMd();

    console.log('\n✅ Claude Automation Framework installed successfully!');
    console.log('\nNext steps:');
    console.log('1. Open Claude Code');
    console.log('2. Try /deploy or /test commands');
    console.log('3. Customize .claude/config.yml as needed');
  }

  /**
   * Create .claude directory structure
   */
  private createDirectoryStructure(): void {
    const dirs = [
      '.claude',
      '.claude/commands',
      '.claude/templates',
      '.claude/workflows'
    ];

    for (const dir of dirs) {
      const fullPath = path.join(this.projectRoot, dir);
      if (!fs.existsSync(fullPath)) {
        fs.mkdirSync(fullPath, { recursive: true });
      }
    }

    console.log('✓ Created .claude directory structure');
  }

  /**
   * Install command files
   */
  private installCommands(): void {
    const commandManager = new CommandManager(this.environment);

    // Core commands
    const commands = ['deploy', 'test', 'fix', 'feature', 'release'];

    for (const cmdName of commands) {
      const content = commandManager.getCommand(cmdName);
      const cmdPath = path.join(this.projectRoot, `.claude/commands/${cmdName}.md`);

      fs.writeFileSync(cmdPath, `---
description: ${cmdName} command
---

${content}`);
    }

    console.log('✓ Installed command files');
  }

  /**
   * Create configuration file
   */
  private createConfiguration(): void {
    const config: AutomationConfig = {
      version: '1.0.0',
      project: {
        name: path.basename(this.projectRoot),
        type: this.environment.type,
        environment: this.environment
      },
      automation: {
        changelog: {
          enabled: true,
          file: 'CHANGELOG.md',
          format: 'conventional'
        },
        commits: {
          format: 'conventional',
          signoff: true
        },
        testing: {
          runBeforeDeploy: true,
          coverageThreshold: 80
        },
        deployment: {
          requireTests: true,
          createTag: true
        },
        documentation: {
          autoUpdate: true
        }
      },
      quality: {
        linting: {
          enabled: true,
          fixOnSave: true
        },
        formatting: {
          enabled: true
        }
      },
      tracking: {
        todos: {
          useTodoWrite: true
        },
        metrics: {
          trackPerformance: true
        }
      }
    };

    const configPath = path.join(this.projectRoot, '.claude/config.yml');
    fs.writeFileSync(configPath, yaml.dump(config));

    console.log('✓ Created configuration file');
  }

  /**
   * Create CLAUDE.md file
   */
  private createClaudeMd(): void {
    const content = `# Claude Code Project Context

## Project Information
- **Type**: ${this.environment.type}
- **Language**: ${this.environment.language}
- **Framework**: ${this.environment.framework || 'none'}
- **Testing**: ${this.environment.testing || 'none'}
- **Deployment**: ${this.environment.deployment || 'manual'}
- **Database**: ${this.environment.database || 'none'}

## Available Commands
- /deploy - Deploy to production
- /test - Run all tests
- /fix [bug] - Fix bugs with documentation
- /feature [name] - Add new features
- /release [version] - Create releases

## Project Conventions
[Add your project-specific conventions here]

## Notes
[Add project-specific notes here]

---
*Powered by Claude Automation Framework v1.0.0*
`;

    fs.writeFileSync(path.join(this.projectRoot, 'CLAUDE.md'), content);

    console.log('✓ Created CLAUDE.md');
  }
}

// ============================================================================
// CLI Entry Point
// ============================================================================

if (require.main === module) {
  const installer = new FrameworkInstaller();
  installer.install().catch(console.error);
}