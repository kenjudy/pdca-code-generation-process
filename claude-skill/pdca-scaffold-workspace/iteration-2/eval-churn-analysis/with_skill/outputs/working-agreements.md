# Working Agreements — Churn Analysis PDCA

**Version:** 1
**Last refined:** 2026-05-05
**Refinement history:** See git log for this file.

## Process Discipline

Process discipline trumps speed. When a violation is observed, stop and address it
before continuing.

### Human Owns (Non-Negotiable)

- **Causal attribution.** Any statement of why customers churned belongs to the analyst.
  AI surfaces what happened in the data; the analyst decides what it means.
- **Signal vs. noise decisions.** Which patterns are meaningful given business context
  AI does not have — product changes, sales initiatives, competitive events — is the
  analyst's call.
- **Leadership narrative framing.** What the churn data means for business strategy,
  how to present the month's findings, which story the data tells.
- **Recommendations and action priorities.** Which cohorts to focus on, what retention
  interventions to pursue, how to sequence responses.
- **Final presentation sign-off.** The analyst must review and approve the deck before
  it is sent to leadership. Once sent, the interpretation is on the record.
- **Cohort definition confirmation.** Before AI computes any rates, the analyst must
  confirm the segmentation spec for this cycle. Definitions do not carry over automatically
  from prior months.

### AI Executes (With Review Gates)

- Pulls cohort breakdowns from query outputs provided by the analyst; AI does not
  run warehouse queries directly. Review gate: analyst confirms query outputs before AI
  processes them.
- Computes churn rates by cohort dimension (plan tier, acquisition channel, tenure band,
  geography). Review gate: analyst reviews rate table before deck work begins.
- Identifies statistical outliers and anomalies in cohort data and flags them for analyst
  attention. AI does not interpret the outliers — it only surfaces them.
- Generates summary tables and data visualizations. Review gate: analyst confirms
  visualizations accurately represent the data before embedding in deck.
- Drafts data-description sections of the slide deck (what the numbers show, not why).
  Review gate: analyst reads every section for causal language before the deck is finalized.
- Cross-references current month against prior months to surface trend lines. Review gate:
  analyst confirms prior-month baselines are the correct comparison set.

### Intervention Triggers

When the AI does any of the following, stop immediately:

- Stop if AI includes causal language in any output ("because", "due to", "driven by",
  "the reason", "this caused") when describing why customers churned.
- Intervene when AI proceeds to deck drafting without explicit analyst confirmation that
  the pattern review phase is complete.
- Stop if AI redefines cohort boundaries, adds a new segmentation dimension, or changes
  the comparison period without the analyst's explicit instruction.
- Intervene when AI generates a recommendation or action-priority slide without analyst
  authorship or approval.
- Stop if AI writes a "key takeaway", "headline finding", or "executive summary" framing
  without the analyst providing the interpretive content first.

### Process Debt to Watch For

These shortcuts tend to accumulate — flag them when they appear:

- Cohort definitions assumed to be the same as last month without analyst confirmation.
- Retrospective skipped because the leadership readout ran long.
- The causal-language review treated as optional after a few clean cycles.
- Prior-month baseline pulls omitted when time is tight, breaking trend continuity.

## Implementation Approach

- Understand context before executing. Confirm cohort definitions and query outputs
  before computing anything. Know what "analysis done" looks like for this cycle
  before beginning deck work.
- Minimal scope. Compute and present only the cohort dimensions confirmed in PLAN.
  No additional segmentation without explicit analyst approval.
- One phase at a time. Complete PLAN before DO. Complete DO before CHECK.
- Respond to feedback. If a pattern summary is unclear or a visualization is misleading,
  revise it before continuing.

## Definition of Done

A cycle is complete only when all of the following are true:

- [ ] Churn rates computed and analyst-reviewed for all confirmed cohort dimensions (plan tier, acquisition channel, tenure band, geography)
- [ ] Presentation deck reviewed by analyst and confirmed to contain no AI-generated causal claims
- [ ] Leadership has received the deck and the analyst has conducted the readout
- [ ] Any anomalous cohorts flagged by AI have been either explained by the analyst or noted as requiring further investigation
- [ ] Cycle retrospective is complete and any process changes are documented
