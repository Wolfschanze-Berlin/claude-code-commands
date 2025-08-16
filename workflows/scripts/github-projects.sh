#!/bin/bash
# GitHub Projects Creation Script
# Creates paired Kanban and BugTracker projects from templates

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
KANBAN_TEMPLATE_ID="PVT_kwHOAAIrCs4BAngq"      # Template #66
BUGTRACKER_TEMPLATE_ID="PVT_kwHOAAIrCs4BAngu"  # Template #67
TEMPLATE_OWNER="FrancisVarga"

# Get project prefix from arguments
PREFIX="$1"

if [ -z "$PREFIX" ]; then
    echo -e "${RED}Error: Project prefix is required${NC}"
    echo "Usage: $0 [PROJECT_PREFIX]"
    echo "Example: $0 'Sprint 2024-Q1'"
    exit 1
fi

echo -e "${BLUE}=================================================${NC}"
echo -e "${BLUE}🚀 GitHub Projects Creation Workflow${NC}"
echo -e "${BLUE}   Prefix: $PREFIX${NC}"
echo -e "${BLUE}=================================================${NC}"
echo

# Function to check command success
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $1${NC}"
    else
        echo -e "${RED}❌ $1 failed${NC}"
        exit 1
    fi
}

# Step 1: Validate Environment
echo -e "${YELLOW}🔍 Step 1: Validating environment...${NC}"

# Check GitHub CLI authentication
gh auth status > /dev/null 2>&1
check_status "GitHub CLI authenticated"

# Get user information
OWNER=$(gh api user --jq '.login')
OWNER_ID=$(gh api user --jq '.node_id')
echo -e "   User: ${GREEN}$OWNER${NC}"

# Get repository information
if git remote get-url origin > /dev/null 2>&1; then
    REPO=$(git remote get-url origin | sed 's/.*github.com[:\/]\(.*\)\.git/\1/')
    echo -e "   Repository: ${GREEN}$REPO${NC}"
else
    echo -e "${YELLOW}⚠️  Not in a git repository - projects won't be linked${NC}"
    REPO=""
fi

echo

# Step 2: Verify Templates
echo -e "${YELLOW}🔍 Step 2: Verifying template projects...${NC}"

# Check if templates exist
gh project view 66 --owner $TEMPLATE_OWNER > /dev/null 2>&1
check_status "Kanban template (#66) accessible"

gh project view 67 --owner $TEMPLATE_OWNER > /dev/null 2>&1
check_status "BugTracker template (#67) accessible"

echo

# Function to copy project
copy_project() {
    local TEMPLATE_ID=$1
    local TITLE=$2
    local PROJECT_TYPE=$3
    
    echo -e "${YELLOW}📋 Creating $TITLE...${NC}"
    
    RESULT=$(gh api graphql -f query='
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
    -f project="$TEMPLATE_ID" \
    -f owner="$OWNER_ID" \
    -f title="$TITLE" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        PROJECT_ID=$(echo "$RESULT" | grep -o '"id":"[^"]*"' | head -1 | cut -d'"' -f4)
        PROJECT_NUMBER=$(echo "$RESULT" | grep -o '"number":[0-9]*' | cut -d':' -f2)
        PROJECT_URL=$(echo "$RESULT" | grep -o '"url":"[^"]*"' | cut -d'"' -f4)
        
        echo -e "   ${GREEN}✅ Created: #$PROJECT_NUMBER${NC}"
        echo -e "   📍 URL: $PROJECT_URL"
        
        # Link to repository if available
        if [ -n "$REPO" ]; then
            gh project link "$PROJECT_NUMBER" --owner "$OWNER" --repo "$REPO" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "   ${GREEN}✅ Linked to repository${NC}"
            fi
        fi
        
        # Make project public
        gh api graphql -f query="mutation { updateProjectV2(input: { projectId: \"$PROJECT_ID\", public: true }) { projectV2 { id } } }" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "   ${GREEN}✅ Made public${NC}"
        fi
        
        # Store for summary
        if [ "$PROJECT_TYPE" = "KANBAN" ]; then
            KANBAN_NUMBER=$PROJECT_NUMBER
            KANBAN_URL=$PROJECT_URL
        else
            BUGTRACKER_NUMBER=$PROJECT_NUMBER
            BUGTRACKER_URL=$PROJECT_URL
        fi
        
        return 0
    else
        echo -e "   ${RED}❌ Failed to create project${NC}"
        return 1
    fi
}

# Step 3: Create Kanban Project
echo -e "${YELLOW}📋 Step 3: Creating Kanban project...${NC}"
copy_project "$KANBAN_TEMPLATE_ID" "$PREFIX - Kanban" "KANBAN"
echo

# Step 4: Create BugTracker Project
echo -e "${YELLOW}📋 Step 4: Creating BugTracker project...${NC}"
copy_project "$BUGTRACKER_TEMPLATE_ID" "$PREFIX - BugTracker" "BUGTRACKER"
echo

# Step 5: Summary
echo -e "${BLUE}=================================================${NC}"
echo -e "${GREEN}✨ Successfully created both projects!${NC}"
echo -e "${BLUE}=================================================${NC}"
echo
echo -e "${BLUE}📊 Project Summary:${NC}"
echo
echo -e "  ${GREEN}$PREFIX - Kanban${NC}"
echo -e "  Project #$KANBAN_NUMBER"
echo -e "  $KANBAN_URL"
echo
echo -e "  ${GREEN}$PREFIX - BugTracker${NC}"
echo -e "  Project #$BUGTRACKER_NUMBER"
echo -e "  $BUGTRACKER_URL"
echo
echo -e "${BLUE}💡 Next Steps:${NC}"
echo -e "  1. Add issues to projects:"
echo -e "     ${YELLOW}gh project item-add $KANBAN_NUMBER --owner $OWNER --issue [NUMBER]${NC}"
echo -e "  2. Configure automation rules in project settings"
echo -e "  3. Invite team members to collaborate"
echo

# Optional: Populate with issues if flag is provided
if [ "$2" = "--populate-issues" ] && [ -n "$REPO" ]; then
    echo -e "${YELLOW}📥 Populating projects with existing issues...${NC}"
    
    # Get open issues
    ISSUES=$(gh issue list --repo "$REPO" --state open --json number,labels --jq '.[] | @json')
    
    if [ -n "$ISSUES" ]; then
        while IFS= read -r issue_json; do
            ISSUE_NUMBER=$(echo "$issue_json" | jq -r '.number')
            LABELS=$(echo "$issue_json" | jq -r '.labels[].name' | tr '\n' ' ')
            
            # Add to BugTracker if it has bug label
            if echo "$LABELS" | grep -q "bug"; then
                gh project item-add "$BUGTRACKER_NUMBER" --owner "$OWNER" --issue "$ISSUE_NUMBER" 2>/dev/null
                echo -e "   Added issue #$ISSUE_NUMBER to BugTracker"
            # Otherwise add to Kanban
            else
                gh project item-add "$KANBAN_NUMBER" --owner "$OWNER" --issue "$ISSUE_NUMBER" 2>/dev/null
                echo -e "   Added issue #$ISSUE_NUMBER to Kanban"
            fi
        done <<< "$ISSUES"
    else
        echo -e "   No open issues found"
    fi
fi

echo -e "${GREEN}✅ Workflow completed successfully!${NC}"