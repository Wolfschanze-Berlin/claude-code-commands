---
command: "/gutenberg-convert"
category: "Documentation & Content"
purpose: "Convert files to Gutenberg documentation site with proper structure"
wave-enabled: true
performance-profile: "standard"
---

# /gutenberg-convert - File to Documentation Converter

## Purpose
Transform any file specified by $ARGUMENT into properly formatted documentation within the Gutenberg Docusaurus site, including content analysis, format conversion, and navigation integration.

## Usage
```
/gutenberg-convert $ARGUMENT [--type docs|blog|guide] [--category existing|new] [--format preserve|optimize]
```

## Arguments
- `$ARGUMENT` - Path to the file to convert (required)
- `--type` - Target document type (docs, blog, guide)
- `--category` - Integration approach (existing category or new)
- `--format` - Content formatting strategy (preserve original or optimize for web)
- `--sidebar` - Update sidebar navigation automatically
- `--dry-run` - Preview conversion without making changes

## Auto-Activations
- **Persona**: scribe (documentation specialist)
- **MCP Servers**: Context7 (documentation patterns), Sequential (structured analysis)
- **Flags**: --think (file analysis), --validate (structure validation)

## Implementation

### Phase 1: File Analysis & Classification
Use Sequential thinking for systematic file analysis and routing decisions.

**1. Content Analysis**
```typescript
// Analyze input file to determine content type and structure
const analyzeFileContent = async (filePath: string) => {
  // Read file content and metadata
  // Determine content type (markdown, code, text, JSON, etc.)
  // Extract structure, headings, sections
  // Identify documentation category and purpose
  // Assess conversion requirements
};
```

**2. Target Location Determination**
Based on content analysis, determine optimal placement:
- **API Documentation** → `docs/api-reference/`
- **Configuration Guides** → `docs/configuration/`
- **Examples & Tutorials** → `docs/examples/` or `docs/tutorial-basics/`
- **Database Documentation** → `docs/database/`
- **Workflow Documentation** → `docs/workflows/`
- **Project Management** → `docs/project-management/`
- **Security Content** → `docs/security/`
- **Blog Posts** → `blog/`

**3. Format Assessment**
Evaluate current format and required transformations:
- **Markdown** → Direct conversion with frontmatter enhancement
- **Code Files** → Extract documentation, create code examples
- **JSON/YAML** → Configuration documentation with examples
- **Text Files** → Markdown conversion with proper structure
- **README** → Integration guide or overview documentation

### Phase 2: Content Transformation

**1. Docusaurus Formatting**
Transform content for optimal Docusaurus presentation:

```markdown
---
sidebar_position: [calculated]
title: "[extracted or generated]"
description: "[extracted or generated]"
tags: [auto-generated based on content]
---

# [Optimized Title]

[Enhanced introduction with context]

## [Structured content sections]

[Original content with Docusaurus enhancements]
```

**2. Content Enhancement**
Apply Docusaurus-specific improvements:
- **Code Blocks**: Language-specific syntax highlighting
- **Admonitions**: Convert notes/warnings to Docusaurus admonitions
- **Internal Links**: Convert to Docusaurus-compatible paths
- **Images**: Optimize and place in static/ directory
- **Tables**: Enhance with responsive formatting
- **Interactive Elements**: Add code sandboxes where appropriate

**3. Navigation Integration**
Update navigation structure based on content:
- **Category Detection**: Identify existing or create new categories
- **Position Calculation**: Logical positioning within category
- **Sidebar Updates**: Automatic sidebars.ts configuration
- **Cross-References**: Link to related documentation

### Phase 3: Structure Integration

**1. Directory Organization**
Ensure proper folder structure following established patterns:

```
gutenberg/docs/
├── [category]/
│   ├── _category_.json          # Category configuration
│   ├── [converted-file].md      # Main content
│   ├── assets/                  # Supporting files
│   └── examples/                # Code examples
```

**2. Category Management**
Handle category creation and updates:
- **Existing Categories**: Integrate into established structure
- **New Categories**: Create with proper _category_.json
- **Category Ordering**: Maintain logical navigation flow
- **Description Generation**: Context-aware category descriptions

**3. Asset Management**
Process and organize supporting files:
- **Images**: Place in appropriate static/ subdirectory
- **Code Examples**: Extract and format for documentation
- **Configuration Files**: Create downloadable examples
- **Schemas**: Generate validation documentation

### Phase 4: Quality Assurance & Validation

**1. Content Validation**
Ensure documentation quality:
- **Link Checking**: Verify all internal and external links
- **Markdown Validation**: Proper syntax and formatting
- **Code Example Testing**: Validate code snippets
- **Accessibility**: Proper heading hierarchy and alt text
- **SEO Optimization**: Meta descriptions and titles

