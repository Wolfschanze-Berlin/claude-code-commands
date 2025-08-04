# Agent Creator

Create a new specialized Claude agent based on minimal user input: $ARGUMENTS

This tool intelligently expands minimal input into comprehensive agent specifications, automatically assigns appropriate Claude models, suggests related agents, and validates ecosystem integration.

## Core Workflow

1. **Input Analysis & Expansion** - Apply prompt optimization techniques to understand intent and expand capabilities
2. **Domain Classification** - Categorize into one of 8 domain categories with cross-domain support
3. **Complexity Analysis** - Score task complexity across 5 dimensions for model assignment
4. **Model Assignment** - Automatically assign haiku/sonnet/opus based on complexity and criticality
5. **Template Generation** - Create complete agent file following established patterns
6. **Related Agent Suggestions** - Identify workflow partners and integration points
7. **Validation** - Ensure quality, uniqueness, and ecosystem compatibility

## Input Optimization Strategy

Using chain-of-thought reasoning and few-shot examples to expand minimal input:

**STEP 1: Intent Analysis**
- What domain does this request fall into?
- What specific tasks would this agent handle?
- What level of expertise is required?
- Are there cross-domain requirements?

**STEP 2: Capability Expansion**
- What are the core focus areas for this domain?
- What methodological approach would work best?
- What outputs would be most valuable?
- How does this integrate with existing agents?

**STEP 3: Complexity Assessment**
- Decision-making complexity (1-10)
- Technical depth required (1-10)
- Risk/criticality level (1-10)
- Reasoning steps needed (1-10)
- Domain expertise depth (1-10)

## Domain Classification System

### Development & Architecture (6 existing agents)
**Characteristics**: System design, API architecture, UI/UX, microservices
**Model Distribution**: Primarily Sonnet
**Complexity Range**: Medium-High (4-7)
**Related Patterns**: backend-architect, frontend-developer, ui-ux-designer

### Language Specialists (13 existing agents)
**Characteristics**: Programming language expertise, idioms, frameworks
**Model Distribution**: Sonnet dominant
**Complexity Range**: Medium (4-6)
**Related Patterns**: python-pro, javascript-pro, rust-pro, etc.

### Infrastructure & Operations (8 existing agents)
**Characteristics**: DevOps, cloud architecture, database management, deployment
**Model Distribution**: Mixed Sonnet/Opus
**Complexity Range**: Medium-High (5-8)
**Related Patterns**: devops-troubleshooter, cloud-architect, database-admin

### Quality & Security (6 existing agents)
**Characteristics**: Code review, security auditing, testing, performance
**Model Distribution**: Opus for critical security tasks
**Complexity Range**: High (6-9)
**Related Patterns**: security-auditor, code-reviewer, performance-engineer

### Data & AI (6 existing agents)
**Characteristics**: ML engineering, data science, AI systems, prompt optimization
**Model Distribution**: Opus dominant
**Complexity Range**: High (7-10)
**Related Patterns**: ai-engineer, ml-engineer, data-scientist

### Specialized Domains (7 existing agents)
**Characteristics**: Finance, payments, legacy systems, context management
**Model Distribution**: Mixed based on risk level
**Complexity Range**: Variable (3-9)
**Related Patterns**: quant-analyst, payment-integration, legacy-modernizer

### Documentation (3 existing agents)
**Characteristics**: Technical writing, API docs, tutorials, references
**Model Distribution**: Haiku efficient
**Complexity Range**: Low (2-4)
**Related Patterns**: api-documenter, docs-architect, tutorial-engineer

### Business & Marketing (5 existing agents)
**Characteristics**: Analytics, content creation, sales, customer support
**Model Distribution**: Haiku cost-effective
**Complexity Range**: Low (1-4)
**Related Patterns**: business-analyst, content-marketer, customer-support

## Model Assignment Algorithm

### Complexity Scoring Framework

**Decision-Making Complexity (1-10)**
- 1-3: Template-based, structured decisions
- 4-6: Domain expertise with moderate judgment
- 7-10: High-stakes, multi-factor decision making

**Technical Depth Required (1-10)**
- 1-3: Basic technical knowledge
- 4-6: Specialized domain expertise
- 7-10: Advanced, cutting-edge technical mastery

**Risk/Criticality Level (1-10)**
- 1-3: Low impact, easily reversible
- 4-6: Moderate business impact
- 7-10: Production-critical, high financial/security risk

**Reasoning Steps Needed (1-10)**
- 1-3: Simple, linear workflows
- 4-6: Multi-step problem solving
- 7-10: Complex, iterative reasoning chains

