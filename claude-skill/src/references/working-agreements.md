# Working Agreements

Commitments human operators hold themselves accountable to when interacting with coding agents.

## Process Discipline & Intervention

**USE TDD FOR CHANGES.** Interrupt immediately with direct questions when observing process violations:
- "You broke from test-driving. Is there adequate test coverage?"
- "Where's the failing test first?"
- "You're fixing multiple things. Focus on one failing test?"
- "This feels like scope creep. Are we still on step [N]?"

**The agent must:** Stop and answer the process question before continuing. Process discipline trumps immediate progress.

## Implementation Guidelines

1. **PRIORITIZE MINIMAL CHANGES:** Smallest possible change addressing the specific issue. Specialized edge case handling over core method modification.

2. **INCREMENTAL APPROACH:** One focused change at a time. One failing test at a time, no exceptions.

3. **RESPECT EXISTING ARCHITECTURE:** Work within established patterns. No dramatic approach changes unless requested.

4. **VERIFY TEST EXPECTATIONS:** Examine test cases first to understand expected behavior. No assumptions about requirements.

5. **UNDERSTAND BEFORE CHANGING:** Read enough codebase to understand component interactions before modifications.

6. **BE CAUTIOUS WITH CORE METHODS:** Methods called from many places have multiple behavioral expectations.

7. **CONSIDER SIDE EFFECTS:** How changes affect other codebase parts and test cases.

8. **RESPOND TO FEEDBACK:** If changes break tests, try different approach rather than fixing the fix.

9. **EXPLAIN RATIONALE:** Clear explanations for approach choices and trade-offs considered.

10. **USE CLEAR TERMINOLOGY:** Precise technical language matching the domain.

**Solutions should be terse, precise, and focused on addressing exactly what's needed without over-engineering.**

## Example Working Agreements (Customize These)

```markdown
- I commit to enforcing "One focused change at a time. One failing test at a time, no exceptions." I will stop the AI when I observe it attempting to fix multiple things simultaneously or making changes that go beyond the current failing test.
 
- I commit to "Respect existing architecture: Work within established patterns. No dramatic approach changes unless requested." I will interrupt when the AI proposes solutions that diverge from established codebase patterns without explicit justification and approval.

- I commit to "Explicitly establish: methodology, scope boundaries, and intervention rights before coding begins." I will not allow any implementation to start until we have agreed on the testing approach, defined the scope of work, and confirmed my authority to interrupt process violations.
```
