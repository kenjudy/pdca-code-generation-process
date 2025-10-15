# Claude Code PDCA Workflow Setup Guide

This guide explains how to configure Claude Code to follow the PDCA (Plan-Do-Check-Act) development workflow with TDD discipline.

## Overview

The PDCA workflow consists of four phases:
1. **Plan** - Analysis and detailed planning
2. **Do** - Test-driven implementation
3. **Check** - Completeness verification
4. **Act** - Retrospection and continuous improvement

## Prerequisites

- Windows 10/11 with Developer Mode enabled (for symlinks without admin rights)
- Claude Code CLI installed
- Git configured with `core.symlinks = true`

## Project Structure

After setup, your project should have:

```
your-project/
├── .claude/
│   ├── instructions.md          # Main workflow instructions
│   ├── prompts/                 # Symlinked phase templates
│   │   ├── 1a Analyze to determine approach for achieving the goal.md
│   │   ├── 1b Create a detailed implementation plan.md
│   │   ├── 2. Test Drive the Change.md
│   │   ├── 3. Completeness Check.md
│   │   └── 4. Retrospect for continuous improvement.md
│   └── validation.md            # Pre-commit checklist
├── .claudeignore                # Files for Claude to ignore
└── LinkPrompts.ps1              # Script to create symlinks (optional)
```

## Setup Steps

### 1. Enable Developer Mode (Windows)

To create symlinks without admin rights:
1. Open Settings → Update & Security → For Developers
2. Turn on **Developer Mode**
3. Restart PowerShell/Terminal

### 2. Configure Git for Symlinks

```bash
git config core.symlinks true
```

### 3. Create Directory Structure

From your project root:

```powershell
# Create .claude directory structure
New-Item -ItemType Directory -Path ".claude\prompts" -Force
```

### 4. Create Symlinks to Prompt Templates

**Option A: Manual Creation**

```powershell
# From your project root
New-Item -ItemType SymbolicLink -Path ".claude\prompts\1a Analyze to determine approach for achieving the goal.md" -Target "C:\Users\Ken Judy\iCloudDrive\iCloud~md~obsidian\PDCA Process\1. Plan\1a Analyze to determine approach for achieving the goal.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\1b Create a detailed implementation plan.md" -Target "C:\Users\Ken Judy\iCloudDrive\iCloud~md~obsidian\PDCA Process\1. Plan\1b Create a detailed implementation plan.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\2. Test Drive the Change.md" -Target "C:\Users\Ken Judy\iCloudDrive\iCloud~md~obsidian\PDCA Process\2. Do\2. Test Drive the Change.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\3. Completeness Check.md" -Target "C:\Users\Ken Judy\iCloudDrive\iCloud~md~obsidian\PDCA Process\3. Check\3. Completeness Check.md"
New-Item -ItemType SymbolicLink -Path ".claude\prompts\4. Retrospect for continuous improvement.md" -Target "C:\Users\Ken Judy\iCloudDrive\iCloud~md~obsidian\PDCA Process\4. Act\4. Retrospect for continuous improvement.md"
```

**Option B: Using Script**

Create `LinkPrompts.ps1` in your project root (or a shared location) and run it from each project directory.

### 5. Create `.claudeignore`

Create `.claudeignore` in your project root with appropriate patterns for your C# project (see section below).

### 6. Create `.claude/instructions.md`

Create the main instructions file that Claude Code will read automatically (see section below).

### 7. Create `.claude/validation.md` (Optional)

Create a validation checklist for pre-commit checks (see section below).

## Configuration Files

### `.claude/instructions.md`

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
- NUnit with Assert.That syntax
- Leverage TestUtils.cs and fixtures directory
- Add tests to existing fixtures when coherent
- Avoid proliferating new test files

## Process Checkpoints
Before proceeding with implementation:
- [ ] Have I searched for similar implementations?
- [ ] Have I validated external system formats?
- [ ] Have I written a FAILING test first?
- [ ] Am I implementing ONLY enough to pass the test?

