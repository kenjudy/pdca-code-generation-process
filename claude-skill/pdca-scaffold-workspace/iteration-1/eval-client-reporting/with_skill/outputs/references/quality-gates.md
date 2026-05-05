# Quality Gates: Client Status Reporting

Four mandatory gates govern every reporting cycle. No gate can be skipped.
Each gate has explicit pass criteria. A gate is passed only when the human says so explicitly.

---

## Gate 1 — Anomaly Review (Tuesday PM)

**Purpose:** Ensure all data discrepancies are understood and resolved before drafting begins.
A report built on unreviewed anomalies will have wrong numbers.

**Pass criteria (all must be true):**
- [ ] All three data source exports were successfully parsed (no empty exports)
- [ ] Every flagged anomaly has been reviewed by the human
- [ ] Human has accepted or overridden each AI interpretation
- [ ] No data source shows >10% discrepancy with another source unless human has explicitly
      accepted that discrepancy with a stated reason
- [ ] Human has said "cleared to draft" or equivalent

**Fail conditions (any one blocks the gate):**
- Any data export is empty or missing
- A >10% discrepancy exists that the human has not reviewed
- The billable hours vs. sprint velocity ratio cannot be computed (missing baseline)

**If gate fails:** Do not begin drafting. Document the blocker. If a data source is
unavailable, attempt to re-pull. If still unavailable after one retry, escalate to
account lead before proceeding.

---

## Gate 2 — Draft Approval (Wednesday AM)

**Purpose:** Human reviews the complete draft before it goes to Sarah. Sarah should never
see a draft the engagement manager hasn't read and approved.

**Pass criteria (all must be true):**
- [ ] Metrics table is complete and every number traces to a named source system
- [ ] Risks section has at least one entry (zero risks blocks this gate)
- [ ] Every risk entry has all four fields: description, severity, mitigation, owner
- [ ] Every High-severity risk has been explicitly confirmed by the human
- [ ] Executive summary is 3-4 sentences with no acronyms and no sprint jargon
- [ ] Human has read the full draft and said "approved for Sarah" or equivalent

**Fail conditions (any one blocks the gate):**
- Risks section is empty
- Any risk is missing any of the four required fields
- Executive summary contains an acronym or sprint/engineering term
- Metrics table has a number without a traceable source

**If gate fails:** Return to DO phase, fix the specific gap, re-present for Gate 2.

---

## Gate 3 — Review Incorporation (Thursday PM)

**Purpose:** Confirm Sarah's feedback has been incorporated and the report is truly final
before Gate 4 approval.

**Pass criteria (all must be true):**
- [ ] Sarah's review comments have been received (if not: see Thursday escalation rule)
- [ ] Every comment from Sarah has been addressed (accepted edit, rejected with reason,
      or flagged as factually incorrect against source data)
- [ ] All four risk fields are still populated after edits (edits sometimes strip fields)
- [ ] Executive summary still passes plain-English check after edits
- [ ] Human has read the revised final draft and said "final — ready for Gate 4" or equivalent

**Thursday 3pm escalation rule:** If Sarah has not responded by Thursday 3pm, do not
send a follow-up email. Call her. Document the time of escalation in the cycle log.

**Fail conditions (any one blocks the gate):**
- Sarah has not been reached and it is Friday morning (report cannot be sent without her review)
- Any risk entry lost a required field during the edit process
- A comment from Sarah was not addressed (no edit, no rejection reason)

**If gate fails:** Do not proceed to Gate 4. Resolve the specific gap.

---

## Gate 4 — Final Client Delivery (Friday 10am)

**Purpose:** Last human check before anything goes to the client. No exceptions.

**Pass criteria (all must be true):**
- [ ] Gates 1, 2, and 3 are all confirmed passed
- [ ] Report formatting is consistent with prior reports (same template, no stray formatting)
- [ ] Client delivery email draft has been reviewed by human
- [ ] Human has given explicit approval: "send it" or equivalent
- [ ] Send time will be before Friday noon

**Fail conditions (any one blocks the gate):**
- Any prior gate was not formally passed
- It is Friday noon and Gate 4 has not been passed (this is a late delivery — document it)
- Human has not given explicit approval

**If gate fails / late delivery:** Send as soon as Gate 4 passes. Document in cycle log
that delivery was late and identify which gate caused the delay.

---

## Cycle Retrospective Log Format

After each cycle, append a retro entry to `cycle-log.md` in this format:

```
## Week of [start date] — [end date]

Client: [client name]
Delivered: [Friday date and time]
On time: Yes / No (if No: gate that caused delay: ___)

Risk rewrites after Sarah's review: [0 / 1 / 2 / 3+]
  If 2+: risk types that needed rewriting: ___

Discrepancies: Caught all / Missed N (describe any missed)

Client reaction: [one word or phrase]

Refinement flag: Yes / No
  If Yes: proposed change: ___
```

**Refinement triggers:**
- Risk rewrites >= 2 for two consecutive cycles: propose a change to the risks section
  prompt in `phase-prompts.md` (specifically the severity classification guidance)
- Same gate caused a late delivery two consecutive cycles: propose a change to the
  working agreement timing rules or that gate's criteria
- Client reaction is Negative two consecutive cycles: escalate to account lead for
  a process review conversation before the next cycle

---

## Minimum Viable Report (Emergency Only)

If time is critically short, the minimum viable report contains:
1. Accurate metrics table (all three sources, all numbers traced)
2. Risks section with at least 3 entries, all four fields populated for each
3. Executive summary (3-4 sentences, plain English)

Everything else (accomplishments, milestones) is secondary. Do not omit the risks section
or the exec summary even under time pressure. Document the emergency in the cycle log.
