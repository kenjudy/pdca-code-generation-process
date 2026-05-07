# Phase Prompts — Daily Retro PDCA

---

## PLAN Phase — Set the Stage & Gather Data

**Purpose:** Frame the retrospection period, establish mindset, and gather all available data.
**Duration:** 15-20% of total cycle time
**Done when:** All available sources from the cycle period have been read; prior retro and commitment status surfaced; human confirms the data picture is sufficient and they are ready to reflect.

### Steps

1. **Set the stage** — Confirm the cycle period (last day or last week). Ask:
   "What do you most want to learn or understand from this period?"

2. **Accountability first** — Before reading any new data, locate the prior retro record
   (Obsidian vault retro log or previous session notes). Present each prior commitment and ask:
   - Did you do this?
   - What did you learn from doing it or not doing it?
   Do not proceed to new data until each prior commitment has an answer.

3. **Gather data from all available sources** for the confirmed cycle period:
   - Slack: read messages sent and received (Slack MCP tools)
   - Gmail: read sent and received email (G Suite MCP tools)
   - Google Calendar: read meetings and events attended (G Suite MCP tools)
   - Granola: read meeting transcripts (Granola MCP tools)
   - Obsidian vault: read notes created or modified during the cycle period (filesystem)

4. **Data summary** — Present a concise factual summary of what was gathered: key threads,
   meetings, notes, and interactions. Draw no conclusions. Ask:
   "Does this feel like a complete picture of the period? Anything missing?"

5. **Human review gate** — Human confirms the data picture is sufficient before proceeding.

> **STOP:** Do not move to DO phase until prior commitments have been reviewed
> and the human has confirmed the data is complete.

---

## DO Phase — Generate Insights

**Purpose:** Surface patterns through Socratic dialogue. Human decides which are meaningful.
**Duration:** 40-50% of total cycle time
**Done when:** Human has named which observations feel significant; all relevant lenses explored.

### Before Starting

- [ ] PLAN phase approved: data gathered and prior commitments reviewed
- [ ] Human has stated their intention for this retro
- [ ] No conclusions drawn yet — only data summarized

### Socratic Exploration

Work through each lens using questions only. Do not interpret for the human.
Ask one question at a time. Wait for the full response before asking another.

**Interactions with people:**
- What moments of connection or friction with others stand out from this period?
- Where did you feel most effective in how you showed up with someone? Least effective?
- Is there a pattern in how you engaged that you notice across multiple interactions?

**Leadership:**
- Where did you create clarity or direction for others this period?
- Where did you feel the weight of a decision you made?
- What would you do differently in a leadership moment from this period?

**Software development:**
- What technical decisions did you make? How do you feel about them in retrospect?
- Where did craft or quality matter most this period?
- What slowed you down, and what does that tell you?

**Consulting:**
- Where did you add the most value for a client or colleague?
- What did a client or stakeholder need that you did not fully deliver?
- What would a more effective version of you have done differently?

**Writing and authorship:**
- What did you write, create, or communicate that you are proud of?
- Where did you leave ideas unexpressed that wanted to be said?

### Mandatory Human Gates

- GATE: After each lens, ask "Which of these observations feels most significant to you?"
  before moving to the next lens.
- GATE: After all lenses, ask "Of everything we surfaced, what 2-3 observations feel
  most alive for you right now?" Present these back for confirmation before moving to CHECK.

> **STOP:** If the AI draws a conclusion, names what the human should focus on, or proposes
> an action — stop immediately. Restate this prompt and continue with questions only.

---

## CHECK Phase — Decide What to Do

**Purpose:** Arrive at 1-3 achievable actions through Socratic interrogation. Human owns all commitments.
**Duration:** 20-30% of total cycle time

### Verification Checklist

- [ ] Prior cycle commitments reviewed and each accounted for
- [ ] At least one observation surfaced that surprised or energized the human
- [ ] 1-3 achievable actions identified by the human through Socratic dialogue (not proposed by AI)
- [ ] Each action is specific enough to know whether it was done
- [ ] Each action fits within the next cycle period

### Arriving at Actions (Socratic Only)

For each significant observation the human named in DO phase, ask in sequence:

1. "What would you want to do differently because of this?"
2. "What is one specific thing you could try in the next [day/week] that would address this?"
3. "How will you know if it worked?"
4. "Is that achievable in the next cycle, or does it need to be smaller?"

Hold to 1-3 actions. If the list exceeds 3, ask:
"If you could only act on one of these in the next cycle, which matters most right now?"

### Failure Mode Check

- [ ] AI did not propose or suggest any actions — human arrived at all commitments independently
- [ ] List is 1-3 items, not a laundry list
- [ ] Each action has a clear signal for knowing whether it was done
- [ ] Actions are specific, not generic ("send a follow-up note to X by Friday" not "communicate better")

### Process Audit

- [ ] Human owned every non-delegable decision
- [ ] Accountability for prior commitments addressed before new ones were made
- [ ] Scope stayed within the confirmed cycle period

> If any check fails, return to DO or PLAN phase as needed. Do not close the retro with known deficiencies.

---

## ACT Phase — Close & Refine

**Purpose:** Record commitments, close the retro, and propose skill refinements.
**Duration:** 5-10 minutes

### Close the Retro

1. Read back the 1-3 commitments the human named. Ask: "Is this an accurate record of what you are committing to?"
2. Ask: "Where will you record these so they are findable at the next retro?"
3. Ask: "Anything else before we close?"
4. Record the retro summary: date, cycle period covered, prior commitments reviewed, new commitments made.

### Retrospective on the Retro

Address each area briefly:

**Cycle overview:** What period was covered? Which sources were available and read?

**Critical moments:** What 2-3 moments in the reflection most moved the conversation forward?

**Process insights:**
- What worked well in this retro structure and should be protected?
- What slowed the reflection or reduced its quality?
- Where did the Socratic approach work well? Where did it feel forced or repetitive?

**Top 3 actionable insights for the skill:**
1. Start doing: [specific practice to add]
2. Stop doing: [specific practice to remove or reduce]
3. Keep doing: [specific practice already working]

### Skill Refinement (Mandatory)

After completing the retrospective, propose specific refinements to the skill files as discrete diffs.
Each refinement must:
- Be one discrete change with a stated reason
- Not increase total skill length by more than 10 net lines
- For every addition, identify something to narrow or remove
- Require explicit human approval before being written

See `references/working-agreements.md` for version history and refinement rules.
