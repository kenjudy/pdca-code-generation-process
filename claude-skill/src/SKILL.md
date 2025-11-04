---
name: pdca-framework
description: Human-supervised PDCA (Plan-Do-Check-Act) framework for AI-assisted code generation. Use when generating production code with AI agents to maintain quality, reduce technical debt, and keep humans engaged. Applies structured analysis, planning, test-driven development, validation, and retrospection to AI coding sessions. Essential for developers who need systematic approaches to maintain code quality and accountability when using AI code generation tools in complex codebases.
---

# PDCA Framework for AI-Assisted Code Generation

A disciplined approach to AI-assisted code generation that employs agile practices organized in the Plan-Do-Check-Act cycle. This framework occurs within individual code generation sessions as a nested loop, with full cycles taking 1-3 hours.

## Core Philosophy

This framework addresses the sustainability crisis in AI code generation where research shows:
- 10x increase in duplicated code blocks (GitClear 2024)
- 7.2% decrease in delivery stability per 25% AI adoption increase (Google DORA 2024)
- 19% slower development with AI tools vs. without (METR research)

The solution keeps humans actively engaged, empowered, and accountable while using structured prompts to regulate agent behavior toward transparency and discipline.

## Working Agreements

Commitments you hold yourself accountable to when interacting with coding agents. See `references/working-agreements.md` for complete list and examples.

**Core principles:**
- Enforce strict TDD: one failing test at a time, no exceptions
- Respect existing architecture: work within established patterns
- Intervene immediately on process violations
- Explicitly establish methodology, scope, and intervention rights before coding

## PDCA Cycle Overview

Each step has distinct prompts and human commitments:

### 1. PLAN: Analyze & Plan (7-15 min)
- **Analysis**: Examine codebase, define achievable objectives, explore approaches
- **Planning**: Create detailed execution plan with numbered steps and checkpoints
- See `references/plan-prompts.md` for complete templates

### 2. DO: Code Generation (30 min - 2.5 hrs)
- **TDD Implementation**: Red-green-refactor with checklist-based guidance
- **Active Oversight**: Follow agent's work, intervene early and often
- See `references/do-prompts.md` for implementation checklists

### 3. CHECK: Validate (2-5 min)
- **Completeness**: Verify against analysis, plan, and quality standards
- **Definition of Done**: Explicit checklist for delivery readiness
- See `references/check-prompts.md` for validation templates

### 4. ACT: Retrospect (5-10 min)
- **Process Review**: Identify what worked and what to improve
- **Continuous Improvement**: Update 1-3 small things for next cycle
- See `references/act-prompts.md` for retrospective guides

## When to Use Each Phase

**Start with PLAN when:**
- Beginning a new feature or significant change
- Scope is unclear or could expand
- Multiple approaches are possible

**Use DO iteratively:**
- After completing plan
- For each step in the implementation plan
- When context drift occurs, restart with updated plan

**CHECK after:**
- Completing all planned steps
- Before committing code
- When uncertain if work is complete

**ACT at end of session:**
- After successful completion
- After encountering significant challenges
- To refine prompts and practices

## Context Drift Recovery

If agent makes sprawling edits, breaks TDD, or ignores working agreements:
1. Stop the thread immediately
2. Describe what you observe
3. Repost the relevant phase prompts
4. Direct agent to proceed with renewed focus

## Prompt Customization

All prompts are starting templates. Adapt them to:
- Your specific model and version
- Your team's practices and conventions
- Your codebase architecture
- Lessons from retrospectives

The PDCA cycle itself provides rapid feedback for incremental prompt evolution.

---

## License & Attribution

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

**Living Framework:** These prompts and working agreements should be continuously refined based on retrospective learnings from each collaboration session.
