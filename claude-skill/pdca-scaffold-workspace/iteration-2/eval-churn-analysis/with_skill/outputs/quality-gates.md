# Quality Gates — Churn Analysis PDCA

## Definition of Done

A cycle is complete when all of the following are true:

1. Churn rates have been computed and analyst-reviewed for all cohort dimensions confirmed in PLAN: plan tier, acquisition channel, tenure band, and geography. No confirmed dimension is missing from the rate table.

2. The presentation deck has been reviewed by the analyst and confirmed to contain no AI-generated causal claims. Every statement of "why" customers churned was written or explicitly approved by the analyst.

3. Leadership has received the deck and the analyst has conducted the readout and fielded questions. "Sent" is not sufficient — the readout must have occurred.

4. Every anomalous cohort flagged by AI during analysis has been either explained by the analyst (with their reasoning documented in the deck or notes) or explicitly marked as requiring further investigation in the next cycle.

5. The cycle retrospective is complete: cycle overview, critical moments, process insights, and any proposed skill refinements have been discussed and decisions documented.

## Common Failure Modes

Watch for these and treat them as quality failures requiring remediation:

- **AI causal language in deck sections.** Indicator: any sentence containing "because", "due to", "driven by", "the reason", or "this caused" in a section authored or drafted by AI. Check every data-description section before finalizing.

- **Cohort definition drift.** Indicator: the cohort dimensions or segmentation rules used this month differ from the prior month without an explicit analyst decision to change them. Check: confirm definitions were documented and signed off in the PLAN phase checklist.

- **Data dump without narrative.** Indicator: the deck contains rate tables and charts but the analyst has not written interpretive content explaining what the patterns mean for the business. The leadership readout cannot be conducted from data alone.

- **Retrospective skipped.** Indicator: the cycle is closed without a documented retrospective. The retrospective is not optional even when the readout runs long — schedule it separately if needed.

- **Prior-month baselines omitted.** Indicator: the delta table is missing or trend lines are absent because prior-month rates were not pulled. Any cycle without baseline comparison cannot identify trends.

## Gate Escalation

If a quality gate cannot be passed:

1. Identify the specific gap (which criterion is unmet and why)
2. Return to the appropriate DO phase step to address it
3. Do not reduce the quality bar to make the gate pass — fix the work instead
4. If the gap cannot be fixed within the current cycle (for example, leadership readout
   cannot be rescheduled), document it explicitly as a known gap and carry it as a
   process debt item into the next cycle's PLAN phase
