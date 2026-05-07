# Generation Templates: Building the Domain PDCA Skill

**Purpose:** Generate a valid, installable Claude skill from confirmed Socratic discovery answers
**When to use:** After the human confirms the Socratic discovery summary (5a)
**Expected output:** A directory of skill files ready to install or package
**Typical duration:** 5-10 minutes
**Next step:** Human installs the skill; runs cycles; uses refinement protocol (5c) at ACT phase

---

## Output Structure

Before generating any files, ask:

```
Where would you like the skill generated?
The skill directory will be named `[domain]-pdca/`.
Provide a path relative to the current directory, or press Enter to use the current directory.
(Example: `scaffolded/` → generates at `scaffolded/[domain]-pdca/`)
```

Wait for the answer. Use the provided path as the base. If the user presses Enter or provides no path,
generate directly in the current project directory.

Generate the following files at `[base-path]/[domain]-pdca/`:
Use the domain name from the task description (slugified, lowercase, hyphens).

```
[domain]-pdca/
├── SKILL.md
└── references/
    ├── working-agreements.md
    ├── phase-prompts.md
    └── quality-gates.md
```

Never generate files outside the confirmed path. The user places this in their project repo
and version-controls it alongside their work.

---

## SKILL.md Template

Fill in ALL bracketed placeholders from the confirmed discovery summary. Do not leave placeholders.

**Structural requirement — verify before continuing:** The first line of SKILL.md must be `---`.
This opens the YAML frontmatter block that skill-creator requires to install and trigger the skill.
If SKILL.md starts with `#` or any other character, the skill cannot be installed or triggered.
After generating SKILL.md, confirm line 1 is `---` before generating any other file.

```markdown
---
name: [domain]-pdca
description: Guides [one-sentence task description from Layer 1]. Applies structured
  analysis, disciplined execution, and quality verification under human supervision.
  Use this skill whenever working on [task domain] tasks, [domain] cycles, or any
  request to [verb from task description]. Triggers on phrases like "[domain keyword]",
  "[action verb] [output]", or "let's work on [domain]".
---

# [Domain] PDCA Framework

A structured human-AI collaboration process for [task description].
Cycle frequency: [Layer 1 answer].

## How to Use This Skill

Work through phases in order. Each phase has a STOP condition before proceeding.

**PLAN** — Understand the context and define the approach before executing.
See `references/phase-prompts.md` → PLAN phase.

**DO** — Execute with discipline. Human intervention is mandatory at defined gates.
See `references/phase-prompts.md` → DO phase.

**CHECK** — Verify quality against the agreed criteria before declaring done.
See `references/phase-prompts.md` → CHECK phase.

**ACT** — Retrospect. Propose refinements to this skill. Human approves changes.
See `references/phase-prompts.md` → ACT phase.
See `references/working-agreements.md` for the current version and process discipline rules.

## STOP Triggers — Intervene Immediately

If any of these occur, stop the AI and restate the relevant phase prompt:

[List each STOP trigger from Layer 4, Q9 as a bullet]

## Human Ownership — Non-Negotiable

The human owns these decisions. AI must not proceed past them without explicit approval:

[List each human-owned element from Layer 2, Q3 and Q5 as a bullet]
```

---

## references/working-agreements.md Template

```markdown
# Working Agreements — [Domain] PDCA

**Version:** 1
**Last refined:** [generation date]
**Refinement history:** See git log for this file.

## Process Discipline

Process discipline trumps speed. When a violation is observed, stop and address it
before continuing.

### Human Owns (Non-Negotiable)

[List each item from Layer 2, Q3 and Q5. Be specific — use the human's exact words
where possible, not paraphrased versions.]

### AI Executes (With Review Gates)

[List each item from Layer 2, Q4. Note where the review gate is — "AI drafts, human
reviews before sending" not just "AI drafts".]

### Intervention Triggers

When the AI does any of the following, stop immediately:

[List each item from Layer 4, Q9 as an imperative trigger:
"Stop if AI [behavior]" or "Intervene when AI [behavior]".]

### Process Debt to Watch For

These shortcuts tend to accumulate — flag them when they appear:

[List each item from Layer 5, Q10.]

## Implementation Approach

- Understand context before executing. Gather enough information to know what "analysis done"
  looks like for this cycle before proceeding to execution.
- Minimal scope. The smallest action that moves the cycle forward. No scope expansion
  without explicit human approval.
- One phase at a time. Complete PLAN before DO. Complete DO before CHECK.
- Respond to feedback. If the approach isn't working, try a different approach rather
  than persisting with the same one.

## Definition of Done

A cycle is complete only when all of the following are true:

[List each signal from Layer 3, Q6 as a checkbox item.]
```

---

## references/phase-prompts.md Template

Fill placeholders from the confirmed discovery summary.