**Domain Expertise Depth (1-10)**
- 1-3: General knowledge sufficient
- 4-6: Specialized training required
- 7-10: Expert-level, years of experience needed

### Model Assignment Rules

**Total Complexity Score = (Decision + Technical + Risk + Reasoning + Expertise) / 5**

**Haiku Assignment (Score 1-3)**
- Documentation generation and formatting
- Template-based content creation
- Simple data analysis and reporting
- Information gathering and research
- Structured output generation

**Sonnet Assignment (Score 4-6)**
- Standard development and programming tasks
- Code review and testing workflows
- Infrastructure management and deployment
- Domain-specific problem solving
- Multi-step technical implementations

**Opus Assignment (Score 7-10)**
- Security vulnerability analysis
- AI/ML system design and optimization
- Architecture and system design decisions
- Production incident response
- Financial modeling and risk analysis

### Override Rules

**Force Opus Assignment:**
- Any security-related tasks (security override)
- Production incident response (criticality override)
- AI/ML system design (complexity override)
- Financial risk analysis (stakes override)
- Architecture decisions affecting multiple systems

**Force Haiku Assignment:**
- Pure documentation tasks without technical complexity
- Template-based content generation
- Simple information retrieval and formatting
- Basic data analysis with standard queries

## Agent Template Generation

### Dynamic Template Structure

```yaml
---
name: [generated-kebab-case-name]
description: [expanded-description-with-proactive-usage-triggers]
model: [complexity-based-assignment]
---

You are a [domain-expertise] specializing in [specific-focus-areas].

## Focus Areas
- [Core capability 1 with specific technologies/methods]
- [Core capability 2 with practical applications]
- [Core capability 3 with integration aspects]
- [Core capability 4 with quality/security considerations]
- [Additional capabilities based on domain complexity]

## Approach
1. [Initial assessment/analysis step]
2. [Planning/design step]
3. [Implementation/execution step]
4. [Validation/testing step]
5. [Documentation/handoff step - if complex]

## Output
- [Primary deliverable with format specification]
- [Secondary deliverable with examples]
- [Quality assurance outputs]
- [Integration/handoff materials]

[Domain-specific sections as needed]
```

### Domain-Specific Template Variations

**Development & Architecture Agents:**
```markdown
## Technology Stack
- [Relevant frameworks and tools]
- [Integration patterns and APIs]

## Best Practices
- [Architecture principles and patterns]
- [Code quality and maintainability standards]
```

**Quality & Security Agents:**
```markdown
## Review Criteria
- [Specific checklist items and standards]
- [Risk assessment factors and thresholds]

## Output Format
### 🚨 CRITICAL (Must fix before deployment)
### ⚠️ HIGH PRIORITY (Should fix)
### 💡 SUGGESTIONS (Consider improving)
```

**Data & AI Agents:**
```markdown
## Model Considerations
- [Performance optimization strategies]
- [Cost management and token efficiency]

## Evaluation Metrics
- [Quality measurements and benchmarks]
- [Success criteria and validation methods]
```

## Related Agent Suggestion System

### Domain Relationship Matrix

**Primary Relationships (Direct Workflow Partners):**
- Development & Architecture ↔ Quality & Security
- Language Specialists ↔ Quality & Security
- Infrastructure & Operations ↔ Quality & Security
- Data & AI ↔ Infrastructure & Operations

**Cross-Domain Collaboration Patterns:**

**Feature Development Workflow:**
backend-architect → frontend-developer → test-automator → security-auditor

**API Implementation Workflow:**
backend-architect → [language-pro] → api-documenter → code-reviewer

**ML Pipeline Workflow:**
data-scientist → ai-engineer → mlops-engineer → cloud-architect

**Production Deployment Workflow:**
deployment-engineer → devops-troubleshooter → incident-responder

### Suggestion Algorithm

**STEP 1: Primary Domain Mapping**
- Identify new agent's primary domain category
- Find all agents in same domain with capability overlap scoring
- Rank by collaboration potential (0-100%)

**STEP 2: Workflow Pattern Analysis**
- Identify common workflow sequences involving this domain
- Map upstream dependencies (what feeds into this agent)
- Map downstream dependencies (what this agent feeds into)

**STEP 3: Complementary Skills Detection**
- Analyze capability gaps this agent might have
- Find agents that fill those gaps
- Consider cross-functional requirements

**STEP 4: Collaboration Scoring**
For each potential related agent:
- Direct collaboration score (0-10)
- Workflow frequency score (0-10)
- Complementary skills score (0-10)
- Domain expertise overlap (0-10)

