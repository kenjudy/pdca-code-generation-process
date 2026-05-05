# Phase Prompts: Client Status Reporting

Use these prompts in sequence. Do not skip phases. Each phase ends with a gate;
the AI waits for explicit human confirmation before advancing.

---

## PLAN Phase — Data Collection and Anomaly Review

**When:** Tuesday AM, before any drafting begins

**Human provides:**
- TargetProcess export (CSV): velocity, open bugs, milestone status
- BillQuick export (CSV): billable hours by role for prior week
- Jira ticket list (CSV or paste): completed, blocked, and newly opened items
- Any contextual notes: exceptions, client conversations, scope changes, known anomalies

**Prompt to AI:**

```
You are preparing this week's client status report. The human has provided raw exports
from TargetProcess, BillQuick, and Jira, plus contextual notes.

Step 1 — Parse and structure each data source into a clean table.
Step 2 — Compute the billable hours vs. sprint velocity ratio and compare it to the
  prior-week baseline (if provided). Flag if the ratio differs by more than 10%.
Step 3 — Cross-reference all three sources. Identify any discrepancies:
  - Hours logged vs. sprint points completed (are they proportionate?)
  - Jira blocked tickets vs. risks mentioned in prior report
  - Milestone dates in TargetProcess vs. Jira roadmap items
Step 4 — Produce an anomaly report: list every discrepancy, flag severity
  (>10% = High, 5-10% = Medium, <5% = Low), and state your recommended interpretation.
Step 5 — STOP. Present the anomaly report to the human for review.
  Do not begin drafting until the human has reviewed and cleared all anomalies.

Gate 1 trigger: Present anomaly report and wait for human sign-off.
```

**Gate 1 criteria:** Human reviews every flagged anomaly, accepts or overrides AI interpretation,
and explicitly says "cleared to draft" or equivalent.

---

## DO Phase — Report Drafting

**When:** Tuesday PM, after Gate 1 is passed

**Human provides:**
- Gate 1 sign-off (anomalies cleared)
- Any additional narrative context for bad-news sections
- Names for risk owners (AI generates candidates, human confirms)

**Prompt to AI:**

```
Gate 1 has been passed. Begin drafting the weekly status report.

Draft in this order:

1. METRICS TABLE
   Use the structured data from PLAN phase. Include: sprint velocity, open bug count,
   milestone status (On Track / At Risk / Off Track), and billable hours by role.
   Every number must trace back to a source system — note the source next to each metric.

2. RISKS SECTION
   For every risk identified (from Jira blocked items, anomalies flagged in PLAN,
   and any human-provided context), generate a risk entry with all four required fields:
     - Description: one clear sentence describing the risk
     - Severity: High / Medium / Low (with one-sentence rationale)
     - Mitigation action: specific action being taken, by whom, by when
     - Owner: named individual or role
   If a risk is classified High: present it separately and wait for human confirmation
   before including it in the draft.
   If the risks list is empty: STOP and flag this as an anomaly — do not proceed.

3. ACCOMPLISHMENTS
   List completed Jira tickets grouped by theme. Use plain English names, not ticket IDs.
   Maximum 5-6 bullet points.

4. UPCOMING MILESTONES
   List next 2-3 milestones from Jira roadmap with dates and status.

5. EXECUTIVE SUMMARY
   Write 3-4 sentences. Rules: no acronyms, no sprint jargon, no ticket IDs.
   Include: overall status, biggest accomplishment, most important risk, next milestone.
   Readable by a VP with no engineering background.

Gate 2 trigger: Present the complete draft and wait for human approval before
sending to the account lead.
```

**Gate 2 criteria:** Human has read the full draft, confirmed all High risks, edited
tone and narrative as needed, and explicitly says "approved for Sarah" or equivalent.

---

## CHECK Phase — Account Lead Review Loop

**When:** Wednesday AM (send to Sarah) through Thursday PM (feedback incorporated)

**Human provides:**
- Gate 2 sign-off
- Sarah's email address (or confirmation to use the standard address)
- Sarah's review comments when they arrive

**Prompt to AI — Review Request Email:**

```
Draft the review-request email to Sarah (account lead).

Include:
- Subject: [Client Name] Status Report — Review Requested by [Date, Thursday EOD]
- Opening: brief context (this is the weekly report for the week of [dates])
- Body: the full report as an attachment reference, plus an inline summary of:
    - Overall status (one line)
    - High-severity risks (bulleted list, these need Sarah's eye)
    - Deadline: "Please return comments by Thursday 3pm so we have time to finalize"
- Closing: note that if she has questions, call is preferred over email for anything complex

Human sends this email. AI does not send.
Gate 2.5: Human confirms the email has been sent and records the send time.
```

**Prompt to AI — Incorporate Review Comments:**

```
Sarah has returned her review comments. The human has provided them below.

Step 1 — List every comment Sarah made.
Step 2 — For each comment, propose a specific edit to the draft.
Step 3 — Flag any comment that conflicts with a factual data point from the source systems
  (e.g., Sarah says a metric is wrong — check against the PLAN phase data).
Step 4 — Present the proposed edits for human approval before making them.
Step 5 — Apply approved edits and produce the revised final draft.

Gate 3 trigger: Present the revised final draft and wait for human confirmation
that Sarah's review is fully incorporated.
```

**Gate 3 criteria:** Human has reviewed the revised draft, confirmed every risk still
has all four fields populated, confirmed exec summary is still jargon-free, and explicitly
says "final — ready for Gate 4" or equivalent.

**Thursday 3pm escalation rule:** If Sarah has not responded by Thursday 3pm, the AI
surfaces this and recommends calling her. Do not send a follow-up email.

---

## ACT Phase — Final Delivery and Retrospective

**When:** Friday, before 10am (approval) and before noon (send)

**Human provides:**
- Gate 3 sign-off (final draft confirmed)
- Explicit Gate 4 approval to send

**Prompt to AI — Client Delivery:**

```
Gate 3 has been passed. Prepare the final client delivery.

Step 1 — Format the final report for delivery (confirm formatting is consistent with
  prior reports: fonts, table layout, header/footer if applicable).
Step 2 — Draft the client delivery email:
  - Subject: [Client Name] Weekly Status Report — Week of [dates]
  - Opening: one sentence context
  - Body: 2-3 sentence summary of overall status and key highlight
  - Attachment reference
  - Closing: offer to discuss on the standing weekly call

Gate 4 trigger: Present the formatted report and draft email. Wait for human
explicit approval before anything goes to the client.

Human sends. AI does not send.
```

**Prompt to AI — Cycle Retrospective:**

```
The report has been sent. Run the cycle retrospective.

Collect answers to these four questions (human provides answers; AI records and summarizes):

1. Risk rewrites: How many risks in the final report required substantive rewrites
   after Sarah's review? (Count: 0, 1, 2, 3+)
   If 2 or more: note which risk types needed rewriting — this signals AI calibration drift.

2. Discrepancy catch rate: Did AI catch all data discrepancies, or did the human find
   any that AI missed? (Caught all / Missed N)

3. Delivery timing: Was the report sent before Friday noon? If not, which gate was the
   bottleneck? (Gate 1 / 2 / 3 / 4 / Sarah response time)

4. Client reaction: One word or phrase describing client's response if known.
   (Positive / Neutral / Negative / No response yet)

Record the retro in the cycle log alongside this week's report.

Refinement trigger: If risk rewrites >= 2 for two consecutive cycles, or if the same
gate caused a late delivery two consecutive cycles, propose a specific change to the
relevant phase prompt or working agreement.
```
