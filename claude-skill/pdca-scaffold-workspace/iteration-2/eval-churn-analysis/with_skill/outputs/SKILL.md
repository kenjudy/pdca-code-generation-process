---
name: churn-analysis-pdca
description: Guides monthly SaaS customer churn analysis — pulling cohort data,
  surfacing patterns, and producing a reviewed leadership presentation — under strict
  human ownership of all causal interpretation. Applies structured analysis, disciplined
  execution, and quality verification under human supervision. Use this skill whenever
  working on churn analysis tasks, retention cycles, or any request to analyze customer
  churn. Triggers on phrases like "churn analysis", "analyze churn", "retention report",
  "cohort churn", or "let's work on churn".
---

# Churn Analysis PDCA Framework

A structured human-AI collaboration process for monthly SaaS customer churn analysis.
Cycle frequency: Monthly (first week of month, covering prior month's cohort data).

## How to Use This Skill

Work through phases in order. Each phase has a STOP condition before proceeding.

**PLAN** — Confirm cohort definitions and define the analysis approach before executing.
See `references/phase-prompts.md` → PLAN phase.

**DO** — Compute rates, surface patterns, and draft the deck with discipline. Human
intervention is mandatory at defined gates.
See `references/phase-prompts.md` → DO phase.

**CHECK** — Verify quality against the agreed criteria before declaring done.
See `references/phase-prompts.md` → CHECK phase.

**ACT** — Retrospect. Propose refinements to this skill. Human approves changes.
See `references/phase-prompts.md` → ACT phase.
See `references/working-agreements.md` for the current version and process discipline rules.

## STOP Triggers — Intervene Immediately

If any of these occur, stop the AI and restate the relevant phase prompt:

- AI makes any causal claim about why customers churned (any "because", "due to", or "driven by" framing not directly quoting the analyst's own words)
- AI redefines cohort boundaries or segmentation without the analyst's explicit confirmation
- AI proceeds to draft the presentation deck before the analyst has confirmed the pattern review is complete
- AI adds a recommendation slide without the analyst authoring or explicitly approving the recommendations
- AI generates "key takeaway" or "headline finding" framing without the analyst's input

## Human Ownership — Non-Negotiable

The human owns these decisions. AI must not proceed past them without explicit approval:

- Causal attribution: any statement of why customers churned is owned by the analyst, not AI
- Signal vs. noise decisions: which patterns are meaningful given business context AI does not have
- Leadership narrative framing: what the churn data means for business strategy
- Recommendations and action priorities: which segments to focus on, what interventions to pursue
- Sign-off on the final presentation before it is sent to leadership
- Cohort definition confirmation: how cohorts are segmented before AI computes any rates
