# Analysis Phase: Problem Understanding & Approach Selection

**Purpose:** High-level design brainstorm to understand the problem scope and identify viable approaches
**When to use:** Start of any new feature, bug fix, or significant change
**Prerequisites:** Clear problem statement or user story
**Expected output:** Problem understanding, architectural pattern discovery, complexity assessment
**Typical duration:** 2-5 minutes
**Next step:** Either refine with ramifications analysis (1a-optional) or proceed to planning (1b)

---
``` markdown

I need to do a high level design brainstorm. 

The overal goal is to [describe the overall goal as best I understand it. Highlevel design considerations, questions, concerns]

**Analysis needed:**
- Understand the problem and its scope
- Explore different approaches or solutions
- Identify potential challenges, dependencies, or unknowns
- Consider architectural implications or patterns
- Assess complexity and effort (rough estimate)
- Note any assumptions or clarifications needed

**Architecture Pattern Discovery (MANDATORY FIRST STEP):**
- [ ] Use codebase_search to find existing similar implementations
- [ ] Document the established architectural pattern for this type of feature
- [ ] Identify where similar logic lives (which methods, which layers)
    
**Delegation Complexity Assessment:**
Based on the problem scope and architectural patterns discovered:
- **Implementation Complexity**: [Low/Medium/High] - How much architectural inference required?
- **Pattern Clarity**: [Clear/Moderate/Ambiguous] - Are existing patterns well-established and discoverable?
- **Context Scope**: [Narrow/Medium/Broad] - How many files/systems need coordination?
- **Debugging Likelihood**: [Low/Medium/High] - How much investigation vs. implementation?

**Preliminary Delegation Recommendation**: 
[High/Medium/Low feasibility for Haiku execution with detailed planning]

**Output:** Provide a terse and clear understanding of the problem and recommended high level alternative approaches. Keep it at a human readable length and level of detail.

Focus on the "what" and "why" at a high level - we'll do more detailed analysis and planning in later phases.

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