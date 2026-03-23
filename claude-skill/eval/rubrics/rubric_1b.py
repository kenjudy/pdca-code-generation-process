"""GEval rubric for PDCA prompt 1b (Planning Phase).

Phase: PLAN → Planning (after analysis, before DO)

Key behaviors evaluated:
1. Numbered, atomic implementation steps — one testable behavior per step
2. A complete test list is produced as a planning artifact (enumerate all behaviors
   upfront, not just the first test)
3. Preparatory refactoring is explicitly separated from feature work — refactor: steps
   come first, each must leave all tests passing, before any feat: steps begin
4. No implementation code is written — plan output is prose/structure only
5. Acceptance criteria and definition of done are stated for each step

Why these signals:
- must_contain "test list" / "atomic": core planning deliverables; their absence means
  the model produced a design doc, not a plan optimized for TDD execution
- must_contain "refactor" / "feat": only relevant when refactoring is identified; signals
  the model correctly separated structural prep from behavioral change
- must_not_contain implementation code: planning phase must not leak into doing phase

Rubric follows Anthropic's chain-of-thought guidance: judge states strengths, weaknesses,
and reasoning before assigning a score.
"""

CRITERIA = """
You are evaluating an AI assistant's response to a PDCA Planning Phase request.
The AI was given a system prompt describing prompt 1b, which requires producing a
detailed implementation plan after analysis is complete. Key requirements:
  1. Numbered atomic steps — each step is one testable behavior change.
  2. A test list: enumerate ALL behaviors to verify (golden path, degenerate cases,
     exceptions) as a planning artifact. This is produced now; execution is one test at a time.
  3. Preparatory refactoring: if structural cleanup is needed, those steps are explicitly
     tagged refactor: and placed BEFORE any feat: steps. Each refactor: step must leave
     all existing tests passing.
  4. No implementation code — this is a plan, not an implementation.
  5. Acceptance criteria and definition of done for each step.

Before scoring, think through the following:

**Strengths** — What does the response do well? List specific structural elements
  (numbered steps, test list, refactor/feat tagging) that are present and correct.

**Weaknesses** — What is missing or incorrect? Does the response jump to implementation?
  Skip the test list? Fail to separate refactor from feature work when it should?

**Reasoning** — Based on your analysis, explain the score you will assign.

Then assign a score on a scale of 0 to 1:

1.0 — Fully compliant: numbered atomic steps, complete test list, explicit refactor/feat
      separation (or explicit confirmation that none is needed), no implementation code,
      acceptance criteria per step.

0.7 — Mostly compliant: has numbered steps and test list but is missing one element —
      e.g., no explicit refactor check, or acceptance criteria are vague.

0.4 — Partially compliant: produces a plan-like structure but either includes
      implementation code fragments, omits the test list, or conflates refactoring
      with feature work.

0.0 — Non-compliant: produces implementation code, skips planning entirely, or produces
      a high-level design doc without actionable numbered steps.
"""

THRESHOLD = 0.5
