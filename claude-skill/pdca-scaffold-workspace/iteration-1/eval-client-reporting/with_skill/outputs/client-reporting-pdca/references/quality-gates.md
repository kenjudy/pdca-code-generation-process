# Quality Gates — Client Reporting PDCA

## Definition of Done

A cycle is complete when all of the following are true:

1. All three data sources (project tracker, billing system, Jira) were checked and no
   metrics contain gaps, placeholders, or unresolved anomalies
2. The risks section contains at least one risk with specific supporting evidence
   (a metric, a ticket, or an observed issue) — not empty, not boilerplate
3. The account lead reviewed and approved the full draft in writing before sending
4. The report was sent to the client before Friday noon
5. Client acknowledgment received or delivery confirmed (read receipt or response)

## Common Failure Modes

- **Empty or vague risks section**: Detect by checking whether each risk has a specific
  evidence citation. "Project timeline risk" with no supporting data is a failure.
- **Account lead review skipped**: Detect by checking for written approval in the record.
  Verbal "it's fine" or "just send it" does not count.
- **Metrics gaps**: Detect by confirming all three sources were queried this cycle,
  not carried forward from last week.
- **Risks softened**: Detect by comparing final risks section to the draft risks list
  approved in PLAN. Any weakened language must have explicit account lead authorization.
- **Late delivery**: Report sent after Friday noon. Track and note in ACT.

## Gate Escalation

If a quality gate cannot be passed:
1. Identify the specific gap
2. Return to DO phase to address it — do not send with a known gap
3. If Friday noon has passed, notify the account lead and client simultaneously rather
   than sending a compromised report on time
4. Do not reduce the quality bar to make the gate pass — fix the work instead
