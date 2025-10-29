# Claude Code PDCA Workflow Setup Guide

This guide explains how to configure Claude Code to follow the PDCA (Plan-Do-Check-Act) development workflow with TDD discipline.

## Overview

The PDCA workflow consists of four phases:
1. **Plan** - Analysis and detailed planning
2. **Do** - Test-driven implementation
3. **Check** - Completeness verification
4. **Act** - Retrospection and continuous improvement

## Prerequisites

### Windows
- Windows 10/11 with Developer Mode enabled (for symlinks without admin rights)
- Claude Code CLI installed
- Git configured with `core.symlinks = true`

### macOS/Linux
- Claude Code CLI installed
- Git configured with `core.symlinks = true`
- Standard symlink support (built-in)

## Important: Symlink Strategy

This guide uses **symlinks** to keep your PDCA prompt templates synchronized across multiple projects. You maintain one master copy of each phase template, and each project links to these templates.

**Benefits:**
- Update prompts once, changes apply to all projects
- Consistent process across your development work
- Easy experimentation and refinement

**Alternative:** If you prefer not to use symlinks, simply copy the prompt template files directly into each project's `.claude/prompts/` directory. You'll need to manually sync changes across projects.

## Project Structure

After setup, your project should have:

```
your-project/
├── .claude/
│   ├── instructions.md          # Main workflow instructions
│   ├── prompts/                 # Symlinked phase templates
│   │   ├── 1a-analyze.md
│   │   ├── 1b-plan.md
│   │   ├── 2-implement.md
│   │   ├── 3-check.md
│   │   └── 4-retrospect.md
│   └── validation.md            # Pre-commit checklist (optional)
└── .claudeignore                # Files for Claude to ignore
```

## Setup Steps

### 1. Enable Symlink Support

#### Windows
To create symlinks without admin rights:
1. Open Settings → Update & Security → For Developers
2. Turn on **Developer Mode**
3. Restart PowerShell/Terminal

#### macOS/Linux
No special setup required - symlink support is built-in.

### 2. Configure Git for Symlinks

**All Platforms:**
```bash
git config core.symlinks true
```

### 3. Create Directory Structure

#### Windows (PowerShell)
```powershell
# Create .claude directory structure
New-Item -ItemType Directory -Path ".claude\prompts" -Force
```

#### macOS/Linux (Bash)
```bash
# Create .claude directory structure
mkdir -p .claude/prompts
```

### 4. Create Symlinks to Prompt Templates

First, decide where to store your master PDCA prompt templates. Recommended locations:
- **Windows**: `C:\Dev\pdca-templates\` or `%USERPROFILE%\Documents\pdca-templates\`
- **macOS**: `~/Documents/pdca-templates/` or `~/dev/pdca-templates/`
- **Linux**: `~/documents/pdca-templates/` or `~/dev/pdca-templates/`

Create your master template directory and the phase subdirectories:

#### Windows (PowerShell)
```powershell
# Create master template directory structure
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\pdca-templates\plan" -Force
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\pdca-templates\do" -Force
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\pdca-templates\check" -Force
New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents\pdca-templates\act" -Force
```

#### macOS/Linux (Bash)
```bash
# Create master template directory structure
mkdir -p ~/Documents/pdca-templates/{plan,do,check,act}
```

Now create symlinks from your project to the master templates:

#### Windows (PowerShell)
```powershell
# From your project root
# Adjust the target path to where you stored your master templates
$templatesBase = "$env:USERPROFILE\Documents\pdca-templates"

New-Item -ItemType SymbolicLink `
  -Path ".claude\prompts\1a-analyze.md" `
  -Target "$templatesBase\plan\1a-analyze.md"

New-Item -ItemType SymbolicLink `
  -Path ".claude\prompts\1b-plan.md" `
  -Target "$templatesBase\plan\1b-plan.md"

New-Item -ItemType SymbolicLink `
  -Path ".claude\prompts\2-implement.md" `
  -Target "$templatesBase\do\2-implement.md"

New-Item -ItemType SymbolicLink `
  -Path ".claude\prompts\3-check.md" `
  -Target "$templatesBase\check\3-check.md"

New-Item -ItemType SymbolicLink `
  -Path ".claude\prompts\4-retrospect.md" `
  -Target "$templatesBase\act\4-retrospect.md"
```

#### macOS/Linux (Bash)
```bash
# From your project root
# Adjust the target path to where you stored your master templates
TEMPLATES_BASE="$HOME/Documents/pdca-templates"

