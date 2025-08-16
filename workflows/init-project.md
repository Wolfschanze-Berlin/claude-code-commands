# Claude Code Project Initialization Workflow

Set up a modern documentation site with Docusaurus and Claude Code enhancements, including project initialization, configuration, gitignore updates, AGENT.md documentation, and Claude Code commands/agents integration.

## Context

I need to set up a new Claude Code enhanced documentation site for the project: $ARGUMENTS

## Workflow Steps

Always check first if already exists or not.

### 1. Claude Code Setup
Use the deployment-engineer agent to:
- Create a `.claude` directory in the project root if it doesn't exist
- Add Claude Code commands as a git submodule:
  ```bash
  git submodule add https://github.com/Wolfschanze-Berlin/claude-code-commands .claude/commands
  ```
- Add Claude Code agents as a git submodule:
  ```bash
  git submodule add https://github.com/Wolfschanze-Berlin/claude-code-agents .claude/agents
  ```
- Initialize the submodules:
  ```bash
  git submodule update --init --recursive
  ```
- Verify both submodules are properly cloned and accessible

### 2. Project Initialization
Use the deployment-engineer agent to:
- Create the Docusaurus project using `npx create-docusaurus@latest gutenberg classic --typescript`
- Ensure the project is created in the correct directory
- Handle any prompts during setup (use defaults where appropriate)
- Verify the installation completed successfully

### 3. Update .gitignore
Use the backend-architect agent to:
- Update the root .gitignore file to include Docusaurus-specific entries:
  ```
  # Docusaurus
  gutenberg/.docusaurus
  gutenberg/.cache-loader
  gutenberg/build
  gutenberg/node_modules
  gutenberg/.env.local
  gutenberg/.env.*.local
  gutenberg/npm-debug.log*
  gutenberg/yarn-debug.log*
  gutenberg/yarn-error.log*
  
  # Claude Code
  .claude/settings.local.json
  .ai-files/
  ```
- Ensure no duplicate entries
- Preserve existing gitignore rules

### 4. Initial Configuration
Use the frontend-developer agent to:
- Update `docusaurus.config.ts` with project-specific details:
  - Set appropriate title and tagline
  - Configure the URL and baseUrl
  - Update organizationName and projectName
  - Set up dark mode as default if requested
  - Configure navbar and footer with relevant links
- Ensure TypeScript configuration is properly set up
- Add any custom CSS variables for theming

