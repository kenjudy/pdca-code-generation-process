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
**Planning Phase**
Based on our analysis, provide a coherent plan incorporating our refinements that is optimized for your use as context for the implementation:

**Execution Context:** This plan will be implemented by [Claude 3.5 Haiku|Claude 4 Sonnet depending on findings of analysis] where practical following TDD discipline with human supervision.

[DELETE PLAN OP]
**Plan Optimization for Haiku:**
- Provide explicit context and architectural patterns for each step
- Break work into smaller, clearly bounded increments
- Specify exact files/methods to modify
- Include clear stop conditions and validation points
- Reference existing code patterns by name rather than assuming inference

**Integration Strategy:**
- Map end-to-end data flow and all touch points
- Identify required changes to existing methods/interfaces
- Plan backward compatibility approach  
- Consider file organization and naming consistency

**Testing Strategy:** 
Test Drive atomic changes to production code using red/green strategy

 - Break the work into atomic, incremental changes
 - For each task or batch: write failing test(s) that drive code changes needed
 - Compilation ≠ Red phase - Write compiling stubs first, then test actual behavior expectations, not symbol existence.
 - Implement minimal code to pass tests. Max 3 iterations to green.
 - Summarize outcome and refactoring needs providing a commit message. Wait for approval before proceeding.

Opportunities for Batched TDD

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

**Process Checkpoints:**
- Verify adherence to chosen testing strategy
- Each step: Confirm appropriate test coverage exists
- Complexity check: If tests become complex, simplify the step

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