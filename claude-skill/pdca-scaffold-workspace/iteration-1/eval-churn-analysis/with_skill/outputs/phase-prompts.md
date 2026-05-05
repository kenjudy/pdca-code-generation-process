# Phase Prompts — Churn Analysis PDCA

---

## PLAN Phase

**Purpose:** Define the analysis scope and confirm data sources before querying anything.
**Duration:** 30-45 minutes
**Done when:** Scope confirmed, SQL queries reviewed by human, data quality baseline established

### Steps

1. **Scope definition** — What does this month's analysis need to answer?
   - Which cohorts? (e.g., all customers active 90 days ago, enterprise only, by plan tier)
   - Which time period? (month-over-month, trailing 3 months, year-over-year)
   - Which segments? (by plan, by industry, by acquisition channel, by CSM)
   - Are there specific hypotheses from last month to test this cycle?

2. **SQL query drafting** — Write queries to pull the defined cohort data.
   Queries should pull: cohort start date, churn date (if applicable), plan tier,
   revenue at churn, key behavioral signals (logins, feature usage, support tickets).
   Present queries to human for review before execution.

3. **Human review gate (queries)** — Human reviews all SQL before it runs against production.
   Confirms: correct time ranges, correct cohort definitions, no performance-killing joins.

4. **Data quality check** — After execution, verify:
   - Row counts match expectations (flag if significantly different from last month)
   - No null values in key columns (churn date, plan tier, revenue)
   - No duplicate customer IDs
   - Known data anomalies from last month are resolved (or still present and noted)
   Present data quality summary to human before analysis begins.

> **STOP:** Do not begin pattern analysis until human has reviewed queries and confirmed
> data quality. Analysis built on bad data is worse than no analysis.

---

## DO Phase

**Purpose:** AI surfaces patterns; human writes interpretation and recommendations. Strictly separated.
**Duration:** 3-4 hours total (pattern phase, then interpretation phase — not concurrent)
**Done when:** Human has authored all interpretations and recommendations; report is formatted

### Before Starting

- [ ] PLAN phase complete — queries reviewed, data quality confirmed
- [ ] Scope is specific enough that "done" is unambiguous
- [ ] The interpretive boundary is understood: AI observes, human interprets

### Pattern Surfacing (AI Phase)

AI surfaces the following, presented as pure numerical observations only:

1. **Overall churn rate** — This month vs. last month vs. same month last year.
   Format: "[X]% of customers active on [date] churned by [date], compared to [Y]% last month."
   No explanatory language. No "this suggests."

2. **Segment breakdown** — Churn rate by each defined segment.
   Format: "Enterprise segment: [X]%. SMB segment: [Y]%." No evaluative language.

3. **Trend analysis** — 3-month and 6-month trend lines by segment.
   Format: "[Segment] churn has been [increasing/decreasing] for [N] consecutive months."
   "Increasing" and "decreasing" are observations. Stop there.

4. **Cohort behavior** — Time-to-churn distribution for churned customers.
   Format: "Median time to churn this month: [N] days. [X]% churned within 30 days."

5. **Anomaly flags** — Statistical outliers in any segment or time period.
   Format: "[Segment X] churn rate is [2x] the 6-month average. No explanation provided."

Present the complete pattern list to human before any interpretation is written.

### Human Review Gate (Patterns)

Human reviews the pattern list and:
- Confirms which patterns are significant vs. noise
- Adds business context annotations to each significant pattern
- Authors interpretation for each: what does this pattern mean and why?
- Authors all recommendations: what actions does the business need to take?

> **STOP:** AI must not write any interpretation or recommendation. If asked "what do you
> think this means?", respond: "That interpretation belongs to you — I can help format
> it once you've written it."

### Report Drafting (AI Formats, Human Authors Content)

After human has annotated the pattern list:

1. Structure the leadership report:
   - Executive summary (human writes, AI formats)
   - Key metrics (AI formats from the analysis)
   - Significant patterns with human-authored interpretation (AI formats)
   - Recommendations (AI formats from human's authored text exactly — no paraphrasing)
   - Appendix: data tables and charts

2. Present the formatted draft to human for final review.

---

## CHECK Phase

**Purpose:** Verify analysis integrity and that no AI interpretation slipped into the final output.
**Duration:** 30 minutes

### Verification Checklist

- [ ] Cohort data pulled fresh this cycle (not last month's cached data)
- [ ] Data quality check completed and documented
- [ ] Pattern list reviewed by human before interpretation was written
- [ ] Every recommendation traces to a human-authored annotation, not AI inference
- [ ] No AI-generated explanatory language in the final report
- [ ] Leadership presentation reviewed and approved by human analyst

### Failure Mode Check

- [ ] AI explanatory language in the report ("this likely indicates...") — not present
- [ ] AI-authored recommendations — not present
- [ ] Data quality check skipped — not present
- [ ] Old data used without fresh pull — not present
- [ ] Patterns presented without human reviewing them first — not present

### Process Audit

- [ ] Interpretive boundary maintained throughout — AI observed, human interpreted
- [ ] All mandatory gates observed
- [ ] Scope stayed within what was defined in PLAN

---

## ACT Phase

**Purpose:** Retrospect and propose skill refinements.
**Duration:** 15 minutes

### Retrospective

**Analysis overview:** What were the notable churn patterns this month?

**Critical moments:** Where did the interpretive boundary get tested?
(Did the AI slip into explanatory mode? Did the human catch it?)

**Process insights:**
- How much did human interpretation change from the AI's pattern framing?
  (Large changes signal the AI's observation language was biased.)
- Did the data quality check catch anything? Was it worth the time?
- What took longest? Where is the bottleneck?

**Top 3 actionable insights:**
1. Start doing: [specific practice]
2. Stop doing: [specific shortcut to eliminate]
3. Keep doing: [what to protect]

### Skill Refinement

Review `references/working-agreements.md` and propose updates.
Key question: Did any AI observation language contain implicit interpretation?
If so, the STOP trigger language needs to be more specific.
