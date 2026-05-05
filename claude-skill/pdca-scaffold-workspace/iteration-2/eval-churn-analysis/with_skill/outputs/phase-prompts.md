# Phase Prompts — Churn Analysis PDCA

---

## PLAN Phase

**Purpose:** Confirm cohort definitions and define the analysis approach for this cycle.
**Duration:** Approximately 1-2 hours (roughly 15% of total cycle time)
**Done when:** Analyst has confirmed cohort definitions for this cycle, AI has confirmed
which query outputs are available, and the analyst has approved the analysis plan specifying
which cohort dimensions to compute, which prior-month baselines to use, and what the
deck will cover. No computation or deck work has started.

### Steps

1. **Context gathering** — What changed since last month?
   Gather: final cohort query outputs from the data warehouse, any product or pricing changes
   in the prior month, any sales or marketing initiatives that could affect acquisition-channel
   cohorts, prior month's churn rate table for baseline comparison.

2. **Cohort definition confirmation** — The analyst explicitly confirms the segmentation spec
   for this cycle:
   - Plan tier breakdowns (which tiers, how grouped)
   - Acquisition channel definitions (which channels, how attributed)
   - Tenure bands (ranges, how month-end snapshot is taken)
   - Geography groupings (if applicable)
   - Comparison period (which prior months serve as baseline)

   AI does not assume last month's definitions carry over. Analyst must confirm explicitly.

3. **Approach definition** — Given confirmed definitions and available data, state the plan:
   "This cycle I will compute churn rates across [dimensions X, Y, Z] using [query outputs A, B],
   compared against [prior month baselines], and the deck will cover [sections P, Q, R].
   The following anomaly detection approach will be used: [method]."

4. **Human review gate** — Present the full approach to the analyst for approval before
   any computation begins. Analyst confirms or redirects. Do not proceed to DO without
   explicit approval.

> **STOP:** Do not begin computation or deck work until the analyst has approved the
> approach and confirmed cohort definitions.

---

## DO Phase

**Purpose:** Compute churn rates, surface patterns, and draft the presentation deck with
discipline and defined HITL checkpoints.
**Duration:** Approximately 4-6 hours (roughly 65% of total cycle time)
**Done when:** The presentation deck draft is complete with data-description sections written,
visualizations embedded, and the analyst has reviewed the draft and written or approved the
interpretive narrative sections. The deck is ready for the leadership readout.

### Before Starting

- [ ] PLAN phase approved by analyst
- [ ] Cohort definitions explicitly confirmed for this cycle
- [ ] Query outputs identified and available
- [ ] Scope boundaries clear — know which dimensions are in and out of scope

### Execution

1. **Compute churn rates** — Calculate churn rates for each confirmed cohort dimension
   (plan tier, acquisition channel, tenure band, geography) from the provided query outputs.
   Produce a structured rate table. Output: rate table draft for analyst review.

2. **Cross-reference against baselines** — Compare current month rates against confirmed
   prior-month baselines. Surface month-over-month deltas for each cohort dimension.
   Flag any dimension showing movement above a threshold (to be confirmed with analyst).
   Output: delta table with flagged anomalies.

3. **Anomaly and outlier surfacing** — Identify cohorts with statistically notable churn
   rates. Present these as: "Cohort X shows a churn rate of Y%, which is Z percentage points
   above/below the prior-month rate of W%." Do not include any statement of why.
   Output: flagged cohort list for analyst review.

4. **Data-description deck drafting** — Draft the data sections of the slide deck:
   summary rate tables, trend visualizations, and cohort comparison charts. Each slide
   describes what the data shows. No causal framing, no "because", no "driven by".
   Output: deck draft with data sections only.

5. **Visualization review** — Present visualizations to the analyst before finalizing.
   Confirm each chart accurately represents the underlying data and that the framing
   is neutral (descriptive, not interpretive).

### Mandatory Human Gates

- GATE: After step 1, present the rate table to the analyst before proceeding to
  cross-referencing. Analyst confirms rates look correct given their knowledge of the
  underlying data.