## Detailed Phase Instructions
See `.claude/prompts/` directory for detailed instructions for each phase.
```

### `.claudeignore`

```gitignore
# Build outputs
**/bin
!DependencyTracerTests/fixtures/**/bin
obj
**/obj

# IDE and editor files
**/.vs
**/.idea
**/.vscode
**/*.DotSettings
**/*.user
**/*.suo

# OS files
**/.DS_Store
**/Thumbs.db
**/._.DS_Store
**/._*.*
**/._*

# Test outputs
**/test-output
**/TestResults
**/*.trx
**/*.dcvr

# Database files
**/kuzu_db
**/kuzu-*data*
DatabaseScripts/**/_*.cypher

# Artifacts
artifacts/**/tmp
artifacts/tracer/sourc*
artifacts/prompts
artifacts/**/csv
**/fixtures/output

# Logs
*.log

# NuGet
packages/
.nuget/

# Git
.git/

# Config
.conductor
.lfsconfig

# Binaries
*.dll
*.exe
*.pdb
*.cache
```

### `.claude/validation.md`

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

## Usage Workflow

### Starting a New Feature

Always work through phases sequentially:

#### Phase 1a: Analysis

```bash
claude-code "Following .claude/prompts/1a: Analyze implementing [feature description]. 
Search codebase for similar patterns before proposing approach. 
STOP after analysis and wait for approval."
```

**Review the analysis before proceeding.**

#### Phase 1b: Planning

```bash
claude-code "Based on approved analysis, create detailed implementation plan 
following .claude/prompts/1b. Break into atomic TDD steps."
```

**Review the plan and approve specific steps.**

#### Phase 2: Implementation (Step by Step)

```bash
# For each planned step:
claude-code "Test-drive step [N]: [specific requirement]. 
Follow .claude/prompts/2 TDD discipline strictly. 
Write failing test FIRST, then minimal implementation."
```

**Key points:**
- One step at a time
- Always RED (failing test) before GREEN (implementation)
- Review after each step before proceeding
- Maximum 3 red-green iterations per step

#### Phase 3: Completeness Check

```bash
claude-code "Run completeness check per .claude/prompts/3. 
Verify all planned steps complete and process followed."
```

#### Phase 4: Retrospection

```bash
claude-code "Retrospect on this implementation session following .claude/prompts/4. 
Identify what worked well and what to improve."
```

## Best Practices

### 1. Explicit Phase References
Always mention `.claude/prompts/[phase].md` in your commands so Claude knows where to look.

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
- Verify Developer Mode is enabled
- Check that `git config core.symlinks` is true
- Ensure you're running PowerShell from project root
- Try creating one symlink manually to test permissions

### Claude Not Following Process
- Explicitly reference `.claude/prompts/[phase].md` in commands
- Break requests into smaller, phase-specific chunks
- Add "STOP and wait for approval" to prevent Claude from jumping ahead
- Review `.claude/instructions.md` - ensure it's clear and concise

### Tests Not Following TDD
- Verify you're requesting "failing test FIRST"
- Check that RED phase is behavioral failure, not compilation error
- Limit to 3 red-green iterations per step
- Reference `.claude/prompts/2` explicitly in implementation requests

### Context Loss Over Long Sessions
- Start new Claude Code task after 8-10 implementation steps
- Reference previous work: "Based on previous implementation of [X]..."
- Keep `.claude/instructions.md` concise so it's always in context

## Advanced: Multi-Project Setup

To use these prompts across multiple projects:

1. Keep your master prompts in a central location (e.g., iCloud/Obsidian)
2. Create a shared `LinkPrompts.ps1` script that takes project path as parameter
3. Run the script once per project to set up symlinks
4. All projects stay in sync with your master PDCA templates

```powershell
# Shared script usage
& "C:\Users\Ken Judy\.claude\LinkPrompts.ps1" -ProjectPath "C:\path\to\project"
```

## Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [PDCA Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)
- Project-specific testing conventions: See `TestUtils.cs` and `fixtures/` directory

## License

This setup guide is part of the Human-AI PDCA Collaboration Process framework, licensed under CC BY 4.0.

---

*Last Updated: 2025*