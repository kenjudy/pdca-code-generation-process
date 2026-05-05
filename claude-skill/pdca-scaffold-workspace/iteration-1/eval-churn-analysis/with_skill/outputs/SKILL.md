---
name: churn-analysis-pdca
description: Guides monthly SaaS customer churn analysis — AI handles data wrangling,
  SQL execution, and pattern surfacing; human owns interpretation of patterns and all
  recommendations to leadership. Use this skill whenever working on churn analysis,
  cohort analysis, retention reporting, or any monthly data analysis cycle that produces
  leadership-facing recommendations. Triggers on phrases like "churn analysis", "monthly
  retention report", "cohort data", "churn report for leadership", or "let's do the
  monthly analysis".
---

# Churn Analysis PDCA Framework

A structured human-AI collaboration process for monthly SaaS customer churn analysis.
Cycle frequency: Monthly (one full analysis cycle per calendar month).

## How to Use This Skill

Work through phases in order. Each phase has a STOP condition before proceeding.

**PLAN** — Define the analysis scope and confirm data sources before touching any data.
See `references/phase-prompts.md` → PLAN phase.

**DO** — AI runs data wrangling and surfaces patterns. Human writes interpretation and recommendations.
See `references/phase-prompts.md` → DO phase.

**CHECK** — Verify analysis integrity and recommendation quality before the leadership presentation.
See `references/phase-prompts.md` → CHECK phase.

**ACT** — Retrospect and propose refinements to this skill.
See `references/phase-prompts.md` → ACT phase.
See `references/working-agreements.md` for current version and process discipline rules.

## STOP Triggers — Intervene Immediately

- AI writes or implies any explanation for why a churn pattern exists
- AI drafts recommendations or action items without human-provided interpretation
- AI presents pattern findings as conclusions rather than observations
- AI skips the data quality check and proceeds directly to analysis
- AI generalizes from a single cohort to a population-wide conclusion

## Human Ownership — Non-Negotiable

- Interpreting what churn patterns mean (requires business context not in the data)
- All recommendations to leadership — AI formats, human authors
- Deciding which patterns are significant vs. statistical noise
- Any narrative connecting data to business events (product launches, market changes, etc.)
- The framing and tone of the leadership presentation
