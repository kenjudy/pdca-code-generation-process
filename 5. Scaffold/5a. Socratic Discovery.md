# Socratic Discovery: Understanding the Task

**Purpose:** Elicit enough about the task to generate a domain-specific PDCA skill
**When to use:** When a user wants to create a structured AI-assisted process for any complex repeatable task
**Expected output:** A confirmed understanding of the task that drives skill generation
**Typical duration:** 10-15 minutes
**Next step:** Generation phase (5b) after human confirms the summary

---

Ask the questions in each layer before moving to the next. Wait for the human's answer before proceeding. Do not combine layers.

## Layer 1 — Task Essence

Ask both questions together:

```
Let's understand the task you want to systematize.

1. In one sentence: what is the task, and what does a completed cycle deliver?
   (For example: "Weekly client status report — delivers a reviewed, sent report with metrics and risks.")

2. How often is one full cycle performed?
   (daily / weekly / monthly / quarterly / on-demand / event-triggered)
```

---

## Layer 2 — Human-AI Role Division

After Layer 1 is answered, ask:

```
Now let's map who owns what.

3. What parts of this task require human judgment that cannot be delegated to AI?
   (Think: decisions that depend on relationships, context not in documents, ethical weight, or accountability.)

4. What parts can AI execute autonomously, with the human reviewing only at defined gates?
   (Think: research, drafting, formatting, data gathering, summarizing.)

5. What are the irreversible or highest-stakes moments — decisions the human must own,
   where a mistake is costly or hard to undo?
```

---

## Layer 3 — Quality Contract

After Layer 2 is answered, ask:

```
Now let's define what "done well" looks like.

6. How do you know when one cycle is successfully complete?
   Name 3-5 specific, observable signals. Not "it feels right" — what would you point to?

7. What are the most common failure modes you want this process to prevent?
   (What goes wrong when the task is done badly or skipped?)
```

---

## Layer 4 — Process Shape

After Layer 3 is answered, ask:

```
Let's define the phase boundaries and intervention points.

8. What are the natural phases in this task?
   Describe what "analysis done" looks like (before execution begins) and
   what "execution done" looks like (before you verify quality).

9. What behaviors by the AI should trigger an immediate STOP and human intervention?
   (Think: scope creep, skipping a step, making assumptions about stakeholders,
   producing output without a required review gate.)
```

---

## Layer 5 — Learning Loop

After Layer 4 is answered, ask:

```
Finally, let's design the improvement loop.

10. What process debt tends to accumulate when this task is done repeatedly?
    (What shortcuts get taken, what steps get skipped "just this once"?)

11. What do you want to learn and improve from each cycle?
    (What would make the next cycle faster, higher quality, or less stressful?)
```

---

## Confirmation Gate

After all five layers, present a structured summary and require explicit confirmation before generating the skill:

```
Here is my understanding of the task. Please confirm before I generate the skill.

**Task:** [one-sentence description]
**Cycle frequency:** [answer from Layer 1]

**Human owns:**
- [list from Layer 2, Q3 and Q5]

**AI executes (with review gates):**
- [list from Layer 2, Q4]

**Done looks like:**
- [signals from Layer 3, Q6]

**Common failure modes to prevent:**
- [list from Layer 3, Q7]

**Phase boundaries:**
- Analysis done: [from Layer 4, Q8]
- Execution done: [from Layer 4, Q8]

**STOP triggers (immediate human intervention):**
- [list from Layer 4, Q9]

**Learning loop focus:**
- [from Layer 5, Q10 and Q11]

Does this accurately capture what you want to systematize?
Correct anything before I proceed — especially the STOP triggers and human ownership lines,
as those become the non-negotiable intervention points in the generated skill.
```

Only proceed to generation after the human explicitly confirms or corrects this summary.

---

## Design Notes

**Why layers, not a single form:** Each layer builds on the previous. Human-AI division (Layer 2)
only makes sense after the task is understood (Layer 1). STOP triggers (Layer 4) only make sense
after quality signals are defined (Layer 3). Sequential layers produce more considered answers.

**Why require confirmation:** The summary is the primary HITL gate in the scaffold process.
The generated skill's working agreements and intervention triggers come directly from this summary.
Errors here propagate into every future cycle.

**What makes answers too vague to proceed:**
- "The human owns the important parts" — ask which parts specifically
- "It's done when it looks good" — ask what observable signals indicate quality
- "Stop if something seems wrong" — ask for concrete behaviors that signal a problem

If answers are vague, ask one clarifying follow-up per vague answer before generating the summary.

---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution.

**Source:** [PDCA Framework Repository](https://github.com/kenjudy/pdca-framework)

---
*2026*
