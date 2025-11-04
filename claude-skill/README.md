# PDCA Framework Skill - Setup Guide

A Claude skill for human-supervised AI code generation using Plan-Do-Check-Act methodology with strict TDD discipline.

## What This Skill Does

This skill provides a disciplined framework for AI-assisted code generation that:
- Maintains code quality through structured TDD practices
- Reduces technical debt by enforcing architecture pattern discovery
- Keeps humans actively engaged and accountable
- Provides structured prompts for analysis, planning, implementation, validation, and retrospection

**Based on research showing:** AI code generation without human oversight leads to 10x increase in duplicated code, 7.2% decrease in delivery stability, and 19% slower development.

---

## Installation

### For Claude.ai Web/Desktop App

1. **Download the skill file**
   - Locate `pdca-framework.skill` (provided by the skill creator)

2. **Open Claude Settings**
   - Click your profile icon (top right)
   - Select "Settings" or "Preferences"

3. **Navigate to Skills**
   - Find the "Skills" or "Custom Skills" section
   - Click "Add Skill" or "Upload Skill"

4. **Upload the skill**
   - Select the `pdca-framework.skill` file
   - Confirm the upload

5. **Verify installation**
   - The skill should appear in your skills list
   - Status should show as "Active" or "Enabled"

### For Claude Code (Command Line)

```bash
# Skills are automatically available in Claude Code
# No manual installation needed - skills in your account sync automatically
```

---

## Quick Start

### Starting a New Coding Session

Simply mention your coding task and the skill will auto-trigger:

```
I need to add a new payment validation feature to our checkout flow. 
Let's use the PDCA framework.
```

Or explicitly reference the skill:

```
@pdca-framework I need to fix a bug in the user authentication system.
```

### Following the PDCA Cycle

The skill will guide you through four phases:

#### 1. **PLAN** (7-15 min)
Claude will prompt you through:
- **Analysis**: Understanding the problem and discovering existing patterns
- **Planning**: Creating atomic, testable implementation steps

#### 2. **DO** (30 min - 2.5 hrs)
Claude will provide:
- **TDD checklists**: Red-green-refactor discipline
- **Integration guidance**: Real components over mocks
- **Process checkpoints**: When to pause and validate

#### 3. **CHECK** (2-5 min)
Claude will verify:
- **Completeness**: All objectives met
- **Quality**: Tests passing, no regressions
- **Process compliance**: TDD maintained throughout

#### 4. **ACT** (5-10 min)
Claude will facilitate:
- **Retrospective**: What worked, what didn't
- **Improvements**: 1-3 changes for next cycle
- **Learning capture**: Update working agreements

---

## Using Specific Phases

### Get Analysis Prompt
```
@pdca-framework Show me the analysis phase prompt
```

### Get Planning Prompt
```
@pdca-framework I need the detailed planning template
```

### Get TDD Implementation Checklist
```
@pdca-framework Show me the DO phase checklist
```

### Run a Retrospective
```
@pdca-framework Let's retrospect on this session
```

---

## Working Agreements

The skill includes working agreements that define your collaboration contract with the AI. Key principles:

- **USE TDD FOR CHANGES** - Intervene when agent breaks discipline
- **One change at a time** - No fixing multiple things simultaneously
- **Respect existing architecture** - Work within established patterns
- **Process discipline trumps immediate progress** - Stop and correct violations

These are stored in the skill and referenced automatically, but you can also review them:

```
@pdca-framework Show me the working agreements
```

---

## Customizing for Your Team

### Step 1: Export the Skill Contents
Ask Claude to show you the current prompt templates:
```
@pdca-framework Show me the [PLAN/DO/CHECK/ACT] phase prompts
```

### Step 2: Identify Changes
Based on your retrospectives, determine what needs updating:
- Language-specific testing patterns (pytest, jest, xUnit, etc.)
- Your team's architectural conventions
- Project-specific quality gates
- Intervention triggers that work for your team

### Step 3: Document Your Changes
Keep a working document of your customizations:
```markdown
## Our Team's PDCA Customizations

### Analysis Phase
- Added: Terraform state validation check
- Changed: "codebase_search" → our internal tool name

### TDD Implementation
- Added: Our cypress integration test pattern
- Removed: References to unit test patterns we don't use
```

### Step 4: Request Skill Updates
When you have 3-5 meaningful changes:
```
@pdca-framework Based on our retrospectives, I want to update the 
analysis phase to include [specific change]. Can you help me create 
an updated version of this skill?
```

---

## Troubleshooting

### Skill Not Triggering
**Symptoms:** Claude doesn't use the framework when discussing code

**Solutions:**
1. Explicitly reference it: `@pdca-framework`
2. Use trigger words: "code generation", "TDD", "PDCA cycle"
3. Check skill is enabled in settings

