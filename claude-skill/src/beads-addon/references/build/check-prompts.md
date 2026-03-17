# Check Phase: Implementation Verification & Quality Audit

**Purpose:** Verify all objectives met and process discipline maintained
**When to use:** After completing all planned implementation steps
**Prerequisites:** All planned work completed, tests passing
**Expected output:** Verification checklist, process audit results, outstanding items list
**Typical duration:** 2-5 minutes
**Next step:** Retrospection (4) for continuous improvement

---
```
**Completeness Check**

Review our original goal outcome and plan against our execution.

**Verification:**
- [ ] All tests passing
- [ ] Manual smoke test completed successfully 
- [ ] Documentation updated
- [ ] No regressions introduced
- [ ] No TODO implementations remaining created by this test driving

**Process Audit:**
- [ ] Testing approach was followed consistently
- [ ] TDD discipline maintained (if chosen)
- [ ] Test coverage is adequate and appropriate
- [ ] No untested implementation was committed
- [ ] Simple test scenarios were effective


**Status:** [Complete/Needs work]
**Outstanding items:** [any remaining tasks]
**Ready to close:** [Yes/No with reasoning]

```

Add Results to Ticket.


---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution. 

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

---
*2025*---

# Beads Integration (Optional)

**If beads is configured**, validate completeness against your beads task graph:

## Review All Planned Tasks

```bash
# List all subtasks for this epic
bd list --parent [epic-id]

# Check for incomplete work
bd list --parent [epic-id] --status open,in_progress

# Review epic with full context
bd show [epic-id]
```

## Verification Checklist

**Compare beads tasks against your original plan:**

- [ ] All planned subtasks are closed
- [ ] No tasks marked `in_progress` (finish or create follow-up)
- [ ] Commit hashes documented in task messages
- [ ] Any discovered blockers have follow-up tasks created

**If discrepancies found:**
- Open tasks that weren't in original plan? → Reassess scope
- Planned tasks not in beads? → Create them or document why skipped
- In-progress tasks? → Complete or explicitly defer with reason

**Why use beads in CHECK phase:**
- Objective completeness verification (task graph vs. subjective memory)
- Ensures no half-finished work left behind
- Documents any scope changes discovered during implementation

---

**If CHECK passes**, proceed to ACT phase for retrospection.

**If CHECK fails**, return to DO phase to complete remaining work.
