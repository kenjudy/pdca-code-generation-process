# Phase Prompts — Client Reporting PDCA

---

## PLAN Phase

**Purpose:** Collect data from all three sources and define this week's report approach.
**Duration:** 30-45 minutes (Tuesday or Wednesday)
**Done when:** Data collected from all three systems, draft risks list exists, account lead
  alerted to any significant issues requiring early discussion before Friday

### Steps

1. **Data collection** — Pull this week's metrics from all three sources:
   - Project tracker: milestone status, hours burned vs. planned, open blockers
   - Billing system: hours billed this week, cumulative vs. contract, any anomalies
   - Jira: ticket velocity, open issues by severity, items closed vs. opened
   Flag any missing data, anomalies, or significant week-over-week changes immediately.
   Do not proceed to drafting if any source is unavailable — flag and resolve first.

2. **Risks identification** — From the collected data, draft a first-pass risks list:
   - Each risk must have specific evidence (metric, ticket, observation)
   - Include risks even if they are uncomfortable to raise
   - Do not soften risk language in this pass — that is the human's decision

3. **Constraint check** — What constraints apply to this report?
   - Is there anything the client is particularly sensitive to this week?
   - Are there internal firm concerns the account lead needs to know before the draft?
   - Is the Friday noon deadline achievable, or does something need to move?

4. **Human review gate** — Present the data summary and risks list to the account lead
   before drafting the full report.
   The account lead confirms: (a) data looks complete, (b) risks list is complete and
   accurately calibrated, (c) any framing guidance before drafting begins.

> **STOP:** Do not begin drafting the full report until the account lead has reviewed
> the data summary and risks list. This gate prevents the rushed-review failure mode.

---

## DO Phase

**Purpose:** Draft the full report with discipline. Account lead review is mandatory.
**Duration:** 2-3 hours (Thursday)
**Done when:** Full draft written and account lead has reviewed and approved in writing

### Before Starting

- [ ] PLAN phase approved — data complete, risks list reviewed by account lead
- [ ] Account lead framing guidance incorporated
- [ ] Friday noon delivery deadline confirmed achievable

### Execution

1. **Draft metrics section** — Use collected data. Format consistently with prior reports.
   Flag any metric that changed significantly week-over-week with a brief note.

2. **Draft progress section** — Summarize milestone status and key accomplishments.
   Be specific — avoid "good progress this week" without supporting detail.

3. **Draft risks section** — Use the account-lead-reviewed risks list as the foundation.
   Each risk must include: description, evidence, current mitigation, owner.
   Do not add new risks or remove existing ones without human approval.

4. **Draft recommendations (if applicable)** — Only include if account lead requested them.
   Each recommendation must tie to a specific risk or metric — no unsupported suggestions.

5. **Self-review pass** — Read the full draft and flag anything that:
   - Requires context about the client relationship not available in the data
   - Contains softer language than the risks list warranted
   - Makes assumptions about client preferences

### Mandatory Human Gates

- GATE: Before the risks section is finalized, present it to the human.
  Account lead reviews risk language, calibration, and framing. No report proceeds
  past this gate without explicit written approval of the risks section.

- GATE: Before the report is sent to the client, present the complete draft.
  Human reads and approves. No exceptions, even if it is Friday at 11:58am.

> **STOP:** If the AI skips either gate, produces a version addressed to the client,
> or proposes sending because "time is short" — stop immediately.
> Repost this prompt and restart from the last approved checkpoint.

---

## CHECK Phase

**Purpose:** Verify all quality signals before the report leaves the firm.
**Duration:** 15-20 minutes (Friday morning)

### Verification Checklist

- [ ] All three data sources checked — no missing metrics or placeholder values
- [ ] Risks section contains at least one risk with specific evidence (not empty or vague)
- [ ] Account lead has reviewed and approved in writing (written, not verbal)
- [ ] Report is addressed correctly and formatted consistently with prior reports
- [ ] No assumptions about the client made without evidence

### Failure Mode Check

- [ ] Risks section is not empty or reduced to boilerplate — not present
- [ ] Account lead review was not skipped or abbreviated — not present
- [ ] No metrics gaps or placeholders remain — not present
- [ ] Risks language has not been softened from what the account lead approved — not present
- [ ] Report was not drafted without first reviewing the data — not present

### Process Audit

- [ ] Human owned every non-delegable decision this cycle
- [ ] Both mandatory gates were observed (data/risks review, final approval)
- [ ] Scope stayed within what the account lead approved in PLAN

> If any check fails, return to DO phase. Do not send with known deficiencies.

---

## ACT Phase

**Purpose:** Retrospect on the cycle. Propose refinements to this skill. Human approves changes.
**Duration:** 10 minutes (Friday after sending)

### Retrospective

**Cycle overview:** Which client? What was the main story this week?

**Critical moments:** What 2-3 decisions or interventions most impacted quality or efficiency?
(e.g., a risk that needed reframing, a data gap that surfaced late, a framing choice)

**Process insights:**
- What worked well and should be protected?
- What slowed progress or reduced quality?
- Did any discipline shortcuts occur? Which gates came closest to being skipped?

**Top 3 actionable insights:**
1. Start doing: [specific practice for next cycle]
2. Stop doing: [specific shortcut to eliminate]
3. Keep doing: [what to protect]

### Skill Refinement (Mandatory)

After completing the retrospective, review `references/working-agreements.md` and propose
any specific updates. See `references/refinement-protocol.md` if present from the scaffold.

Key questions: Did any risk get changed significantly in the account lead review?
(That's a signal the AI's first-pass calibration needs refinement.) Did any gate get skipped?
(That's a signal the trigger language needs strengthening.)
