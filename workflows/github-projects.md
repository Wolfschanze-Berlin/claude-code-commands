# GitHub Projects Creation Workflow

Create paired GitHub Projects (Kanban and BugTracker) for development initiatives with automatic repository linking and configuration.

## Context

I need to create GitHub project management boards for: $ARGUMENTS

This workflow automatically creates two complementary GitHub projects:
- **[PREFIX] - Kanban**: For feature development and task management  
- **[PREFIX] - BugTracker**: For issue tracking and bug management

## Workflow Steps

### 1. Environment Validation
Use the deployment-engineer agent to:
- Verify GitHub CLI is installed and authenticated:
  ```bash
  gh auth status
  ```
- Check current repository context:
  ```bash
  git remote get-url origin
  ```
- Get authenticated user information:
  ```bash
  gh api user --jq '.login,.node_id'
  ```
- Verify access to template projects (#66 for Kanban, #67 for BugTracker)
- Ensure project creation permissions exist

### 2. Template Verification
Use the backend-architect agent to:
- Verify template projects exist and are accessible:
  ```bash
  gh project view 66 --owner FrancisVarga --format json
  gh project view 67 --owner FrancisVarga --format json
  ```
- Extract template project IDs:
  - Kanban Template ID: `PVT_kwHOAAIrCs4BAngq` (Project #66)
  - BugTracker Template ID: `PVT_kwHOAAIrCs4BAngu` (Project #67)
- Document template field structures for reference

### 3. Create Kanban Project
Use the Task tool with subagent_type="deployment-engineer" to:
- Copy the Kanban template using GraphQL API:
  ```bash
  gh api graphql -f query='
  mutation($project:ID!,$owner:ID!,$title:String!){
    copyProjectV2(input:{
      projectId:$project
      ownerId:$owner
      title:$title
      includeDraftIssues:true
    }){
      projectV2 { id number title url }
    }
  }' \
  -f project="PVT_kwHOAAIrCs4BAngq" \
  -f owner="$(gh api user --jq '.node_id')" \
  -f title="$ARGUMENTS - Kanban"
  ```
- Extract the new project number and ID from response
- Store project details for linking phase

### 4. Create BugTracker Project
Use the Task tool with subagent_type="deployment-engineer" to:
- Copy the BugTracker template using GraphQL API:
  ```bash
  gh api graphql -f query='
  mutation($project:ID!,$owner:ID!,$title:String!){
    copyProjectV2(input:{
      projectId:$project
      ownerId:$owner
      title:$title
      includeDraftIssues:true
    }){
      projectV2 { id number title url }
    }
  }' \
  -f project="PVT_kwHOAAIrCs4BAngu" \
  -f owner="$(gh api user --jq '.node_id')" \
  -f title="$ARGUMENTS - BugTracker"
  ```
- Extract the new project number and ID from response
- Store project details for configuration

### 5. Link Projects to Repository
Use the devops-troubleshooter agent to:
- Get current repository from git remote:
  ```bash
  REPO=$(git remote get-url origin | sed 's/.*github.com[:\/]\(.*\)\.git/\1/')
  ```
- Link Kanban project to repository:
  ```bash
  gh project link [KANBAN_NUMBER] --owner [OWNER] --repo [REPO]
  ```
- Link BugTracker project to repository:
  ```bash
  gh project link [BUGTRACKER_NUMBER] --owner [OWNER] --repo [REPO]
  ```
- Verify links were created successfully

### 6. Configure Project Visibility
Use the backend-architect agent to:
- Make Kanban project public:
  ```bash
  gh api graphql -f query='
  mutation { 
    updateProjectV2(input: {
      projectId: "[KANBAN_ID]", 
      public: true
    }) { 
      projectV2 { id public title url } 
    } 
  }'
  ```
- Make BugTracker project public:
  ```bash
  gh api graphql -f query='
  mutation { 
    updateProjectV2(input: {
      projectId: "[BUGTRACKER_ID]", 
      public: true
    }) { 
      projectV2 { id public title url } 
    } 
  }'
  ```

### 7. Verify Project Structure
Use the architect-reviewer agent to:
- Verify Kanban project fields:
  - Status (Todo, In Progress, Done)
  - Priority (Low, Medium, High, Critical)
  - Size (XS, S, M, L, XL)
  - Estimate, Start date, End date
- Verify BugTracker project fields:
  - Status (New, Triaged, In Progress, Testing, Resolved)
  - Priority (P0, P1, P2, P3)
  - Size (Quick Fix, Small, Medium, Large, Epic)
  - Iteration (Sprint tracking)
  - Start date, End date

### 8. Documentation and Next Steps
Use the doc-generate agent to:
- Create a project overview document with:
  ```markdown
  # $ARGUMENTS GitHub Projects
  
  ## Created Projects
  
  ### $ARGUMENTS - Kanban
  - **Project Number**: #[KANBAN_NUMBER]
  - **URL**: [KANBAN_URL]
  - **Purpose**: Feature development and task management
  - **Fields**: Status, Priority, Size, Estimate, Dates
  
  ### $ARGUMENTS - BugTracker
  - **Project Number**: #[BUGTRACKER_NUMBER]
  - **URL**: [BUGTRACKER_URL]
  - **Purpose**: Issue tracking and bug management
  - **Fields**: Status, Priority, Size, Iteration, Dates
  
  ## Next Steps
  1. Add existing issues to projects using:
     `gh project item-add [PROJECT_NUMBER] --owner [OWNER] --issue [ISSUE_NUMBER]`
  2. Configure automation rules in project settings
  3. Invite team members to collaborate
  4. Set up GitHub Actions for automatic issue assignment
  ```

### 9. Optional: Populate with Existing Issues
If requested, use the Task tool with subagent_type="deployment-engineer" to:
- List open issues in repository:
  ```bash
  gh issue list --repo [REPO] --state open --json number --jq '.[].number'
  ```
- Add issues to appropriate project based on labels:
  ```bash
  # For feature/enhancement issues → Kanban
  gh project item-add [KANBAN_NUMBER] --owner [OWNER] --issue [ISSUE_NUMBER]
  
  # For bug issues → BugTracker  
  gh project item-add [BUGTRACKER_NUMBER] --owner [OWNER] --issue [ISSUE_NUMBER]
  ```

### 10. Final Verification
Use the architect-reviewer agent to:
- Confirm both projects are created and accessible
- Verify projects are linked to repository
- Check that projects are public (if intended)
- Validate field configurations match templates
- Generate summary report with project URLs and numbers

## Success Criteria

- ✅ GitHub CLI authenticated with project permissions
- ✅ Both template projects (#66 and #67) accessible
- ✅ Kanban project created with name "$ARGUMENTS - Kanban"
- ✅ BugTracker project created with name "$ARGUMENTS - BugTracker"
- ✅ Both projects linked to current repository
- ✅ Projects set to public visibility
- ✅ All template fields properly copied
- ✅ Project URLs and numbers documented
- ✅ Projects accessible via web interface

## Error Handling

### Authentication Issues
- If `gh auth status` fails:
  ```bash
  gh auth login
  # Select GitHub.com → HTTPS → Browser authentication
  # Ensure 'project' scope is included
  ```

### Template Access Issues
- If template projects not found:
  - Verify owner is correct: `gh project list --owner FrancisVarga`
  - Check project numbers are correct (#66 for Kanban, #67 for BugTracker)
  - Fall back to creating basic projects without template

### GraphQL Errors
- If "Could not resolve to a node" error:
  - Re-fetch user ID: `gh api user --jq '.node_id'`
  - Verify project IDs are correct format (PVT_...)
  
### Repository Linking Issues
- If linking fails:
  - Verify repository format: `OWNER/REPO`
  - Check repository permissions
  - Ensure projects were created successfully first

### Visibility Issues
- If projects remain private:
  - Check organization settings for public project permissions
  - Manually update via GitHub web interface if needed

## Examples

### Basic Usage
```bash
# Create projects for maintenance cycle
/workflow github-projects Maintenance
# Creates: "Maintenance - Kanban" and "Maintenance - BugTracker"

# Create projects for specific feature
/workflow github-projects "User Authentication"
# Creates: "User Authentication - Kanban" and "User Authentication - BugTracker"

# Create projects for sprint
/workflow github-projects "Sprint 2024-Q1"
# Creates: "Sprint 2024-Q1 - Kanban" and "Sprint 2024-Q1 - BugTracker"
```

### With Issue Population
```bash
# Create and populate projects
/workflow github-projects "Q1 Development" --populate-issues
```

### Batch Creation
```bash
# Create multiple project pairs
for prefix in "Frontend" "Backend" "Infrastructure"; do
  /workflow github-projects "$prefix"
done
```

## Integration Points

### GitHub Actions
```yaml
name: Create Sprint Projects
on:
  workflow_dispatch:
    inputs:
      project_prefix:
        description: 'Project name prefix'
        required: true
        type: string

jobs:
  create-projects:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Create GitHub Projects
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          # Run workflow script
          ./.claude/commands/workflows/scripts/github-projects.sh "${{ inputs.project_prefix }}"
```

### VS Code Task
```json
{
  "label": "Create GitHub Projects",
  "type": "shell",
  "command": "claude",
  "args": [
    "run",
    "/workflow",
    "github-projects",
    "${input:projectPrefix}"
  ],
  "problemMatcher": []
}
```

## Related Workflows

- `/workflow init-project` - Initialize new projects with documentation
- `/workflow git-workflow` - Complete git workflow with PR creation
- `/workflow feature-development` - Implement features with project tracking

Project prefix: $ARGUMENTS