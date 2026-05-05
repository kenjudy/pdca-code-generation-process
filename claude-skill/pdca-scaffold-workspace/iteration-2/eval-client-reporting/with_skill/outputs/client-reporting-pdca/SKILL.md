---
name: client-reporting-pdca
description: Guides weekly client status report production for consulting firms with multiple
  active engagements. Applies structured analysis, disciplined execution, and quality
  verification under human supervision. Use this skill whenever working on client reporting
  tasks, weekly status cycles, or any request to produce, draft, or review a client status
  report. Triggers on phrases like "client report", "weekly status", "draft the report",
  "client update", or "let's work on client reporting".
---

# Client Reporting PDCA Framework

A structured human-AI collaboration process for producing weekly client status reports
across 8 active consulting engagements. Each cycle delivers a reviewed, approved, and
sent report containing current metrics, evidenced risks, and account lead recommendations.
Cycle frequency: Weekly (8 reports per cycle, due Friday by 5 PM).

## How to Use This Skill

Work through phases in order. Each phase has a STOP condition before proceeding.

**PLAN** — Confirm metrics sources, known risks and context from the account lead, and the
confirmed client contact before drafting anything.
See `references/phase-prompts.md` -> PLAN phase.

**DO** — Execute with discipline. Pull sourced data, draft sections, and pause at mandatory
human gates before any content involving risk escalation, resourcing, or the send decision.
See `references/phase-prompts.md` -> DO phase.

**CHECK** — Verify quality against the agreed criteria before declaring done. No report
is done until the account lead has explicitly approved it.
See `references/phase-prompts.md` -> CHECK phase.

**ACT** — Retrospect. Propose refinements to this skill. Human approves changes.
See `references/phase-prompts.md` -> ACT phase.
See `references/working-agreements.md` for the current version and process discipline rules.

## STOP Triggers — Intervene Immediately

If any of these occur, stop the AI and restate the relevant phase prompt:

- AI sends or schedules the report without explicit account lead approval
- AI lists a risk without citing a source (ticket number, date, or standup note)
- AI writes a recommendation involving resourcing, timeline, or budget without account lead input
- AI pulls metrics without first confirming the data source with the human
- AI addresses the report to a contact not explicitly confirmed by the account lead

## Human Ownership — Non-Negotiable

The human owns these decisions. AI must not proceed past them without explicit approval:

- Account lead narrative: interpreting relationship health and what to emphasize based on
  client context not captured in project tools
- Risk framing: deciding whether a risk is surfaced to the client or handled internally,
  based on contractual and political sensitivity
- Every recommendation — AI may draft, but the account lead must finalize the language
  and stand behind every recommendation
- Escalation language: whether a risk is "critical" vs. "watch item"
- Any recommendation involving resourcing, timeline, or budget (contractual implications)
- The send decision: explicit account lead approval required before the report goes to
  the client; this cannot be assumed or skipped
