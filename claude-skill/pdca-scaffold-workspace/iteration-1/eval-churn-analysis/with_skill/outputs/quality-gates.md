# Quality Gates — Churn Analysis PDCA

## Definition of Done

A cycle is complete when all of the following are true:

1. Cohort data pulled fresh from the data warehouse this cycle — not carried forward from last month
2. Data quality check documented with no unexplained anomalies
3. Pattern list reviewed by human analyst before any interpretation was written
4. Every recommendation in the final report was authored by the human — none were AI-generated
5. No AI explanatory language appears anywhere in the final report
6. Leadership presentation reviewed and approved by the human analyst before delivery

## Common Failure Modes

- **AI interpretation in the report**: Detect by searching the final report for phrases like "this suggests", "likely indicates", "may be due to", "appears to be". Any of these are AI interpretation, not AI observation.
- **AI-authored recommendations**: Detect by tracing each recommendation back to a specific human annotation in the review session. If it has no human source, it's AI-generated.
- **Stale data**: Detect by checking the query execution timestamp — confirm it's from this month's cycle.
- **Skipped data quality check**: Detect by checking whether a data quality summary was created before analysis began.
- **Unseen pattern list**: Detect by confirming the human reviewed the pattern list before writing interpretations. If the human wrote interpretations without seeing the full pattern list, they may have missed something significant.

## Gate Escalation

If a quality gate cannot be passed:
1. Identify the specific failure
2. Return to DO phase — rerun the affected section
3. If AI interpretation has contaminated the final report, remove it entirely and
   have the human rewrite the affected sections from scratch
4. Never publish a report with AI-authored recommendations — the analyst's credibility
   is the asset being protected