```markdown
# Phase Prompts — [Domain] PDCA

---

## PLAN Phase

**Purpose:** Understand the current context and define the approach for this cycle.
**Duration:** [Estimate based on task complexity — typically 10-20% of total cycle time]
**Done when:** [Use "Analysis done" description from Layer 4, Q8]

### Steps

1. **Context gathering** — What is the current state? What has changed since the last cycle?
   Gather [domain-specific sources: documents, data, stakeholder input, etc. — infer from task].

2. **Constraint identification** — What constraints apply to this cycle?
   (Deadlines, stakeholders, scope limits, dependencies on others)

3. **Approach definition** — Given context and constraints, what is the plan for this cycle?
   State the approach in specific, verifiable terms. Not "write the report" but
   "draft sections X, Y, Z using sources A and B, targeting audience C."

4. **Human review gate** — Present the approach to the human for approval before executing.
   The human confirms or redirects. Do not proceed to DO without explicit approval.

> **STOP:** Do not begin execution until the human has approved the approach.

---

## DO Phase

**Purpose:** Execute the approved plan with discipline and defined HITL checkpoints.
**Duration:** [Estimate — typically 60-70% of total cycle time]
**Done when:** [Use "Execution done" description from Layer 4, Q8]

### Before Starting

- [ ] PLAN phase approved by human
- [ ] Approach is specific enough that "done" is unambiguous
- [ ] Scope boundaries are clear — know what is out of scope

### Execution

[Generate 3-5 domain-specific execution steps based on the task description.
Each step should be atomic and end with a verifiable output.
Examples for "weekly client report":
  - Draft metrics section using data from [source]
  - Draft risks section — list only risks with evidence, not speculation
  - Draft recommendations — each tied to a specific metric or risk
  - Internal review: read the full draft aloud and flag anything that needs
    stakeholder context the AI does not have
]

### Mandatory Human Gates

Pause and present to the human at each of these points:

[List each irreversible/high-stakes moment from Layer 2, Q5 as a checkpoint:
"GATE: Before [action], present [output] to human for approval."]

> **STOP:** If the AI skips a gate, produces output without required context,
> or expands scope beyond the approved plan — stop immediately.
> Repost this prompt and restart the DO phase from the last checkpoint.

---

## CHECK Phase

**Purpose:** Verify quality against the agreed criteria before declaring done.
**Duration:** [Estimate — typically 10-15% of total cycle time]

### Verification Checklist

[List each signal from Layer 3, Q6 as a verifiable checkbox:]
- [ ] [Signal 1]
- [ ] [Signal 2]
- [ ] [Signal 3 — etc.]

### Failure Mode Check

Confirm none of the common failure modes are present:

[List each item from Layer 3, Q7 as a check:]
- [ ] [Failure mode 1] — not present
- [ ] [Failure mode 2] — not present

### Process Audit

- [ ] Human owned every non-delegable decision
- [ ] All mandatory gates were observed (not skipped "just this once")
- [ ] Scope stayed within the approved plan

> If any check fails, return to DO phase. Do not declare done with known deficiencies.

---

## ACT Phase

**Purpose:** Retrospect on the cycle. Propose refinements to this skill. Human approves changes.
**Duration:** 5-10 minutes

### Retrospective

Address each area:

**Cycle overview:** What was accomplished? What was the scope?

**Critical moments:** What 2-3 decisions or interventions most impacted quality or efficiency?

**Process insights:**
- What worked well and should be protected?
- What slowed progress or reduced quality?
- Where did process discipline slip (if it did)?

**Top 3 actionable insights:**
1. Start doing: [specific practice]
2. Stop doing: [specific practice]
3. Keep doing: [specific practice]

### Skill Refinement (Mandatory)

After completing the retrospective, follow the refinement protocol in
`references/working-agreements.md` Version history and
`references/refinement-protocol.md` (if present, from the scaffold skill).

See `references/working-agreements.md` for the current version and refinement rules.
```

---

## references/quality-gates.md Template

```markdown
# Quality Gates — [Domain] PDCA

## Definition of Done

A cycle is complete when all of the following are true:

[List each signal from Layer 3, Q6 as a numbered item with enough specificity
to be checkable by someone who wasn't in the session.]

## Common Failure Modes

Watch for these and treat them as quality failures requiring remediation:

[List each item from Layer 3, Q7 with a concrete indicator of how to detect it.]

## Gate Escalation

If a quality gate cannot be passed:
1. Identify the specific gap
2. Return to DO phase to address it
3. Do not reduce the quality bar to make the gate pass — fix the work instead
```

---

## After Generation

Tell the user:

```
I've generated the [domain]-pdca skill in `[domain]-pdca/`. Next steps:

1. Review the files — especially `references/working-agreements.md`.
   The STOP triggers and human ownership lines are the skill's discipline mechanism.
   Make sure they match what you actually want enforced.

2. Commit the skill to your project repo:
   git add [domain]-pdca/
   git commit -m "feat: add [domain]-pdca skill (v1)"

3. Install it:
   cp -r [domain]-pdca/ ~/.claude/skills/

4. Validate with /skill-creator before using in production:
   Run /skill-creator on the `[domain]-pdca/` directory. It will:
   - Verify the SKILL.md format and that the description triggers correctly
   - Run with-skill vs. without-skill eval comparisons to confirm the skill
     produces better outcomes than improvised alternatives
   - Surface improvements to sharpen the skill before your first real cycle

   This is how you know the skill is behaviorally effective, not just structurally valid.
   A skill that hasn't been through eval is an untested assumption.

5. Use it. Invoke /[domain]-pdca at the start of each cycle.

6. At the end of each ACT phase, the skill will propose refinements.
   Approve and commit them. The skill improves with each cycle.
```

---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution.

**Source:** [PDCA Framework Repository](https://github.com/kenjudy/pdca-framework)

---
*2026*
