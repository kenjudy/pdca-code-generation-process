# PLAN Phase: Analysis & Detailed Planning

This file contains prompts for both analysis (1a) and planning (1b) phases.

---

# Analysis Phase: Problem Understanding & Approach Selection

**Purpose:** High-level design brainstorm to understand the problem scope and identify viable approaches
**When to use:** Start of any new feature, bug fix, or significant change
**Prerequisites:** Clear problem statement or user story
**Expected output:** Problem understanding, architectural pattern discovery, complexity assessment
**Typical duration:** 2-5 minutes
**Next step:** Either refine with ramifications analysis (1a-optional) or proceed to planning (1b)

If provided, run this prompt in "Planning mode"

---
``` markdown

I need to do a high level design brainstorm. 

The overall goal is to [describe the overall goal as best I understand it. Highlevel design considerations, questions, concerns]

**Analysis needed:**
- Understand the problem and its scope
- Explore different approaches or solutions
- Identify potential challenges, dependencies, or unknowns
- Consider architectural implications or patterns
- Assess complexity and effort (rough estimate)
- Note any assumptions or clarifications needed

**Architecture Pattern Discovery (MANDATORY FIRST STEP - BLOCKING):**
Execute these searches BEFORE any analysis. Do not proceed until completed:

- [ ] **SEARCH 1**: `codebase_search` for similar feature implementations (query: "How does [similar functionality] work in the codebase?")
- [ ] **SEARCH 2**: `codebase_search` for integration patterns (query: "Where are [related services/components] integrated with existing systems?")  
- [ ] **SEARCH 3**: `codebase_search` for configuration patterns (query: "How are similar configuration options implemented and used?")

**Required Deliverables BEFORE Analysis:**
- Identify 2-3 existing implementations that follow similar patterns
- Document the established architectural layers (which namespaces, which interfaces)
- Map the integration touch points (which existing methods will need modification)
- List the abstractions already available (FileProvider, interfaces, base classes)
- **Solution Constraint**: State which existing abstractions the solution MUST use (no new ones unless absolutely necessary)

**STOP CONDITION**: Do not proceed to analysis until you have concrete examples of:
1. How similar features are structured in this codebase
2. What existing interfaces/abstractions should be reused
3. Where the integration points are located
   
**External System Validation (MANDATORY SECOND STEP):**
- [ ] Identify external systems/APIs/formats this feature depends on
- [ ] Use run_terminal_cmd or direct inspection to validate actual formats/behaviors
- [ ] Document real examples of external system outputs in comments
- [ ] Flag any assumptions about external systems for immediate validation

**Validation Questions:**
- What external system outputs will we parse/consume?
- Are we making assumptions about data formats without seeing real examples?
- Can we query/inspect the actual system now to understand the format?

**Delegation Complexity Assessment:**
Based on the problem scope and architectural patterns discovered:
- **Implementation Complexity**: [Low/Medium/High] - How much architectural inference required?
- **Pattern Clarity**: [Clear/Moderate/Ambiguous] - Are existing patterns well-established and discoverable?
- **Context Scope**: [Narrow/Medium/Broad] - How many files/systems need coordination?
- **Debugging Likelihood**: [Low/Medium/High] - How much investigation vs. implementation?
- **External System Integration**: [None/Simple/Complex] - Does this require parsing external formats or real-time debugging?

**Output:** Provide a terse and clear understanding of the problem and recommended high level alternative approaches. Keep it at a human readable length and level of detail.

```

**Refine the analysis with questions**

**Add analysis to the story**

---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution. 

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

---
*2025*
---

# Planning Phase: Detailed Implementation Strategy

**Purpose:** Create trackable, atomic implementation steps optimized for AI execution
**When to use:** After completing analysis phase(s)
**Prerequisites:** Clear problem understanding and chosen approach from analysis
**Expected output:** Numbered implementation steps, testing strategy, process checkpoints
**Typical duration:** 2-5 minutes
**Next step:** Begin TDD implementation (2)
**Note:** Plan output is verbose and typically not added to ticket tracking

If available run this prompt in "Planning" mode.

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