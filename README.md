# Human-AI Collaboration Process

## Intent & Philosophy

This process framework implements a disciplined Plan-Do-Check-Act (PDCA) cycle for human-AI collaborative software development, with Test-Driven Development (TDD) and Retrospection as core methodologies. The framework recognizes that AI coding assistants, while powerful, require structured guidance and process discipline to maintain code quality and avoid common pitfalls like scope creep, inadequate testing, and architectural drift.

The approach establishes clear intervention points where humans must stop AI execution to ensure adherence to established working agreements. This creates a sustainable collaboration pattern that leverages AI capabilities while maintaining engineering rigor.

## Core Principles

- **TDD Discipline**: Every code change must be driven by a failing test first
- **Small Batch Changes**: One focused change at a time, one failing test at a time
- **Process Intervention Rights**: Humans interrupt immediately when process violations are observed
- **Minimal Changes**: Smallest possible changes addressing specific issues
- **Architectural Respect**: Work within established patterns unless explicitly changing them
- **Human Working Agreements**: A commitment to stay engaged and own accountability for the process adherence, for architectural decisions, and resulting code

## Quick Start Guide

### Before Your First Session

1. **Establish Working Agreements**: Review and customize the [Human Working Agreements](Human%20Working%20Agreements.md) for your context
2. **Set Up Environment**: Ensure AI has codebase access and you can run tests quickly
3. **Choose Engagement Level**: Decide on your supervision intensity (high/moderate/light)

### First Session Workflow

**Step 1: Analysis** (2-5 min) - Use [template 1a](1.%20Plan/1a%20Analyze%20to%20determine%20approach%20for%20achieving%20the%20goal.md)

- Describe your goal clearly
- Let AI discover existing architectural patterns
- Get complexity assessment and approach recommendations

**Step 2: Planning** (2-5 min) - Use [template 1b](1.%20Plan/1b%20Create%20a%20detailed%20implementation%20plan.md)

- AI creates atomic, testable implementation steps
- Review and adjust scope if needed

**Step 3: Test-Drive Implementation** (Variable) - Use [template 2](2.%20Do/2.%20Test%20Drive%20the%20Change.md)

- **Watch for TDD violations** - interrupt immediately when you see them
- Use intervention phrases: "Where's the failing test first?" "You're fixing multiple things. Focus on one failing test?"

**Step 4: Check Completeness** (2-5 min) - Use [template 3](3.%20Check/3.%20Completeness%20Check.md)

- Verify tests pass and goals met
- Audit TDD process adherence

**Step 5: Retrospect** (5-10 min) - Use [template 4](4.%20Act/4.%20Retrospect%20for%20continuous%20improvement.md)

- Analyze what worked and what didn't
- Update working agreements based on learnings

_time estimates assume sessions of 1-3 hours in scope_
### Red Flags to Watch For

Stop the AI immediately if you see:

- ❌ Writing production code without a failing test first
- ❌ "Let me just quickly fix this other thing too..."
- ❌ Changing test expectations to make tests pass
- ❌ Working on multiple files/features simultaneously

## The Plan-Do-Check-Act Process

### 1a - Analyze to determine approach for achieving the goal

- High-level design brainstorm and problem understanding
- Architecture pattern discovery using codebase search
- Complexity assessment and delegation recommendations
- Focus on "what" and "why" at a strategic level

### 1b - Create a detailed implementation plan

- Create trackable, atomic implementation steps
- Optimize planning for the chosen AI model's capabilities
- Define testing strategy and integration approach
- Establish clear acceptance criteria and risk mitigation

### 2 - Test Drive the Change

- Strict red-green-refactor discipline
- Process discipline checkpoints at each step
- Integration tests with real components over mocks
- Troubleshooting and regression handling protocols

### 3 - Completeness Check

- Verify all tests passing and objectives met
- Test coverage and quality analysis
- Process audit to ensure TDD discipline was maintained
- Documentation and regression checks

### 4 - Retrospect for continuous improvement

- Session analysis and critical moments review
- Collaboration pattern effectiveness assessment
- Actionable insights for process improvement
- Working agreement refinements for future sessions

## Key Collaboration Patterns

**Process Police Intervention**: Humans actively monitor and interrupt AI execution when process violations occur, using direct questions like:

- "You broke from test-driving. Is there adequate test coverage?"
- "Where's the failing test first?"
- "This feels like scope creep. Are we still on step [N]?"

**Complexity Management**: The framework includes guidance for assessing when work is appropriate for different AI model tiers and how to structure complex problems for effective delegation.

**Context Drift Prevention**: Clear protocols for recognizing when AI agents lose context and need to be reined back in with explicit process reminders.

## Templates & Implementation

This README provides the conceptual framework. The actual implementation uses separate template files for each phase, allowing for:

- Customization based on project needs
- Iterative improvement of prompts based on retrospective findings
- Maintenance of working agreements between human and AI collaborators

## Related Resources

For broader context on code quality metrics and practices, see the [Code Quality Metrics Repository](https://github.com/kenjudy/code-quality-metrics).

## License

This framework is released under Creative Commons licensing terms. You are free to use, modify, and distribute this process framework with appropriate attribution.

---

_Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4_