### 5. Create AGENT.md Documentation
Use the architect-reviewer agent to:
- Create an AGENT.md file in the project root with the following structure:
  ```markdown
  # Project Agent Configuration

  ## Overview
  This document defines how AI agents should interact with this Docusaurus documentation project.

  ## Project Structure
  ```
  .claude/
  ├── agents/                 # Claude Code agents (submodule)
  ├── commands/               # Claude Code commands (submodule)
  └── settings.local.json     # Local Claude Code settings
  
  gutenberg/
  ├── blog/                    # Blog posts
  ├── docs/                    # Documentation files
  ├── src/                     # Source files
  │   ├── components/         # React components
  │   ├── css/               # Global styles
  │   └── pages/             # Custom pages
  ├── static/                 # Static assets
  ├── docusaurus.config.ts    # Main configuration
  ├── sidebars.ts            # Sidebar configuration
  └── package.json           # Dependencies
  
  .ai-files/                   # AI-related storage
  └── memory.json             # Claude Code memory persistence
  ```

  ## Development Guidelines

  ### 1. Documentation Standards
  - Use clear, concise language
  - Include code examples where appropriate
  - Follow the existing markdown structure
  - Add proper frontmatter to all docs

  ### 2. Component Development
  - Follow React best practices
  - Use TypeScript for type safety
  - Keep components modular and reusable
  - Document component props

  ### 3. Styling Guidelines
  - Use CSS modules for component styles
  - Follow the existing theme variables
  - Ensure dark mode compatibility
  - Maintain responsive design

  ### 4. Configuration Updates
  - Always update docusaurus.config.ts for site-wide changes
  - Use sidebars.ts for navigation structure
  - Keep URLs and paths consistent

  ## Common Tasks

  ### Adding Documentation
  1. Create markdown files in the `docs/` directory
  2. Add frontmatter with id, title, and sidebar_label
  3. Update sidebars.ts if needed

  ### Creating Components
  1. Add new components to `src/components/`
  2. Use TypeScript interfaces for props
  3. Export from a central index file

  ### Updating Themes
  1. Modify `src/css/custom.css` for global styles
  2. Use CSS variables for consistency
  3. Test in both light and dark modes

  ## Build and Deployment

  ### Local Development
  ```bash
  cd gutenberg
  npm install
  npm start
  ```

  ### Development with Dev Containers
  1. Open project in VS Code
  2. Install "Dev Containers" extension if not already installed
  3. Press F1 and select "Dev Containers: Reopen in Container"
  4. Wait for container to build and start (includes installing fnm, pyenv, bun, pnpm)
  5. Terminal commands will run inside the container
  
  #### Available Tools in Dev Container
  - **fnm**: Fast Node Manager for switching Node.js versions
  - **pyenv**: Python version management (3.11.7 and 3.12.1 installed)
  - **bun**: Fast all-in-one JavaScript runtime and toolkit
  - **pnpm**: Fast, disk space efficient package manager
  - **claude**: Claude Code CLI for AI-assisted development
  - **Network capabilities**: NET_ADMIN and NET_RAW for advanced networking

  ### Production Build
  ```bash
  cd gutenberg
  npm run build
  npm run serve  # Test production build
  ```

  ### Deployment
  - The site can be deployed to GitHub Pages, Vercel, or Netlify
  - Ensure baseUrl is correctly configured for the deployment target
  - Use environment variables for sensitive configuration

  ## Best Practices

  1. **Performance**: Optimize images and use lazy loading
  2. **SEO**: Add proper meta tags and descriptions
  3. **Accessibility**: Ensure WCAG compliance
  4. **Version Control**: Commit docs and code separately
  5. **Testing**: Test all changes locally before deploying

  ## Integration Points

  - **Search**: Algolia DocSearch can be integrated
  - **Analytics**: Google Analytics or similar
  - **Comments**: Discourse, Disqus, or Giscus
  - **Versioning**: Use Docusaurus versioning for API docs
  ```

### 6. Initial Content Setup
Use the doc-generate agent to:
- Create a comprehensive README.md in the gutenberg directory
- Set up initial documentation structure in the docs folder
- Create a getting-started guide
- Add a sample blog post to demonstrate the blog functionality

### 7. Theme Customization
Use the ui-ux-designer agent to:
- Set up a modern color scheme in `src/css/custom.css`
- Configure typography and spacing
- Ensure responsive design principles
- Add any custom components needed for the documentation

