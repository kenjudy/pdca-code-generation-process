# Planning Phase: Detailed Implementation Strategy

**Purpose:** Create trackable, atomic implementation steps optimized for AI execution
**When to use:** After completing analysis phase(s)
**Prerequisites:** Clear problem understanding and chosen approach from analysis
**Expected output:** Numbered implementation steps, testing strategy, process checkpoints
**Typical duration:** 2-5 minutes
**Next step:** Begin TDD implementation (2)
**Note:** Plan output is verbose and typically not added to ticket tracking

---
``` markdown
**Planning Phase** Based on our analysis, provide a coherent plan incorporating our refinements that is optimized for your use as context for the implementation:

**Execution Context:** This plan will be implemented in steps following TDD discipline with human supervision. Each step tagged for optimal model selection within the same thread context.

**Integration Strategy:**

- Map end-to-end data flow and all touch points
- Identify required changes to existing methods/interfaces
- Plan backward compatibility approach
- Consider file organization and naming consistency

**Testing Strategy:** Test Drive atomic changes to production code using red/green strategy

- Break the work into atomic, incremental changes
- For each task or batch: write failing test(s) with clear behavioral expectations that drive code changes needed
- Compilation ≠ Red phase - Write compiling stubs first, then test actual behavior expectations, not symbol existence
- Implement minimal code to pass tests. Max 3 iterations to green
- Summarize outcome and refactoring needs providing a commit message. Wait for approval before proceeding

**Opportunities for Batched TDD:**

- Group related functionality into logical batches for pattern reuse
- Write failing tests for batch components together
- Implement batch while maintaining red/green discipline

**Multi-System Work:**

- [ ] Logical architecture identical across systems
- [ ] System-specific constraints checked (reserved keywords, etc.)

**Create actionable plan with:**

- Numbered implementation steps (small, testable increments)
- ONE file/component per step when possible
- Acceptance criteria for each step
- Definition of done (tests pass + process followed)
- Risk areas to monitor
- Rollback approach if needed

**Step-Level Model Selection:** Tag each implementation step for optimal model use:

**[O] - Opus 4 Required:**

- Novel architectural decisions affecting multiple components
- Complex error handling across system boundaries
- Integration with unfamiliar external APIs/systems
- Performance optimization requiring deep reasoning
- Debugging complex multi-step failures
- Pattern creation for new problem domains
- Design decisions with significant downstream impact

**[S] - Sonnet 4 Recommended:**

- Standard feature implementation following established patterns
- Test-driven development within known architecture
- Multi-file coordination within familiar systems
- Refactoring existing code with established test coverage
- Error handling for known failure modes
- Configuration and setup tasks
- Code review and quality analysis
- Most debugging within established architecture

**[H] - Haiku 3.5 Viable (with constraints):**

- Exact pattern replication with explicit code template provided
- Single-file changes following established conventions
- Simple data transformations with clear input/output specifications
- Code formatting and style consistency applications
- Documentation updates following existing formats
- Mechanical test additions using existing test patterns
- Variable/method renaming across files
- Basic CRUD operations using established repository patterns

**Model Selection Decision Tree:**

1. **Does this step establish a new pattern or approach?** → [O] or [S]
2. **Does this step require reasoning about system behavior?** → [S] minimum
3. **Does this step involve cross-system integration or novel problem-solving?** → [O]
4. **Is this step pure mechanical application of an established pattern?** → [H] possible
5. **When in doubt, default to [S]**

**Haiku 3.5 Success Requirements:** When tagging [H], provide in the step description:

- Explicit code template or example to follow
- Exact file paths and method names to modify
- Clear acceptance criteria (specific test passes + compiles)
- Stop conditions requiring human review or model escalation

**Process Checkpoints:**

- Verify adherence to chosen testing strategy
- Each step: Confirm appropriate test coverage exists
- Complexity check: If tests become complex, simplify the step
- Model match verification: Is the tagged model appropriate for actual complexity encountered?

```

_Plan is verbose and I don't add it to any tracking_


---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution. 

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

---
*2025*