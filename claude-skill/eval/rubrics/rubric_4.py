"""GEval rubric for PDCA prompt 4 (Act / Retrospection Phase).

Phase: ACT — end-of-session retrospective for continuous improvement

Key behaviors evaluated:
1. Identifies 2-3 specific critical moments — concrete decisions or interventions
   that impacted the session, not generic observations
2. Provides Start doing / Stop doing / Keep doing — three distinct, actionable insights
3. Answers the "ONE thing" final question — a single highest-leverage change
4. Covers the full retrospective structure even for short sessions
5. Findings are specific to the described session, not generic coaching advice

Why these signals:
- must_contain "Start doing:", "Stop doing:", "Keep doing:": these are the literal
  labels for the three actionable insights; their absence means the model gave a
  generic reflection without the required structure
- GEval adds coverage for specificity (critical moments must reference the session)
  and completeness (ONE thing question must be answered)
- No must_not_contain needed: the failure mode here is vagueness and skipping
  structure, which mechanical checks can't easily detect — GEval is the primary check

Rubric follows Anthropic's chain-of-thought guidance: judge states strengths, weaknesses,
and reasoning before assigning a score.
"""

CRITERIA = """
You are evaluating an AI assistant's response to a PDCA Act Phase (retrospection) request.
The AI was given a system prompt requiring a structured end-of-session retrospective. Key requirements:
  1. Session overview — brief summary of goal and scope.
  2. Critical moments analysis — 2-3 specific moments that most impacted success or failure.
     These must be concrete and tied to the described session, not generic advice.
  3. Start doing / Stop doing / Keep doing — three distinct, actionable insights.
  4. Next session setup decisions — process boundaries, intervention triggers, etc.
  5. ONE thing — if you could change only one thing about the collaboration, what would it be?
     This question must be answered specifically, not left open or deflected.

Before scoring, think through the following:

**Strengths** — What does the response do correctly? Are critical moments specific and
  session-grounded? Are Start/Stop/Keep present and actionable? Is the ONE thing answered?

**Weaknesses** — What is missing or too generic? Are critical moments vague platitudes?
  Is any required section absent? Is the ONE thing deflected or missing?

**Reasoning** — Based on strengths and weaknesses, explain the score you will assign.

Then assign a score on a scale of 0 to 1:

1.0 — Fully compliant: session-specific critical moments, all three Start/Stop/Keep insights
      present and actionable, next session decisions addressed, ONE thing answered specifically.

0.7 — Mostly compliant: structure is present and mostly session-specific, but one element is
      thin — e.g., critical moments are slightly generic, or ONE thing is present but vague.

0.4 — Partially compliant: has some retrospective content but is missing at least one required
      section, or the content is generic coaching advice not grounded in the described session.

0.0 — Non-compliant: provides generic advice without session-specific content, skips the
      required structure entirely, or does not answer the ONE thing question.
"""

THRESHOLD = 0.5
