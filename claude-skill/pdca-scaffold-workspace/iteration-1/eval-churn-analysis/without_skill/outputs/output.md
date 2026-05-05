# Structuring AI-Assisted Customer Churn Analysis

## The Core Design Principle

The division you want is clean and defensible: AI handles data transformation and pattern surfacing; you handle interpretation and recommendations. This isn't just a preference -- it's the right architecture. The AI has no visibility into your pricing changes last quarter, the sales motion shift, which customer segments you're deliberately deprioritizing, or what the leadership team has already decided to do. Those gaps make AI-generated recommendations unreliable even when the data work is excellent.

The structure below keeps that boundary explicit at every stage.

---

## Proposed Workflow

### Phase 1: Data Preparation (AI-assisted)

You provide:
- Raw cohort export (CSV, Parquet, or direct query results)
- The SQL queries you want run, or a description of what you need
- Any known data quality issues or joins that are tricky

AI does:
- Writes or refines SQL queries
- Cleans and reshapes the data (deduplication, null handling, type coercion)
- Builds cohort tables (monthly retention matrices, survival curves, LTV snapshots)
- Joins supplementary tables (plan type, ARR tier, industry, CSM owner, etc.)
- Flags anomalies in the data itself (e.g., negative churn figures, missing contract end dates)

You review the output data before moving on. This is a hard stop -- not a formality.

---

### Phase 2: Pattern Identification (AI-assisted, human-curated)

AI does:
- Segments churn by the dimensions you specify (plan, cohort month, industry, ARR band, geography, feature usage tier)
- Computes summary statistics: churn rate by segment, median time-to-churn, churn concentration by account size
- Surfaces statistical outliers: segments with churn rates more than N standard deviations from baseline
- Produces a ranked list of "notable findings" -- patterns that are mathematically significant

Critically, AI labels these findings as observations, not explanations:
- "Enterprise accounts in the Q3 2024 cohort churned at 18%, vs. 9% baseline" -- not "Enterprise accounts churned because of onboarding issues"
- "Accounts with fewer than 3 active users at 90 days churned at 3x the rate of accounts with 10+ users" -- not "Low user adoption is driving churn"

You receive a structured findings document, not a narrative.

---

### Phase 3: Your Analysis (Human-only)

You work through the AI's findings list with your business context:

For each flagged pattern, you ask:
- Do I already know why this happened?
- Is this signal or noise? (Did we intentionally offboard these accounts? Was there a one-time event?)
- What other context explains or complicates this pattern?
- Is this actionable, and if so, for which team?

You annotate the findings document with your interpretations. This becomes the analytical layer the AI cannot produce.

---

### Phase 4: Report Drafting (AI-assisted)

You provide:
- Your annotated findings (patterns + your interpretations)
- The recommended actions you've decided on
- The audience and desired tone (executive summary vs. detailed operational review)
- Any prior report for style continuity

AI does:
- Drafts prose sections from your inputs
- Structures the report (executive summary, methodology, findings, recommendations)
- Ensures consistency in terminology and formatting
- Generates supporting charts or table descriptions if needed

You review, revise, and finalize. The recommendations section comes from your notes -- the AI formats and clarifies, not invents.

---

## Conversation Templates

To make this repeatable, use structured prompts at each phase rather than open-ended requests.

**Phase 1 prompt structure:**
```
I'm pulling churn data for [month/cohort]. Here are my raw tables and the joins I need:
[paste schema or query]

Clean this data and produce:
- A monthly retention matrix for cohorts [date range]
- Churn counts and rates by [dimension list]
- Flag any records where [known data issue]

Do not interpret the results. Return the transformed data and a brief data quality note.
```

**Phase 2 prompt structure:**
```
Here is the cleaned churn dataset for [period].

Surface statistically notable patterns across these dimensions: [list].
Use a threshold of [e.g., >2 percentage points above baseline or >20% relative difference].

Format each finding as:
- Observation: [what the data shows, no interpretation]
- Magnitude: [the numbers]
- Comparison: [vs. what baseline]

Do not explain why the pattern exists. Do not recommend actions.
```

**Phase 3 is your work -- no AI prompt.**

**Phase 4 prompt structure:**
```
Here are my annotated churn findings and the recommendations I've decided on:
[paste your analysis notes]

Draft an executive report with:
- A 3-5 sentence summary for leadership
- A findings section using my notes as the source of truth
- A recommendations section drawn directly from my notes -- do not add recommendations I haven't listed
- Appendix with the supporting data tables

Audience: [describe]. Prior report style: [attach or describe].
```

---

## What to Watch For

**Drift in Phase 2:** AI will sometimes insert explanatory language into what should be pure observations ("...suggesting that...," "...likely due to..."). Catch this in your review and push back explicitly.

**Scope creep in Phase 4:** If you give the AI your findings and ask it to draft the report, it will often add recommendations you didn't specify. The prompt template above addresses this, but verify the output.

**Data quality as a gate:** If Phase 1 output has unexplained gaps or inconsistencies, do not proceed to Phase 2 until you understand them. A pattern-finding step run on bad data wastes your analysis time.

**Repeatable structure builds trust:** Use the same prompt templates each month. Consistency means you'll notice when the AI's behavior changes and makes the outputs easier to compare across periods.

---

## Monthly Checklist

- [ ] Export cohort data from warehouse; verify row counts against prior month
- [ ] Run Phase 1 prompt; review data quality note; spot-check 10-20 records
- [ ] Run Phase 2 prompt; read findings list without jumping to conclusions
- [ ] Work through findings with your business context (Phase 3 -- no AI)
- [ ] Write your recommendation bullets before opening Phase 4
- [ ] Run Phase 4 prompt with your annotated notes as input
- [ ] Review draft: verify all recommendations trace to your notes
- [ ] Finalize and distribute

---

## Summary

The structure works because the handoff points are explicit and the AI's role at each stage is narrowly scoped. You're not asking AI to be a junior analyst who produces a draft you edit -- you're using it as a data engineer and a formatter, with a clear wall around the interpretive work that requires your context. That wall is what makes the output trustworthy.
