# Phase Prompts — Client Reporting PDCA

---

## PLAN Phase

**Purpose:** Confirm the context for this cycle — metrics sources, known risks, client
contact, and any relationship context the account lead wants factored into the draft.
**Duration:** 15-20 minutes (approximately 15% of total cycle time)
**Done when:** The account lead has named the metrics sources for this week, identified
any known risks or context items the AI should factor in, confirmed the client contact
list, and the AI has a confirmed scope: which sections to draft, what data sources to pull
from, and any tone or emphasis guidance from the account lead.

### Steps

1. **Context gathering** — What is the current state of this engagement?
   Pull the following and present to the account lead for confirmation:
   - Last week's sent report (for comparison baseline)
   - Open and recently closed tickets from the project tracker (Jira, Notion, or equivalent)
   - Time tracking summary for the period (Harvest or equivalent)
   - Any standup notes or Slack threads flagged as relevant since last report

2. **Constraint identification** — What constraints apply to this cycle?
   Confirm with the account lead:
   - Is the Friday 5 PM deadline firm, or is there a client-specific variation this week?
   - Are there any topics the account lead wants to avoid or handle differently this week
     (e.g., a difficult conversation happening separately)?
   - Is there a personnel or resourcing change that affects what gets reported?

3. **Approach definition** — Given context and constraints, confirm the plan:
   State explicitly: which sections the AI will draft, which data sources will be pulled,
   what the account lead's role is at each gate, and who the confirmed recipient is.
   Example: "I will draft the metrics section from Harvest week 18 data, the status
   narrative from Jira closed tickets since April 28, and a risks draft from the three
   items flagged in last Friday's standup. You will review each section and finalize
   recommendations. The report goes to [contact name] at [client org]."

4. **Human review gate** — Present the confirmed approach to the account lead for
   explicit approval before executing.
   The account lead confirms or redirects. Do not proceed to DO without explicit approval.

> **STOP:** Do not begin drafting until the account lead has approved the approach,
> confirmed the data sources, and confirmed the recipient.

---

## DO Phase

**Purpose:** Execute the approved plan: pull sourced data, draft each section, and pause
at mandatory human gates before any content involving risk escalation, resourcing, or send.
**Duration:** 60-90 minutes (approximately 65% of total cycle time)
**Done when:** A complete draft exists matching the firm template. All metrics are
populated with sourced data. The risks section contains only evidenced items with citations.
The recommendations section has been written with explicit account lead input. The draft
is staged for the account lead's final review — it has not been sent.

### Before Starting

- [ ] PLAN phase approved by account lead
- [ ] Data sources confirmed (specific tool, specific date range, specific project)
- [ ] Client contact confirmed for this cycle
- [ ] Scope boundaries clear — know what is out of scope for this report

### Execution

1. **Pull and format metrics** — Retrieve data from the confirmed source for the confirmed
   period. Format into the metrics section of the firm template.
   Output: populated metrics table with source citations (tool name, date range, export date).

2. **Draft status narrative** — Using closed/resolved tickets and standup notes from the
   confirmed period, draft the "status since last week" section.
   Output: 2-4 paragraph narrative. Flag any place where context from the account lead is
   needed to complete a sentence or characterize progress accurately.

3. **Draft risks section** — From flagged items in the project log and the account lead's
   named risks from PLAN, draft the risks section.
   Rule: every risk must include a citation (ticket number, standup date, or document name).
   Do not include speculative or opinion-based risks. If a risk has no citation, mark it
   "[NEEDS SOURCE — do not include without account lead confirmation]" and stop.

4. **Draft recommendations** — Present candidate recommendation language to the account lead
   for each risk and status item that warrants a recommendation.
   Do not finalize recommendations without account lead input. Present options; the account
   lead chooses and refines.

5. **Assemble full draft** — Combine all sections into the firm template. Verify section
   order, header formatting, and tone match the template exactly.
   Output: complete draft document ready for account lead review.

### Mandatory Human Gates

Pause and present to the account lead at each of these points:

