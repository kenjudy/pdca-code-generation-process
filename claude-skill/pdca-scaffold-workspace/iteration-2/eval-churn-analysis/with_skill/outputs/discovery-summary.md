# Socratic Discovery Summary — SaaS Churn Analysis

**Domain:** Monthly SaaS Customer Churn Analysis
**Generated:** 2026-05-05
**Status:** Confirmed (invented answers for eval purposes)

---

## Layer 1 — Task Essence

**Q1. In one sentence: what is the task, and what does a completed cycle deliver?**

Answer: Monthly SaaS customer churn analysis — delivers a reviewed, approved leadership presentation identifying which cohorts churned this month, at what rates, and what patterns the data surface, with human-owned interpretation of root causes.

**Q2. How often is one full cycle performed?**

Answer: Monthly. The cycle runs in the first week of each month covering the prior month's cohort data.

---

## Layer 2 — Human-AI Role Division

**Q3. What parts require human judgment that cannot be delegated to AI?**

Answer:
- Interpreting why customers churned: causal attribution belongs to the analyst and leadership, not AI
- Deciding which patterns are signal vs. noise given business context AI does not have
- Framing the narrative for leadership: what the churn means for the business strategy
- Recommending actions: which segments to prioritize, what interventions to pursue
- Sign-off on the final presentation before it goes to leadership

**Q4. What parts can AI execute autonomously, with human review at defined gates?**

Answer:
- Pulling cohort breakdowns from the data warehouse query outputs provided by the analyst
- Computing churn rates by cohort, segment, plan tier, and acquisition channel from the raw data
- Identifying statistical outliers and anomalies in the cohort data
- Generating summary tables and visualizations of the patterns
- Drafting the data-description sections of the slide deck (what the numbers show, not why)
- Cross-referencing current month against prior months to surface trend lines

**Q5. What are the irreversible or highest-stakes moments?**

Answer:
- Causal claims: any statement of "customers churned because X" — this must be human-owned
- Presentation to leadership: once sent, the interpretation is on the record and shapes decisions
- Cohort definition decisions: how cohorts are cut determines what patterns appear; the analyst must confirm the segmentation before AI computes rates

---

## Layer 3 — Quality Contract

**Q6. How do you know when one cycle is successfully complete? (3-5 observable signals)**

Answer:
1. Churn rates are computed for all agreed cohort dimensions (plan tier, acquisition channel, tenure band, geography) and reviewed by the analyst
2. The presentation deck has been reviewed by the analyst and contains no AI-generated causal claims — only pattern descriptions
3. Leadership has received the deck and the analyst has fielded questions in the readout
4. Any anomalous cohorts flagged by AI have been either explained by the analyst or noted as requiring further investigation
5. The cycle retrospective is complete and any process changes are documented

**Q7. What are the most common failure modes?**

Answer:
- AI embeds causal language in the data-description sections ("these customers left because...") which gets carried forward without the analyst catching it
- Cohort definitions drift month-over-month because the analyst forgets to confirm the segmentation spec before AI computes, making trend comparisons invalid
- The leadership deck becomes a data dump with no narrative because the analyst runs out of time after the AI does the number-crunching
- The analysis is treated as done when the deck is sent, skipping the retrospective
- Shortcuts on the cohort cross-referencing step mean new patterns are missed because prior-month baselines are not pulled

---

## Layer 4 — Process Shape

**Q8. Phase boundaries**

"Analysis done" looks like: The analyst has confirmed the cohort definitions, AI has computed all churn rates and surfaced anomalies, and the analyst has reviewed the pattern summary and decided which patterns are worth presenting. No deck work has started yet.

"Execution done" looks like: The slide deck draft is complete with data-description sections written, visualizations embedded, and the analyst has reviewed the draft and written or approved the interpretive narrative sections. The deck is ready for the leadership readout.

**Q9. AI behaviors that trigger immediate STOP and human intervention**

Answer:
- AI makes any causal claim about why customers churned (any "because", "due to", "driven by" framing not quoting the analyst's own words)
- AI redefines cohort boundaries without the analyst's explicit confirmation
- AI proceeds to draft the deck before the analyst has confirmed the pattern review is complete
- AI adds a recommendation slide without the analyst authoring or explicitly approving the recommendations
- AI generates the "key takeaway" or "headline finding" framing without the analyst's input

---

## Layer 5 — Learning Loop

**Q10. What process debt tends to accumulate?**

Answer:
- Cohort definitions get assumed rather than confirmed because "it's the same as last month" — until it isn't
- The retrospective gets skipped when the leadership readout goes long
- The causal-language review step gets treated as optional after a few clean cycles
- Prior-month baseline pulls get skipped when time is tight, breaking trend continuity

**Q11. What do you want to learn and improve from each cycle?**

Answer:
- Which cohort dimensions surfaced actionable patterns vs. noise (to refine what is tracked)
- Whether the time estimate for each phase is accurate (to make scheduling realistic)
- Which failure modes actually appeared so the quality gates can be tightened
- Whether the leadership presentation format is working or needs restructuring based on the questions asked in the readout

---

## Confirmation Summary

**Task:** Monthly SaaS churn analysis — delivers a reviewed leadership presentation of cohort churn rates and data patterns, with human-owned causal interpretation.
**Cycle frequency:** Monthly (first week of month, covering prior month).

**Human owns:**
- Causal attribution (why customers churned)
- Signal vs. noise decisions given business context
- Leadership narrative framing
- Recommendations and action priorities
- Sign-off before presentation is sent
- Cohort definition confirmation before AI computes

**AI executes (with review gates):**
- Churn rate computation from provided query outputs
- Statistical outlier and anomaly identification
- Summary tables and visualizations
- Data-description sections of the deck (what, not why)
- Cross-referencing against prior months

**Done looks like:**
- Churn rates computed and reviewed for all cohort dimensions
- Deck contains no AI-generated causal claims
- Leadership has received and been walked through the deck
- Anomalous cohorts explained or flagged for investigation
- Retrospective complete

**Common failure modes to prevent:**
- AI embeds causal language in data sections
- Cohort definitions drift without analyst confirmation
- Deck becomes a data dump with no narrative
- Retrospective skipped
- Prior-month baselines omitted

**Phase boundaries:**
- Analysis done: Cohort definitions confirmed, rates computed, patterns reviewed, deck work not started
- Execution done: Deck draft complete with data sections and analyst-authored narrative, ready for readout

**STOP triggers:**
- AI makes any causal claim about churn (any "because/due to/driven by" framing)
- AI redefines cohort boundaries without confirmation
- AI drafts deck before pattern review is confirmed complete
- AI adds recommendation slide without analyst authorship or approval
- AI generates headline finding framing without analyst input

**Learning loop focus:**
- Which cohort dimensions surface actionable patterns
- Phase time estimate accuracy
- Which failure modes actually appeared
- Whether leadership presentation format is working