ln -s "$TEMPLATES_BASE/plan/1a-analyze.md" ".claude/prompts/1a-analyze.md"
ln -s "$TEMPLATES_BASE/plan/1b-plan.md" ".claude/prompts/1b-plan.md"
ln -s "$TEMPLATES_BASE/do/2-implement.md" ".claude/prompts/2-implement.md"
ln -s "$TEMPLATES_BASE/check/3-check.md" ".claude/prompts/3-check.md"
ln -s "$TEMPLATES_BASE/act/4-retrospect.md" ".claude/prompts/4-retrospect.md"
```

**Note:** You'll need to create the actual prompt template files in your master directory. See the "Prompt Templates" section below for the content of each file.

### 5. Create `.claudeignore`

Create `.claudeignore` in your project root to exclude files Claude doesn't need to see. Adapt this example to your project's needs:

```gitignore
# Build outputs
**/bin
**/obj

# IDE and editor files
**/.vs
**/.idea
**/.vscode
**/*.user
**/*.suo

# OS files
**/.DS_Store
**/Thumbs.db

# Test outputs
**/test-output
**/TestResults

# Logs
*.log

# Dependencies
**/node_modules
**/packages

# Git
.git/

# Environment files
.env
.env.local
```

### 6. Create `.claude/instructions.md`

Create the main instructions file that Claude Code will read automatically (see Configuration Files section below).

### 7. Create `.claude/validation.md` (Optional)

Create a validation checklist for pre-commit checks (see Configuration Files section below).

## Configuration Files

### `.claude/instructions.md`

This file provides Claude with high-level workflow guidance. Customize the testing conventions and checkpoints for your project:

```markdown
# Project Development Workflow

This project follows a strict PDCA (Plan-Do-Check-Act) development process with TDD discipline.

## Workflow Phases

### Phase 1a: Analysis (MANDATORY FIRST)
- Execute codebase_search to discover existing patterns
- Validate external system formats before making assumptions
- Document architectural constraints
- Assess delegation complexity

### Phase 1b: Planning
- Create numbered, atomic implementation steps
- Define testing strategy (TDD with red-green-refactor)
- Identify integration touch points
- Plan for incremental delivery

### Phase 2: Test-Driven Implementation
**CRITICAL RULES:**
- ❌ DON'T test interfaces - test concrete implementations
- ❌ DON'T use compilation errors as RED phase
- ✅ DO write failing behavioral tests FIRST
- ✅ DO use real components over mocks
- Max 3 iterations per red-green cycle

### Phase 3: Completeness Check
- Verify all objectives met
- Audit process discipline
- Confirm no TODOs remain

### Phase 4: Retrospection
- Analyze critical moments
- Extract actionable insights
- Update working agreements

