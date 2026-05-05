---
name: client-reporting-pdca
description: Guides weekly client status reporting for consulting engagements — pulls metrics
  from project tracker, billing system, and Jira, produces a reviewed and approved report
  with metrics, progress, and risks sections. Use this skill whenever working on client
  status reports, weekly reporting cycles, or any request to prepare or send a client
  update. Triggers on phrases like "client report", "weekly status", "prepare the update",
  "risks section", or "let's do the Friday report".
---

# Client Reporting PDCA Framework

A structured human-AI collaboration process for weekly client status reporting.
Cycle frequency: Weekly (target delivery: Friday before noon).

## How to Use This Skill

Work through phases in order. Each phase has a STOP condition before proceeding.

**PLAN** — Collect data from all three sources and confirm what this week's report needs.
See `references/phase-prompts.md` → PLAN phase.

**DO** — Draft the report with discipline. Account lead review gate is mandatory before finalizing.
See `references/phase-prompts.md` → DO phase.

**CHECK** — Verify all quality signals before sending anything to the client.
See `references/phase-prompts.md` → CHECK phase.

**ACT** — Retrospect and propose refinements to this skill.
See `references/phase-prompts.md` → ACT phase.
See `references/working-agreements.md` for current version and process discipline rules.

## STOP Triggers — Intervene Immediately

If any of these occur, stop the AI and restate the relevant phase prompt:

- AI drafts or sends anything directly to the client
- AI finalizes the risks section without presenting it to the human first
- AI skips data collection from any of the three required sources (project tracker, billing, Jira)
- AI softens language in the risks section without flagging it is doing so
- AI proposes to skip account lead review because "it looks good" or "it's late"

## Human Ownership — Non-Negotiable

The human owns these decisions. AI must not proceed past them without explicit approval:

- Assessing which risks to escalate vs. monitor (requires client relationship context not in documents)
- Framing negative news to the client
- Final approval of all content before it is sent to the client
- The risks section final content — cannot be finalized without human sign-off
- All communication sent to the client