- GATE: After step 3, present the flagged anomaly list to the analyst. Analyst decides
  which flagged cohorts are worth investigating and provides any business context.
  AI does not interpret anomalies — the analyst does.
- GATE: After step 4, analyst reviews the full deck draft. Analyst writes or dictates
  the interpretive narrative sections (what the churn means, the leadership story,
  any causal framing the analyst chooses to include).
- GATE: Before the deck is finalized, analyst reads every section for AI-generated causal
  language and removes or rewrites any that appears.

> **STOP:** If the AI makes any causal claim about why customers churned, adds a
> recommendation slide without analyst authorship, generates headline framing without
> analyst input, redefines cohort boundaries, or proceeds to a later step without
> completing the required gate — stop immediately.
> Repost this prompt and restart the DO phase from the last completed checkpoint.

---

## CHECK Phase

**Purpose:** Verify quality against the agreed criteria before declaring done.
**Duration:** Approximately 30-60 minutes (roughly 10% of total cycle time)

### Verification Checklist

- [ ] Churn rates computed and reviewed for all confirmed cohort dimensions: plan tier, acquisition channel, tenure band, geography
- [ ] Presentation deck reviewed by analyst and confirmed to contain no AI-generated causal claims anywhere in the deck
- [ ] Leadership has received the deck and the analyst has conducted the readout and fielded questions
- [ ] Any anomalous cohorts flagged by AI have been either explained by the analyst or noted as requiring further investigation
- [ ] Cycle retrospective is complete and any process changes are documented

### Failure Mode Check

Confirm none of the common failure modes are present:

- [ ] AI causal language in data sections — not present (analyst confirms after reviewing each section)
- [ ] Cohort definition drift from prior month without confirmation — not present (definitions were confirmed in PLAN)
- [ ] Deck is a data dump with no narrative — not present (analyst has written or approved interpretive sections)
- [ ] Retrospective skipped — not present (retrospective is completed before cycle is closed)
- [ ] Prior-month baselines omitted — not present (baselines were confirmed in PLAN and used in cross-referencing step)

### Process Audit

- [ ] Analyst owned every causal and interpretive decision
- [ ] All mandatory gates were observed (not skipped "just this once")
- [ ] Cohort definitions were confirmed before computation began
- [ ] Scope stayed within the approach approved in PLAN

> If any check fails, return to DO phase. Do not declare done with known deficiencies.

---

## ACT Phase

**Purpose:** Retrospect on the cycle. Propose refinements to this skill. Human approves changes.
**Duration:** 30-45 minutes

### Retrospective

Address each area:

**Cycle overview:** What cohort dimensions were analyzed? What was the overall churn picture for the month?

**Critical moments:** What 2-3 decisions or interventions most impacted quality or efficiency?
(Examples: an anomaly the analyst interpreted that changed the leadership narrative; a gate
that caught a causal claim before it went forward; a cohort dimension that surfaced a pattern
worth tracking.)

**Process insights:**
- What worked well and should be protected?
- What slowed progress or reduced quality?
- Where did process discipline slip (if it did)? In particular: did any causal language
  get through to the deck draft? Were gates observed?

**Top 3 actionable insights:**
1. Start doing: [specific practice]
2. Stop doing: [specific practice]
3. Keep doing: [specific practice]

**Cohort dimension review:** Which dimensions surfaced actionable patterns vs. noise?
Should any dimensions be added, removed, or refined for next month?

**Time estimate accuracy:** Were the phase duration estimates accurate? If not, how should
they be adjusted for next month's PLAN phase?

### Skill Refinement (Mandatory)

After completing the retrospective, review the working agreements and phase prompts:

- Do the STOP triggers reflect what actually needed intervention this cycle?
- Do the human ownership lines accurately capture what the analyst wants to own?
- Are the quality gate checks specific enough to be reliably checkable?

Propose any changes to `references/working-agreements.md` or `references/phase-prompts.md`
as concrete diffs. Analyst reviews and approves before any changes are committed.

See `references/working-agreements.md` for the current version and refinement rules.
