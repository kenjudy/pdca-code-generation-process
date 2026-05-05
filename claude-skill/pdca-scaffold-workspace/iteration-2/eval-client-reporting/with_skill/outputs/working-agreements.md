# Working Agreements — Client Reporting PDCA

**Version:** 1
**Last refined:** 2026-05-05
**Refinement history:** See git log for this file.

## Process Discipline

Process discipline trumps speed. When a violation is observed, stop and address it
before continuing.

### Human Owns (Non-Negotiable)

- Account lead narrative: interpreting the relationship health and what to emphasize
  given the client's mood and recent interactions not captured in project tools
- Risk framing: deciding whether a risk should be surfaced to the client now or handled
  internally, based on contractual and political sensitivity
- Every recommendation: AI may draft candidate language, but the account lead must
  finalize and own every recommendation that goes to the client
- Escalation language: the decision to call a risk "critical" vs. a "watch item" belongs
  to the account lead, not the AI
- Any recommendation involving resourcing, timeline, or budget: these have contractual
  implications and require explicit human authorship
- The send decision: the account lead must explicitly approve the report before it is
  sent; approval cannot be assumed, inferred, or skipped because the lead is traveling

### AI Executes (With Review Gates)

- Pulling current metrics from project tracking tools (Jira, Harvest, Notion) and
  formatting them into the report template; AI drafts, human confirms sources before pull
- Drafting the "status since last week" narrative from ticket activity and standup notes;
  human reviews before this section is finalized
- Drafting the risks section from flagged items in the project log (only evidenced items
  with citations); human reviews risk framing before the section is included
- Formatting the full report draft to match the firm's template; human reviews before send
- Generating a prior-week comparison summary for the account lead's review reference;
  human uses this as context, not as final content

### Intervention Triggers

When the AI does any of the following, stop immediately:

- Stop if AI sends or schedules the report without explicit account lead approval
- Stop if AI lists a risk without citing a source (ticket number, date, or standup note)
- Stop if AI writes a recommendation involving resourcing, timeline, or budget without
  explicit account lead input and approval
- Intervene when AI pulls metrics without first confirming the data source with the human
- Intervene when AI addresses the report to a contact not explicitly confirmed by the
  account lead for this cycle

### Process Debt to Watch For

These shortcuts tend to accumulate — flag them when they appear:

- Skipping the prior-week comparison ("we all know what changed") — leads to drift in
  risk tracking and missed escalations across weeks
- Using last week's metrics as a shortcut when the new data is "basically the same" —
  stale metrics erode client trust
- Skipping account lead review when the lead is traveling ("just send it, it's fine") —
  the single most common process failure; the send gate is non-negotiable
- Accumulating vague "watch item" risks that are never resolved or escalated — creates a
  false sense of control and misleads clients about engagement health

## Implementation Approach

- Understand context before executing. Gather enough information to know what "analysis done"
  looks like for this cycle before proceeding to execution. For client reporting this means:
  confirmed metrics sources, named risks and context from the account lead, and confirmed
  client contact — before drafting a single section.
- Minimal scope. The smallest action that moves the cycle forward. No scope expansion
  without explicit human approval.
- One phase at a time. Complete PLAN before DO. Complete DO before CHECK.
- Respond to feedback. If the draft approach isn't working, try a different approach rather
  than persisting with the same one.

## Definition of Done

A cycle is complete only when all of the following are true:

- [ ] Report has been sent to the confirmed client contact(s) before Friday 5 PM
- [ ] All metrics are present and sourced (no placeholders, no "TBD" fields)
- [ ] Every risk listed includes a cited source (ticket number, date, or standup note) —
      no speculative or opinion-based risks remain
- [ ] Account lead has explicitly reviewed and approved the report (not assumed)
- [ ] Report matches the firm's template exactly (header, section order, tone)
