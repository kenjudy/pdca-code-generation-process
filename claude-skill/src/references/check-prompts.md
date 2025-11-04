# CHECK Phase Prompts

## Completeness Check

**Purpose:** Verify all objectives met and process discipline maintained
**Duration:** 2-5 minutes
**Prerequisites:** All planned work completed, tests passing
**Next step:** Retrospection (4) for continuous improvement

Review work against original goal and plan:

```markdown
**Completeness Check**

Review our original goal outcome and plan against our execution.

**Verification:**
- [ ] All tests passing
- [ ] Manual testing completed (if needed)
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

**Add Results to Ticket.**

**Human's Commitment:** Take accountability for whether the code will achieve the intended outcome as best you understand it and meets your professional standard of quality. _This is your code._

**Note:** The author's current prompt is a 10-item checklist of 679 characters.

## Definition of Done

Define explicit completion criteria that include:
- Delivering the outputs defined in the analysis
- Meeting your personal and team quality standards
- All tests passing with no regressions
- Code follows established patterns and conventions
- Documentation is complete and accurate

This validation provides data for the retrospective phase.

## When to Run the Check

- After completing all planned steps
- Before committing code to version control
- When uncertain if work is truly complete
- Before moving to the next feature or task

The check phase prevents premature closure and ensures quality standards are met consistently.
