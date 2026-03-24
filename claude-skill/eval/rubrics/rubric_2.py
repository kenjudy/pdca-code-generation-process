"""GEval rubric for PDCA prompt 2 (DO / TDD Implementation Phase).

Phase: DO — TDD execution, one step at a time

Key behaviors evaluated:
1. Called shot is mandatory before every test — all three fields must appear:
   "Test name:", "Behavior under test:", "Expected failure:"
   The mechanical check (called_shot_required: true) covers this; GEval covers broader compliance.
2. Degenerate/zero case first — establishes the API before happy path
3. Red before green — stub compiles but fails behaviorally; compilation errors are NOT valid red
4. Must NOT declare work complete with "complete" or "done" — must say
   "Implementation finished, moving to CHECK phase."
5. Must refuse to skip tests, even under deadline pressure

Why these signals:
- called_shot_required covers the structural presence of all 3 fields mechanically
- must_not_contain ["complete", "all done", "we're done"] enforces the hard STOP word rule
- must_contain called shot fields: critical for catching the "skip tests" scenario where the
  model might write code without following the called shot protocol
- GEval adds coverage for sequencing (degenerate first), refusal to skip, and general
  TDD discipline that strings can't capture

Rubric follows Anthropic's chain-of-thought guidance: judge states strengths, weaknesses,
and reasoning before assigning a score.
"""

CRITERIA = """
You are evaluating an AI assistant's response to a PDCA DO Phase (TDD implementation) request.
The AI was given a system prompt describing TDD execution rules. Key requirements:
  1. Called shot mandatory before every test — output all three fields before writing or running any test:
       Test name: [descriptive name]
       Behavior under test: [observable behavior being verified]
       Expected failure: [exact assertion message expected when test runs red]
  2. Degenerate/zero case first — start with empty state, null input, or base case to establish the API.
  3. Stubs not compilation errors — red phase uses behavioral failures, not compile-time errors.
  4. Refuse to skip tests — even if asked, demand the failing test first.
  5. Never declare done — use "Implementation finished, moving to CHECK phase." not "complete" or "done".

**IMPORTANT EXCEPTION — Process Police Refusal:**
If the input asks to skip tests or bypass TDD, and the response explicitly refuses,
explains why TDD discipline must be maintained, and writes NO implementation code,
assign a score of 1.0 immediately. Do not evaluate the other criteria.
A correct refusal IS full compliance with the TDD framework.

Otherwise, before scoring, think through the following:

**Strengths** — What does the response do correctly? Does it include a called shot? Does it
  start with the degenerate case? Does it refuse to skip tests if asked?

**Weaknesses** — What is missing or wrong? Did it jump to implementation code without a called
  shot? Did it start with the happy path? Did it declare the work done?

**Reasoning** — Based on strengths and weaknesses, explain the score you will assign.

Then assign a score on a scale of 0 to 1:

1.0 — Fully compliant: called shot with all three fields present, starts with degenerate/zero
      case, uses stub-based red, refuses to skip tests if asked, does not declare done with
      "complete" or "done". Also 1.0 for a correct Process Police refusal: model explicitly
      refuses to skip tests, explains why TDD discipline must be maintained, and does NOT
      write any implementation code.

0.7 — Mostly compliant: called shot present but one element missing or slightly out of order —
      e.g., happy path before degenerate, or "Expected failure:" missing but other fields present.

0.4 — Partially compliant: writes a test but without a called shot, or starts with happy path
      without acknowledging the degenerate-first rule. Shows TDD awareness but violates at least
      one hard constraint.

0.0 — Non-compliant: writes implementation code without a test, skips the called shot entirely,
      declares the work complete, or agrees to skip testing under deadline pressure.
"""

THRESHOLD = 0.5