**2. Integration Testing**
Verify Docusaurus compatibility:
- **Build Testing**: Ensure site builds without errors
- **Navigation Verification**: Confirm sidebar integration
- **Mobile Responsiveness**: Test on various screen sizes
- **Search Integration**: Verify content is searchable

**3. Cross-Reference Updating**
Maintain documentation coherence:
- **Related Links**: Add see-also sections
- **Category Consistency**: Ensure consistent categorization
- **Version Compatibility**: Update version-specific content
- **Deprecation Handling**: Mark outdated content appropriately

## Tool Orchestration

### Primary Tools
- **Read**: File content analysis and structure extraction
- **Write**: Create new documentation files
- **Edit**: Update existing files and navigation
- **MultiEdit**: Batch updates for navigation and cross-references
- **Glob**: Find related files and assets
- **Grep**: Search for patterns and references

### MCP Integration
- **Context7**: Documentation patterns and best practices
- **Sequential**: Structured analysis and decision-making process

### Validation Pipeline
```yaml
validation_steps:
  1. content_structure: "Verify content hierarchy and organization"
  2. docusaurus_compatibility: "Test build compatibility and rendering"
  3. navigation_integration: "Confirm sidebar and menu integration"
  4. cross_references: "Validate internal and external links"
  5. accessibility_check: "Ensure WCAG compliance and usability"
  6. mobile_optimization: "Test responsive design and performance"
```

## Execution Flow

### Step 1: Analysis Phase
```bash
# File analysis and classification
1. Read source file → extract content structure
2. Analyze content type → determine target category
3. Assess format requirements → plan conversion strategy
4. Check existing documentation → identify integration points
```

### Step 2: Conversion Phase
```bash
# Content transformation and enhancement
1. Convert format → optimize for Docusaurus
2. Generate frontmatter → add metadata and configuration
3. Enhance content → add Docusaurus features
4. Process assets → optimize and organize supporting files
```

### Step 3: Integration Phase
```bash
# Documentation site integration
1. Create directory structure → ensure proper organization
2. Update navigation → modify sidebars.ts configuration
3. Add cross-references → link related documentation
4. Test integration → verify site builds and navigation
```

### Step 4: Validation Phase
```bash
# Quality assurance and final checks
1. Validate content → check formatting and links
2. Test accessibility → ensure usability standards
3. Verify mobile optimization → responsive design testing
4. Document changes → update change log and references
```

## Example Workflows

### Converting API Documentation
```bash
# Convert OpenAPI specification to documentation
/gutenberg-convert ./openapi.yaml --type docs --category api-reference

# Expected output:
# - docs/api-reference/endpoints.md
# - docs/api-reference/schemas.md
# - Updated sidebars.ts with new entries
```

### Converting Code Examples
```bash
# Convert example file to tutorial
/gutenberg-convert ./examples/advanced-usage.ts --type docs --category examples

# Expected output:
# - docs/examples/advanced-patterns.md
# - Code blocks with syntax highlighting
# - Interactive examples where applicable
```

### Converting Configuration Files
```bash
# Convert configuration to documentation
/gutenberg-convert ./config/database.json --type docs --category configuration

# Expected output:
# - docs/configuration/database-setup.md
# - Configuration examples and validation
# - Environment variable documentation
```

## Output Validation

### Success Criteria
- ✅ File successfully converted to Docusaurus-compatible format
- ✅ Content properly categorized and positioned
- ✅ Navigation updated and functional
- ✅ All links verified and working
- ✅ Site builds without errors
- ✅ Mobile-responsive presentation
- ✅ Accessibility standards met

### Quality Gates
1. **Content Quality**: Clear structure, proper formatting
2. **Technical Accuracy**: Valid code examples and configurations
3. **User Experience**: Intuitive navigation and organization
4. **Performance**: Fast loading and optimal rendering
5. **Maintainability**: Easy to update and extend

## Error Handling

### Common Issues & Resolutions
- **Unsupported File Format** → Provide conversion guidance
- **Broken Links** → Fix or document link issues
- **Build Failures** → Identify and resolve compatibility issues
- **Navigation Conflicts** → Resolve sidebar ordering issues
- **Asset Optimization** → Compress and optimize media files

### Rollback Strategy
- Preserve original file structure
- Create backup of existing documentation
- Provide restoration commands if needed
- Document all changes for easy reversal

## Integration with SuperClaude Framework

This workflow integrates with the broader SuperClaude ecosystem:
- **Wave Compatibility**: Supports multi-stage complex conversions
- **Sub-Agent Delegation**: Can delegate analysis to specialized agents
- **Quality Gates**: Implements 8-step validation framework
- **MCP Orchestration**: Leverages Context7 and Sequential servers
- **Persona Integration**: Activates scribe persona for optimal documentation

## Performance Metrics

- **Conversion Speed**: < 30 seconds for typical files
- **Quality Score**: > 90% documentation quality metrics
- **Build Success**: 100% successful Docusaurus builds
- **User Satisfaction**: Improved navigation and findability