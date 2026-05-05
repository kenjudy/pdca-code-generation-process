# Refinement Protocol: Active Learning Loop

**Purpose:** Propose and apply specific improvements to a generated domain skill after each cycle
**When to use:** At the end of every ACT phase, after the retrospective is complete
**Expected output:** Approved diffs committed to the skill's reference files
**Typical duration:** 5 minutes
**Critical:** Refinements must be specific diffs, not rewrites. Human approves every change.

---

## Anti-Drift Rule

The skill must not grow longer with each cycle. Vague accommodations accumulate into soup.

**Hard constraint:** Net line change across all `references/` files must be ≤ +10 lines per cycle.
For every proposed addition, identify one existing rule to narrow, consolidate, or remove.

Track the current line count before proposing changes:

```bash
wc -l [domain]-pdca/references/*.md
```

If the proposed changes would exceed +10 net lines, revise the proposal to consolidate
rather than append.

---

## Refinement Steps

### Step 1: Extract Insights from the Retrospective

From the completed ACT retrospective, identify insights that have process implications:

- "Start doing" insights → candidates for new rules or strengthened checkpoints
- "Stop doing" insights → candidates for removing or narrowing existing rules
- "Keep doing" insights → confirm existing rules are worth retaining (no change needed)
- Discipline breakdowns → candidates for sharper STOP trigger language

Only insights with a clear implication for specific skill content are candidates.
"The cycle went well overall" is not a candidate. "We skipped the Layer 3 gate twice
because it felt redundant" is a candidate.

### Step 2: Map Each Insight to a Specific Location

For each candidate insight, identify:
- Which file: `working-agreements.md`, `phase-prompts.md`, or `quality-gates.md`
- Which section within that file
- Which specific lines (if narrowing or removing)

Do not propose changes to SKILL.md unless the trigger description needs updating.

### Step 3: Draft the Diff

Write a concrete before/after for each proposed change. Not a description of the change — the actual text.

Format:

```
File: references/working-agreements.md
Section: Intervention Triggers
Change type: [add | narrow | remove | consolidate]

BEFORE:
[exact current text, or "nothing" if adding]

AFTER:
[exact proposed text, or "remove" if deleting]

Reason: [one sentence from the retrospective that motivates this change]
```

Limit to 3-5 proposed changes per cycle. If there are more candidates, prioritize
the ones that address the most significant discipline breakdown or quality gap.

### Step 4: Present to Human for Approval

Present all proposed diffs together:

```
Refinement proposal for cycle [N] — [domain]-pdca v[current version]

Current references/ line count: [N] lines
Proposed net change: [+N / -N] lines

[List each diff in Step 3 format]

For each change: accept / modify / reject?
```

Wait for the human to review each change. Do not apply any changes until the human
has explicitly responded to each proposed diff.

### Step 5: Apply Approved Changes

For each accepted or modified change:
1. Edit the file directly
2. Note the change in the version block at the top of `working-agreements.md`

### Step 6: Update Version and Commit

Update the version block in `references/working-agreements.md`:

```markdown
**Version:** [N+1]
**Last refined:** [date]
**Refinement history:** See git log for this file.
```

Commit:

```bash
git add [domain]-pdca/references/
git commit -m "refine([domain]-pdca): cycle [N] learnings

[One bullet per accepted change, e.g.:]
- Narrowed STOP trigger: 'skip gate' → 'skip Layer 3 review gate specifically'
- Removed redundant rule: execution sequence was covered by phase-prompts.md
"
```

---

## When Refinement Is Not Warranted

Skip the refinement proposal if:
- The cycle was routine with no discipline issues and no process insights
- All retrospective insights are "keep doing" (existing rules are working)
- The most recent refinement was less than 2 cycles ago and the changes haven't been tested yet

In these cases, state: "No refinements proposed this cycle. Existing working agreements remain at version [N]."

---

## Refinement Failure Modes

**Rewrite instead of diff** — If a proposed change touches more than 30% of a section,
it is a rewrite, not a refinement. Break it into smaller targeted changes or defer to
a dedicated skill revision session using `/skill-creator`.

**Adding without pruning** — Any addition that does not identify a corresponding removal
or consolidation violates the anti-drift rule. Revise before presenting to human.

**Vague motivation** — "This rule wasn't working well" is not a valid reason.
The motivation must reference a specific moment in the retrospective.

**Approval without review** — The human must read each before/after pair.
Do not present diffs as a batch and ask for blanket approval.

---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution.

**Source:** [PDCA Framework Repository](https://github.com/kenjudy/pdca-framework)

---
*2026*