### Context Drift During DO Phase
**Symptoms:** Agent makes sprawling changes, ignores TDD, breaks rules

**Solution:** This is expected behavior when context window fills. Follow the skill's recovery process:
1. Stop the thread immediately
2. Tell Claude what you observe
3. Say: `@pdca-framework I'm seeing context drift. Let's refocus on step [X] using the DO phase checklist`

### Too Much Boilerplate
**Symptoms:** Prompts feel repetitive or verbose

**Solution:** The skill is designed for 1-3 hour coding sessions. For very small changes:
```
@pdca-framework Quick mode - I just need to [simple change]. 
Skip to DO phase with minimal planning.
```

### Agent Suggests Non-TDD Approach
**Symptoms:** Claude proposes skipping tests or making large changes

**Solution:** Invoke your working agreements:
```
Stop. Our working agreement is to use TDD. Show me the failing test first.
```

---

## Best Practices

### 1. Right-Size Your Sessions
- **Ideal:** 1-3 hours of focused work
- **Too small:** < 30 minutes (overhead > value)
- **Too large:** > 3 hours (context drift likely)

### 2. Run Daily Retrospectives
After each session:
```
@pdca-framework Let's retrospect on today's work
```
Make 1-3 small improvements, not wholesale changes.

### 3. Keep Working Agreements Visible
Print or display your working agreements during coding sessions. They're your intervention triggers.

### 4. Intervene Early and Often
Don't wait for big problems:
- "You're on step 3 but this looks like step 5 work"
- "Did you write the failing test first?"
- "Are we respecting the existing FileProvider pattern?"

### 5. Use Real Components in Tests
Question any mocking:
```
Why are we mocking the file system? 
Can we use a temporary directory instead?
```

---

## When NOT to Use This Skill

The PDCA framework is designed for **production code generation**. Don't use it for:

- **Exploratory coding** - Quick experiments, prototypes
- **Documentation writing** - README files, API docs
- **Configuration changes** - YAML, JSON, environment files
- **Trivial changes** - Typo fixes, import reordering
- **Learning exercises** - Tutorials, katas, practice problems

For these tasks, regular Claude conversation is more appropriate.

---

## Learning More

### Understanding the Research
The skill is based on documented research showing AI code generation quality issues:
- GitClear 2024: 10x increase in duplicated code
- Google DORA 2024: 7.2% stability decrease per 25% AI adoption
- METR 2025: 19% slower development with AI tools

Read the full framework paper: [Link would go here]

### Philosophy
This framework embodies agile principles:
- **Individuals and interactions** over processes and tools (human oversight)
- **Working software** over comprehensive documentation (TDD focus)
- **Customer collaboration** over contract negotiation (value-based objectives)
- **Responding to change** over following a plan (retrospection)

### Contributing
The PDCA framework is open source under CC BY 4.0.

**Repository:** https://github.com/kenjudy/human-ai-collaboration-process
**Issues/Suggestions:** [Create GitHub issue]
**Discussions:** [GitHub Discussions]

---

## Support

### Getting Help
1. Check this README first
2. Review the changelog for recent updates
3. Try asking Claude: `@pdca-framework Explain [concept]`
4. Open an issue on GitHub

### Sharing Your Experience
Help improve the framework:
- Share retrospective insights
- Document what customizations work
- Report bugs or unclear guidance
- Suggest improvements

---

## Version Information

**Current Version:** Based on GitHub repository as of 2025
**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)
**Attribution:** Ken Judy with Claude Anthropic 4
**Last Updated:** 2025

---

## Quick Reference Card

```markdown
PDCA CYCLE QUICK REFERENCE

1. PLAN (7-15 min)
   └─ Analysis: Discover patterns, validate external systems
   └─ Planning: Create atomic steps, define testing strategy

2. DO (30 min - 2.5 hrs)
   └─ Red: Write failing test
   └─ Green: Minimal code to pass
   └─ Refactor: Clean up
   └─ Repeat for each step

3. CHECK (2-5 min)
   └─ All tests passing?
   └─ Process discipline maintained?
   └─ Ready to close?

4. ACT (5-10 min)
   └─ What worked?
   └─ What didn't?
   └─ What to change next time?

INTERVENTION TRIGGERS
- No failing test first → "Where's the red?"
- Multiple changes → "One thing at a time"
- Breaking patterns → "Are we following [existing pattern]?"
- Context drift → Stop, refocus, restart

HUMAN COMMITMENTS
✓ Intervene early and often
✓ Take accountability for code quality
✓ Make 1-3 improvements per cycle
✓ Stay engaged throughout session
```

Print this card and keep it visible during coding sessions!

---

**Ready to start?** Try: `@pdca-framework I need to [your coding task]`