### 8. Dev Container Setup
Use the devops-troubleshooter agent to:
- Create a `.devcontainer` directory in the project root
- Generate `devcontainer.json` with the following configuration:
  ```json
  {
    "name": "Claude Code Docusaurus Development",
    "image": "mcr.microsoft.com/devcontainers/javascript-node:1-20-bullseye",
    "runArgs": [
      "--cap-add=NET_ADMIN",
      "--cap-add=NET_RAW"
    ],
    "features": {
      "ghcr.io/devcontainers/features/git:1": {},
      "ghcr.io/devcontainers/features/github-cli:1": {},
      "ghcr.io/devcontainers/features/node:1": {
        "version": "20"
      },
      "ghcr.io/devcontainers/features/python:1": {
        "version": "3.11"
      }
    },
    "customizations": {
      "vscode": {
        "extensions": [
          "dbaeumer.vscode-eslint",
          "esbenp.prettier-vscode",
          "bradlc.vscode-tailwindcss",
          "unifiedjs.vscode-mdx",
          "yoavbls.pretty-ts-errors",
          "usernamehw.errorlens",
          "streetsidesoftware.code-spell-checker"
        ],
        "settings": {
          "editor.formatOnSave": true,
          "editor.defaultFormatter": "esbenp.prettier-vscode",
          "editor.codeActionsOnSave": {
            "source.fixAll.eslint": true
          },
          "typescript.tsdk": "node_modules/typescript/lib"
        }
      }
    },
    "postCreateCommand": "chmod +x .devcontainer/setup.sh && .devcontainer/setup.sh",
    "postStartCommand": "git submodule update --init --recursive",
    "forwardPorts": [3000, 3001],
    "portsAttributes": {
      "3000": {
        "label": "Docusaurus Dev Server",
        "onAutoForward": "notify"
      },
      "3001": {
        "label": "Docusaurus Build Preview",
        "onAutoForward": "silent"
      }
    },
    "remoteUser": "node",
    "mounts": [
      "source=${localWorkspaceFolder}/.claude,target=/workspace/.claude,type=bind,consistency=cached"
    ],
    "containerEnv": {
      "NODE_ENV": "development"
    }
  }
  ```
- Create a `.devcontainer/setup.sh` script for cleaner installation:
  ```bash
  #!/bin/bash
  set -e

  # Install fnm (Fast Node Manager)
  curl -fsSL https://fnm.vercel.app/install | bash
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env)"
  
  # Install latest LTS Node.js
  fnm install --lts
  fnm use lts-latest
  fnm default lts-latest
  
  # Install pyenv
  curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  
  # Install Python LTS versions
  pyenv install 3.11.7
  pyenv install 3.12.1
  pyenv global 3.12.1
  
  # Install global npm packages
  npm install -g bun pnpm @anthropic-ai/claude-code
  
  # Install project dependencies
  cd gutenberg && npm install
  
  # Add configurations to shell
  echo '' >> ~/.bashrc
  echo '# fnm' >> ~/.bashrc
  echo 'export PATH="$HOME/.fnm:$PATH"' >> ~/.bashrc
  echo 'eval "$(fnm env)"' >> ~/.bashrc
  echo '' >> ~/.bashrc
  echo '# pyenv' >> ~/.bashrc
  echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
  ```
- Update the `devcontainer.json` to use the setup script:
  ```json
  "postCreateCommand": "chmod +x .devcontainer/setup.sh && .devcontainer/setup.sh",
  ```
- Add devcontainer entries to .gitignore if not already present:
  ```
  # Dev Containers
  .devcontainer/**/devcontainer.json.local
  ```

### 9. Claude Code Configuration
Use the backend-architect agent to:
- Create a `.claude/CLAUDE.md` file with project-specific guidelines
- Set up `.mcp.json` configuration for MCP servers if needed
- Configure any necessary Claude Code settings
- Add example slash commands usage in the documentation
- Document devcontainer usage for team members

### 10. Final Verification
Use the architect-reviewer agent to:
- Verify all files are created correctly
- Ensure the project builds without errors
- Check that the development server runs properly
- Confirm all configurations are appropriate for the project
- Review the AGENT.md for completeness and accuracy

## Success Criteria
- Claude Code commands and agents successfully added as git submodules
- Docusaurus project successfully created with TypeScript
- .gitignore properly updated with Docusaurus and Claude Code entries
- Dev container configuration created and functional
- Configuration files customized for the project
- AGENT.md created with comprehensive guidelines
- Claude Code configuration files created
- Project builds and runs without errors
- Initial documentation structure in place
- Slash commands and agents are accessible and functional
- Development environment works in VS Code Dev Containers

## Error Handling
- If git submodule commands fail, ensure git is installed and repository is initialized
- If npx command fails, check Node.js version (requires Node 16.14+)
- If build fails, verify all dependencies are installed
- For configuration errors, check syntax in TypeScript files
- Ensure all paths are relative and cross-platform compatible
- If submodules already exist, update them instead of adding
- Handle permission errors by checking directory write access