## Testing Conventions
[Customize this section for your project's testing framework and patterns]
- Test framework: [e.g., NUnit, Jest, pytest]
- Test structure: [e.g., Arrange-Act-Assert]
- Test organization: [e.g., mirror source structure]

## Process Checkpoints
Before proceeding with implementation:
- [ ] Have I searched for similar implementations?
- [ ] Have I validated external system formats?
- [ ] Have I written a FAILING test first?
- [ ] Am I implementing ONLY enough to pass the test?

## Detailed Phase Instructions
See `.claude/prompts/` directory for detailed instructions for each phase.
```

### `.claude/validation.md` (Optional)

Create a validation checklist for pre-commit verification:

```markdown
## Pre-Commit Validation Checklist

Before each commit, verify:

- [ ] Test was written and failed FIRST (true RED phase)
- [ ] Implementation makes test pass with minimal code
- [ ] No compilation-only reds (compilation errors don't count as RED)
- [ ] Using real components where possible (avoid unnecessary mocks)
- [ ] Following existing codebase patterns discovered in analysis
- [ ] TDD discipline maintained throughout (max 3 red-green iterations)
- [ ] Code is clean and refactored
- [ ] No TODOs or placeholder implementations remain
```

## Prompt Templates

You'll need to create the actual prompt template files in your master template directory. The framework document provides detailed examples of each prompt. Here's the structure:

**Master Template Directory Structure:**
```
pdca-templates/
├── plan/
│   ├── 1a-analyze.md      # Problem analysis and approach selection
│   └── 1b-plan.md         # Detailed implementation planning
├── do/
│   └── 2-implement.md     # Test-driven implementation guidance
├── check/
│   └── 3-check.md         # Completeness verification
└── act/
    └── 4-retrospect.md    # Session retrospection
```

Refer to the main PDCA framework document for the full content of each prompt template. Each template should include:
- Clear objectives for that phase
- Structured prompts to guide Claude's behavior
- Checklists for validation
- Examples where helpful

## Usage Workflow

### Starting a New Feature

Always work through phases sequentially. Use **Planning Mode** for analysis and planning, then switch to **Edit Mode** for implementation.

---

#### Phase 1a: Analysis (Planning Mode)

**Mode:** Use Planning Mode  
**Purpose:** Understand problem scope and discover architectural patterns  
**Critical:** Do NOT proceed to planning (1b) until you explicitly trigger it in a separate prompt

**Short Prompt:**
```
Perform analysis per .claude/prompts/1a-analyze for: [brief feature description]

Do NOT create the implementation plan yet. STOP after analysis.
```

**Example:**
```
Perform analysis per .claude/prompts/1a-analyze for: Add CSV export feature for dependency graph

Do NOT create the implementation plan yet. STOP after analysis.
```

**What happens:**
- Claude searches codebase for similar patterns
- Validates external system formats if needed
- Assesses delegation complexity
- Provides alternative approaches
- **STOPS and waits for your review**

**Review the analysis before proceeding to Phase 1b.**

---

#### Phase 1b: Planning (Planning Mode)

**Mode:** Use Planning Mode  
**Purpose:** Create atomic, testable implementation steps  
**Prerequisites:** Approved analysis from Phase 1a

**Short Prompt:**
```
Create implementation plan per .claude/prompts/1b-plan based on approved analysis.
```

**What happens:**
- Claude creates numbered, atomic steps
- Defines TDD strategy for each step
- Identifies integration touch points
- Plans for incremental delivery
- Provides complete plan for review

**Review and approve the plan before proceeding to Phase 2.**

---

#### Phase 2: Implementation (Edit/Agent Mode)

**Mode:** Switch to Edit Mode or Agent Mode  
**Purpose:** Test-drive implementation step by step  
**Prerequisites:** Approved implementation plan from Phase 1b

**Short Prompt (for single step):**
```
Test-drive step [N] per .claude/prompts/2-implement: [specific step description]

RED phase: Write failing test first
GREEN phase: Minimal implementation to pass
```

**Example:**
```
Test-drive step 3 per .claude/prompts/2-implement: Add CsvExporter class with Write method

RED phase: Write failing test first
GREEN phase: Minimal implementation to pass
```

**Short Prompt (for batch of related steps):**
```
Test-drive steps [N-M] per .claude/prompts/2-implement using batched TDD:
- [Step N description]
- [Step M description]

RED phase: Write all failing tests first
GREEN phase: Implement to pass all tests
```

**Key points:**
- **Always** work in Edit/Agent mode for implementation
- One step (or small batch) at a time
- Always RED (failing test) before GREEN (implementation)
- Review after each step/batch before proceeding
- Maximum 3 red-green iterations per step

**If Claude strays from TDD discipline:**
1. Stop immediately
2. Point out the violation
3. Repost .claude/prompts/2-implement guidance
4. Resume with corrected approach

---

#### Phase 3: Completeness Check (Any Mode)

**Mode:** Any mode  
**Purpose:** Verify all objectives met and process followed

**Short Prompt:**
```
Run completeness check per .claude/prompts/3-check
```

**What happens:**
- Verifies all tests passing
- Audits TDD discipline maintenance
- Confirms no TODOs remain
- Checks documentation updates
- Provides completion status

---

#### Phase 4: Retrospection (Any Mode)

**Mode:** Any mode  
**Purpose:** Extract learnings and improve process  
**When:** At end of every session, regardless of outcome

**Short Prompt:**
```
Retrospect on this session per .claude/prompts/4-retrospect
```

**What happens:**
- Analyzes critical moments
- Identifies what worked/didn't work
- Provides 3 actionable insights
- Suggests next session improvements

---

### Quick Reference: Mode Selection

| Phase | Mode | Why |
|-------|------|-----|
| 1a - Analysis | Planning | High-level thinking, no code changes |
| 1b - Planning | Planning | Strategy and step definition, no code changes |
| 2 - Implementation | Edit/Agent | Writing and modifying code with TDD |
| 3 - Completeness | Any | Simple verification |
| 4 - Retrospection | Any | Reflection and learning |

## Best Practices

### 1. Explicit Phase References
Always mention `.claude/prompts/[phase-name].md` in your commands so Claude knows where to look.

### 2. One Phase at a Time
Don't ask Claude to "implement feature X end-to-end". Break it into discrete phases.

### 3. Stop and Review
Use explicit STOP instructions after analysis and planning phases for human review.

### 4. Context Preservation
Use the same Claude Code conversation/task thread to maintain context across phases.

### 5. TDD Discipline Enforcement
If Claude strays from TDD discipline:
- Stop the task immediately
- Point out the specific violation
- Repost the relevant phase instructions
- Resume with corrected approach

### 6. Small, Testable Increments
Each implementation step should be:
- Completable in one TDD cycle
- Testable in isolation
- Additive (doesn't break existing tests)

## Troubleshooting

### Symlinks Not Working

#### Windows
- Verify Developer Mode is enabled
- Check that `git config core.symlinks` is true
- Ensure you're running PowerShell from project root
- Try creating one symlink manually to test permissions

#### macOS/Linux
- Check that `git config core.symlinks` is true
- Verify source files exist at the expected path
- Ensure you have write permissions in project directory
- Test with: `ls -la .claude/prompts/` to verify symlinks

### Claude Not Following Process
- Explicitly reference `.claude/prompts/[phase-name].md` in commands
- Break requests into smaller, phase-specific chunks
- Add "STOP and wait for approval" to prevent Claude from jumping ahead
- Review `.claude/instructions.md` - ensure it's clear and concise

### Tests Not Following TDD
- Verify you're requesting "failing test FIRST"
- Check that RED phase is behavioral failure, not compilation error
- Limit to 3 red-green iterations per step
- Reference `.claude/prompts/2-implement` explicitly in implementation requests

### Context Loss Over Long Sessions
- Start new Claude Code task after 8-10 implementation steps
- Reference previous work: "Based on previous implementation of [X]..."
- Keep `.claude/instructions.md` concise so it's always in context

## Advanced: Multi-Project Setup

To use these prompts across multiple projects:

1. Keep your master prompts in a central location (e.g., `~/Documents/pdca-templates/`)
2. Create symlinks from each project's `.claude/prompts/` directory to the master templates
3. All projects stay in sync with your master PDCA templates
4. Update prompts once, changes apply everywhere

### Creating Symlinks for a New Project

#### Windows (PowerShell)
```powershell
# Navigate to new project
cd C:\path\to\new-project

# Create .claude/prompts directory
New-Item -ItemType Directory -Path ".claude\prompts" -Force

# Create symlinks (adjust $templatesBase to your master location)
$templatesBase = "$env:USERPROFILE\Documents\pdca-templates"

New-Item -ItemType SymbolicLink -Path ".claude\prompts\1a-analyze.md" -Target "$templatesBase\plan\1a-analyze.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\1b-plan.md" -Target "$templatesBase\plan\1b-plan.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\2-implement.md" -Target "$templatesBase\do\2-implement.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\3-check.md" -Target "$templatesBase\check\3-check.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\4-retrospect.md" -Target "$templatesBase\act\4-retrospect.md"
```

#### macOS/Linux (Bash)
```bash
# Navigate to new project
cd /path/to/new-project

# Create .claude/prompts directory
mkdir -p .claude/prompts

# Create symlinks (adjust TEMPLATES_BASE to your master location)
TEMPLATES_BASE="$HOME/Documents/pdca-templates"

ln -s "$TEMPLATES_BASE/plan/1a-analyze.md" ".claude/prompts/1a-analyze.md"
ln -s "$TEMPLATES_BASE/plan/1b-plan.md" ".claude/prompts/1b-plan.md"
ln -s "$TEMPLATES_BASE/do/2-implement.md" ".claude/prompts/2-implement.md"
ln -s "$TEMPLATES_BASE/check/3-check.md" ".claude/prompts/3-check.md"
ln -s "$TEMPLATES_BASE/act/4-retrospect.md" ".claude/prompts/4-retrospect.md"
```

## Platform-Specific Notes

### Windows
- Requires Developer Mode for non-admin symlink creation
- Use backslashes (`\`) in paths or PowerShell forward slashes
- Git Bash on Windows works with Unix-style paths
- Recommended template location: `%USERPROFILE%\Documents\pdca-templates\`

### macOS
- Symlinks work out of the box
- Case-sensitive filesystem considerations may apply
- Recommended template location: `~/Documents/pdca-templates/`

### Linux
- Standard symlink support
- Works with any filesystem that supports symlinks
- Recommended template location: `~/documents/pdca-templates/` or `~/dev/pdca-templates/`

## Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [PDCA Framework Repository](https://github.com/kenjudy/human-ai-collaboration-process)
- [Test-Driven Development Guide](https://martinfowler.com/bliki/TestDrivenDevelopment.html)

## License

This setup guide is part of the Human-AI PDCA Collaboration Process framework, licensed under CC BY 4.0.

---

*Last Updated: 2025*