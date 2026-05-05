# Working Agreements — Client Reporting PDCA

**Version:** 1
**Last refined:** 2026-05-05
**Refinement history:** See git log for this file.

## Process Discipline

Process discipline trumps speed. The review step getting rushed is the primary failure mode
this process exists to prevent. When a discipline violation is observed, stop and address it
before continuing.

### Human Owns (Non-Negotiable)

- Assessing which risks to escalate vs. monitor — this requires knowing what the client is
  sensitive to, the relationship history, and the firm's accountability position
- Deciding how to frame negative news — tone and framing have relationship implications
- Final approval of anything sent to the client — once sent, it is the firm's official position
- The risks section final content — underselling risks has legal and relationship implications;
  AI may draft a first-pass list, but the human must review and approve every risk before
  it appears in the sent report
- All client communication — AI must never send or address anything to the client directly

### AI Executes (With Review Gates)

- Pulling and formatting metrics from project tracker, billing system, and Jira
  (human reviews data completeness before drafting begins)
- Drafting the metrics and progress sections
- Drafting a first-pass risks list from known project issues
  (human reviews this list before it becomes the risks section)
- Formatting the full report structure and layout
- Spotting data anomalies and flagging them with a note — not resolving them silently

### Intervention Triggers

When the AI does any of the following, stop immediately:

- STOP if AI finalizes or presents the risks section as complete without human review
- STOP if AI proposes to skip or abbreviate the account lead review step
- STOP if AI skips data collection from any of the three required sources
- STOP if AI softens risk language without flagging the change
- STOP if AI addresses or prepares content for direct client delivery without approval
- STOP if AI fills in missing data with estimates or last week's numbers without flagging it

### Process Debt to Watch For

These shortcuts tend to accumulate — flag them when they appear:

- Skipping the mid-week account lead risk preview and reviewing a full draft late Friday instead
- Reusing last week's risks section without updating it for this week's developments
- Abbreviating data collection when one system is slow ("I'll just use last week's billing numbers")
- Treating "account lead didn't object" as approval rather than explicit sign-off

## Implementation Approach

- Understand context before executing. Know which client, which week, and what's changed
  before touching any system.
- Minimal scope. Draft only what was planned. No adding new sections "while we're at it."
- One phase at a time. Do not draft report sections while still collecting data.
- Respond to feedback. If the account lead changes the risks framing, update it — do not
  rationalize the original.

## Definition of Done

A cycle is complete only when all of the following are true:

- [ ] All three data sources checked — no missing metrics or placeholder values
- [ ] Risks section contains at least one risk with specific evidence (not empty, not vague)
- [ ] Account lead has reviewed and approved in writing (not just verbally)
- [ ] Report sent before Friday noon
- [ ] Client acknowledgment received or delivery confirmed
