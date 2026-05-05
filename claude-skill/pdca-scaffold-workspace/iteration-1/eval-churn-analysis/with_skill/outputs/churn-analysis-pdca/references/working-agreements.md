# Working Agreements — Churn Analysis PDCA

**Version:** 1
**Last refined:** 2026-05-05
**Refinement history:** See git log for this file.

## Process Discipline

The interpretive boundary is the core discipline of this process. Data patterns are AI
territory. What those patterns mean for the business is human territory. Mixing these
— having the AI explain why churn happened — undermines the analysis and the credibility
of the recommendations. When this boundary slips, stop and reset.

### Human Owns (Non-Negotiable)

- Interpreting what any churn pattern means in business terms — the data shows what happened,
  the human explains why and whether it matters
- All recommendations to leadership — AI may format the final report, but every recommendation
  must be authored by the human, not inferred by the AI
- Deciding which patterns are significant vs. statistical noise — requires knowing the business
- Any narrative connecting data to external events (product launches, pricing changes,
  competitor moves, economic conditions)
- The tone and framing of the leadership presentation — the human's credibility is at stake

### AI Executes (With Review Gates)

- Writing and executing SQL queries to pull cohort data from the data warehouse
  (human reviews query logic before execution against production data)
- Cleaning and reshaping data into analysis-ready formats
- Building cohort tables and calculating churn rates by segment
- Surfacing statistically notable patterns — week-over-week, segment comparisons,
  trend inflections — presented as pure observations with no explanatory language
  (human reviews the pattern list before interpretation begins)
- Drafting the report structure and formatting human-authored content
  (human authors every recommendation and interpretation, AI formats only)
- Building charts and visualizations from the analysis results

### Intervention Triggers

When the AI does any of the following, stop immediately:

- STOP if AI writes any sentence explaining WHY a churn pattern occurred
  (e.g., "This likely indicates...", "Customers may be churning because...")
- STOP if AI drafts any recommendation without it being human-authored first
- STOP if AI presents pattern findings with evaluative language ("concerning", "positive",
  "alarming") rather than neutral observation language
- STOP if AI skips the data quality check and proceeds directly to analysis
- STOP if AI generalizes from a single cohort or segment to a company-wide conclusion
- STOP if AI suggests action items in the pattern-surfacing phase

### Process Debt to Watch For

- AI slipping into explanatory mode after being asked to "summarize the patterns"
- Human accepting AI pattern framing without annotating with their own interpretation
- Skipping the data quality check when the warehouse query "looks right"
- Using last month's analysis as the baseline without pulling fresh data

## Implementation Approach

- Understand scope before querying. Know which segments, cohorts, and time ranges
  before writing any SQL.
- Minimal scope. Answer this month's churn question. Don't expand to retention analysis
  "while we're at it."
- Hard separation of concerns. Pattern surfacing phase ends before interpretation begins.
  Never run both in the same session segment.
- Respond to feedback. If the human's interpretation contradicts the AI's framing,
  the human is correct — update the language.

## Definition of Done

A cycle is complete only when all of the following are true:

- [ ] Cohort data pulled fresh from the data warehouse this cycle (not cached from last month)
- [ ] Data quality check completed — no nulls, outliers, or schema anomalies unexplained
- [ ] Pattern list reviewed by human before any interpretation was written
- [ ] Every recommendation in the final report is human-authored
- [ ] Leadership presentation reviewed and approved by the human analyst before delivery
- [ ] No AI-generated explanations or recommendations in the final output