- GATE: Before including any risk in the draft, present the risks list to the account lead
  with citations. Account lead approves which risks are included, their framing (critical vs.
  watch item), and whether each is appropriate to surface to the client.
- GATE: Before finalizing any recommendation, present candidate language to the account lead.
  Account lead edits, approves, or rejects each recommendation. No recommendation goes
  into the final draft without explicit account lead sign-off.
- GATE: Before sending, present the complete assembled draft to the account lead for final
  review. Account lead provides explicit send approval. This gate cannot be skipped for any
  reason, including travel, time pressure, or prior approval of individual sections.

> **STOP:** If the AI skips a gate, lists a risk without a citation, drafts a recommendation
> involving resourcing or budget without human input, or addresses the report to an
> unconfirmed contact — stop immediately.
> Repost this prompt and restart the DO phase from the last completed checkpoint.

---

## CHECK Phase

**Purpose:** Verify quality against the agreed criteria before declaring done.
**Duration:** 15-20 minutes (approximately 15% of total cycle time)

### Verification Checklist

- [ ] Report has been sent to the confirmed client contact(s) before Friday 5 PM
- [ ] All metrics are present and sourced (no placeholders, no "TBD" fields)
- [ ] Every risk listed includes a cited source (ticket number, date, or standup note)
- [ ] Account lead has explicitly reviewed and approved the report (documented, not assumed)
- [ ] Report matches the firm's template exactly (header, section order, tone)

### Failure Mode Check

Confirm none of the common failure modes are present:

- [ ] Stale metrics (wrong sprint or wrong week) — not present; source and date range confirmed
- [ ] Unsourced risks (opinion-based flagging) — not present; every risk has a citation
- [ ] Skipped account lead review — not present; explicit approval is documented
- [ ] Vague recommendations ("we will monitor") — not present; each recommendation is specific
      and actionable
- [ ] Wrong contact list — not present; recipient confirmed in PLAN phase

### Process Audit

- [ ] Account lead owned every non-delegable decision (risk framing, recommendations, send)
- [ ] All mandatory gates were observed (risks gate, recommendations gate, send gate)
- [ ] Scope stayed within the approved plan — no sections added without account lead approval
- [ ] No risks were listed without citations

> If any check fails, return to DO phase. Do not declare done with known deficiencies.
> Do not reduce the quality bar to make the gate pass — fix the work instead.

---

## ACT Phase

**Purpose:** Retrospect on the cycle. Propose refinements to this skill. Human approves changes.
**Duration:** 10-15 minutes

### Retrospective

Address each area:

**Cycle overview:** Which engagement was this? What was the scope of this report? Was the
Friday deadline met comfortably, on time, or under pressure?

**Critical moments:** What 2-3 decisions or interventions most impacted quality or efficiency
this cycle? (Examples: a risk framing call, a recommendation that needed significant revision,
a data source that was hard to access.)

**Process insights:**
- What worked well and should be protected?
- What slowed progress or reduced quality?
- Where did process discipline slip (if it did)? Were any gates under pressure to skip?

**Data source friction:**
- Which data sources required extra effort to pull? Is there a way to pre-fetch or automate
  any of them before next cycle?

**Drafting quality:**
- Which sections required the most account lead revision? What drafting patterns caused rework?

**Client signal:**
- Did the client ask any follow-up questions that suggest a clarity failure in this report?

**Top 3 actionable insights:**
1. Start doing: [specific practice that would have improved this cycle]
2. Stop doing: [specific practice that created friction or risk]
3. Keep doing: [specific practice that worked well and must be protected]

### Skill Refinement (Mandatory)

After completing the retrospective, propose any changes to this skill's phase prompts,
working agreements, or quality gates that would improve the next cycle.

For each proposed change, state:
- Which file and section is affected
- What the current text says
- What the proposed replacement says
- Why this change improves the process

Present proposals to the account lead. Account lead approves or rejects each change.
Approved changes are committed to the skill files before the next cycle begins.

See `references/working-agreements.md` for the current version and refinement rules.