**Total Relationship Score = (Direct + Frequency + Complementary + Overlap) / 4**

## Validation Engine

### Structural Validation Rules

**Frontmatter Validation:**
✓ Valid YAML syntax with proper delimiters
✓ Required fields: name, description, model
✓ Name follows kebab-case convention
✓ Description includes proactive usage triggers
✓ Model is one of: haiku, sonnet, opus
✓ No duplicate names with existing 55 agents

**Content Structure Validation:**
✓ Role definition follows pattern: "You are a [expertise] specializing in..."
✓ Focus Areas section with 4-6 specific bullet points
✓ Approach section with 3-5 numbered methodology steps
✓ Output section with concrete deliverable specifications
✓ Proper markdown formatting throughout

### Content Quality Validation

**Description Quality Checks:**
✓ Includes proactive usage triggers ("Use when...", "Use PROACTIVELY for...")
✓ Mentions specific technologies, methodologies, or frameworks
✓ Clear differentiation from existing agent capabilities
✓ Actionable and specific (not generic or abstract)

**Focus Areas Validation:**
✓ Each bullet point is specific and actionable
✓ Covers different aspects of the domain expertise
✓ Includes relevant technologies and frameworks
✓ No significant overlap with existing agent capabilities
✓ Progressive complexity from basic to advanced topics

**Approach Methodology Validation:**
✓ Logical workflow progression with clear steps
✓ Actionable steps (not abstract concepts)
✓ Domain-appropriate methodology and best practices
✓ Realistic and implementable in practice
✓ Clear success criteria and validation points

### Duplication Detection Algorithm

**Capability Overlap Analysis:**
1. Extract key capabilities from Focus Areas section
2. Compare against all 55 existing agent capabilities
3. Calculate similarity score using semantic matching (0-100%)
4. Flag if >70% overlap with any existing agent

**Domain Saturation Check:**
1. Count existing agents in target domain category
2. Identify capability gaps within domain
3. Ensure new agent fills genuine ecosystem gap
4. Validate unique value proposition

**Name Similarity Check:**
1. Check exact name matches against existing agents
2. Identify semantically similar names using fuzzy matching
3. Validate naming consistency with domain conventions
4. Ensure clear differentiation and avoid confusion

## Implementation Process

When processing user input, follow this systematic approach:

### Phase 1: Input Analysis
```
ANALYZE: "$ARGUMENTS"

Domain Intent: [Identify primary domain from user input]
Specific Focus: [Extract key technologies, methodologies, use cases]
Complexity Indicators: [Identify factors suggesting complexity level]
Cross-Domain Elements: [Note any multi-domain requirements]
```

### Phase 2: Expansion and Classification
```
EXPAND INPUT using chain-of-thought reasoning:

1. What specific domain expertise is needed?
2. What are the core capabilities and focus areas?
3. What methodology would be most effective?
4. What outputs would provide the most value?
5. How does this integrate with existing agents?

CLASSIFY into domain category with confidence score.
```

### Phase 3: Complexity Assessment and Model Assignment
```
SCORE COMPLEXITY across 5 dimensions:
- Decision-making complexity: [1-10 with rationale]
- Technical depth required: [1-10 with rationale]
- Risk/criticality level: [1-10 with rationale]
- Reasoning steps needed: [1-10 with rationale]
- Domain expertise depth: [1-10 with rationale]

TOTAL SCORE: [Average] → MODEL ASSIGNMENT: [haiku/sonnet/opus]

CHECK OVERRIDE RULES:
- Security tasks → Force Opus
- Production critical → Force Opus
- Simple documentation → Force Haiku
```

### Phase 4: Template Generation
```
GENERATE AGENT using domain-specific template:

1. Create unique kebab-case name
2. Expand description with proactive triggers
3. Populate focus areas with specific capabilities
4. Design methodology approach for domain
5. Specify concrete output deliverables
6. Add domain-specific sections if needed
```

### Phase 5: Related Agent Analysis
```
IDENTIFY RELATED AGENTS:

Direct Partners: [Same workflow step agents]
Upstream Dependencies: [Agents that provide input]
Downstream Consumers: [Agents that use output]
Complementary Specialists: [Agents that fill gaps]

GENERATE WORKFLOW EXAMPLES:
- [Scenario 1 with 3-4 agent collaboration]
- [Scenario 2 with alternative workflow]
- [Scenario 3 with complex multi-domain case]
```

### Phase 6: Validation and Output
```
VALIDATE GENERATED AGENT:

Structural Checks: [YAML, formatting, required sections]
Content Quality: [Specificity, actionability, uniqueness]
Duplication Detection: [Overlap analysis with existing agents]
Integration Compatibility: [Workflow fit assessment]

OUTPUT RESULTS:
- Generated agent file
- Model assignment rationale
- Related agent suggestions
- Workflow examples
- Validation results
```

## Output Format

When generating a new agent, provide this comprehensive output:

```markdown
## Generated Agent

[Complete agent markdown file with proper YAML frontmatter and all sections]

## Model Assignment Rationale

**Assigned Model**: [haiku/sonnet/opus]
**Complexity Score**: [X.X/10]
**Scoring Breakdown**:
- Decision-making complexity: [X/10] - [rationale]
- Technical depth required: [X/10] - [rationale]
- Risk/criticality level: [X/10] - [rationale]
- Reasoning steps needed: [X/10] - [rationale]
- Domain expertise depth: [X/10] - [rationale]

**Override Rules Applied**: [If any security, production, or simplicity overrides]

## Related Agent Suggestions

### 🤝 DIRECT WORKFLOW PARTNERS
- **[agent-name]** - [specific collaboration scenario and handoff points]
- **[agent-name]** - [how they work together in same workflow step]

### ⬆️ UPSTREAM DEPENDENCIES
- **[agent-name]** - [what input/preparation they provide]
- **[agent-name]** - [prerequisite work they handle]

### ⬇️ DOWNSTREAM CONSUMERS
- **[agent-name]** - [how they use this agent's output]
- **[agent-name]** - [next steps they handle in workflow]

### 🔧 COMPLEMENTARY SPECIALISTS
- **[agent-name]** - [what capability gaps they fill]
- **[agent-name]** - [additional expertise they provide]

## Example Workflows

**Scenario 1: [Primary Use Case]**
1. [New Agent] - [specific responsibility and deliverables]
2. [Related Agent 1] - [complementary task and handoff]
3. [Related Agent 2] - [next step in workflow]
4. [Related Agent 3] - [final validation or deployment]

**Scenario 2: [Alternative Workflow]**
[Different collaboration pattern showing flexibility]

**Scenario 3: [Complex Multi-Domain Case]**
[Advanced scenario showing cross-domain expertise integration]

## Validation Results

### ✅ PASSED CHECKS
- [List of successful validation criteria met]
- [Quality metrics achieved]
- [Integration compatibility confirmed]

### ⚠️ WARNINGS
- [Potential areas for improvement]
- [Minor issues that should be addressed]

### 💡 SUGGESTIONS
- [Enhancement opportunities]
- [Additional capabilities that could be considered]
- [Optimization recommendations]

### 📊 AGENT ANALYSIS
- **Domain Classification**: [Primary domain with confidence score]
- **Uniqueness Score**: [Percentage unique vs existing agents]
- **Integration Points**: [Number of related agents identified]
- **Ecosystem Fit**: [How well it fills identified gaps]
```

## Usage Examples

### Example 1: Simple Input → Complex Agent
**Input**: "blockchain smart contract auditor"

**Expected Output**: Complete agent with Opus assignment, security focus, integration with legal-advisor and security-auditor, comprehensive audit methodology.

### Example 2: Development Tool
**Input**: "React component generator for design systems"

**Expected Output**: Sonnet-assigned agent with frontend-developer integration, design system patterns, accessibility focus.

### Example 3: Infrastructure Specialist
**Input**: "Kubernetes troubleshooting expert"

**Expected Output**: Sonnet agent with devops-troubleshooter and incident-responder integration, systematic debugging approach.

## Best Practices

### Effective Input Patterns
✓ "mobile app performance testing with battery optimization"
✓ "GraphQL schema security validation for enterprise APIs"
✓ "ML model drift detection for production pipelines"

### Less Effective Inputs
✗ "code helper" (too generic)
✗ "good at programming" (not specific)
✗ "AI assistant" (overlaps with existing capabilities)

### When to Create New Agents vs. Use Existing
**Create New Agent When**:
✓ Significant capability gap in existing ecosystem
✓ Highly specialized domain expertise needed
✓ Unique workflow or methodology required
✓ Cross-domain expertise combination not covered

**Use Existing Agents When**:
✓ >70% overlap with current agent capabilities
✓ Minor variation of existing specialization
✓ Can be handled by multi-agent workflow
✓ Temporary or project-specific need

This tool intelligently expands minimal user input into comprehensive, validated agent specifications that integrate seamlessly with the existing 55-agent Claude Code ecosystem.