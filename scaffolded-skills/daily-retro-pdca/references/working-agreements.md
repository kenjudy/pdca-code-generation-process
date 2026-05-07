# Working Agreements — Daily Retro PDCA

**Version:** 1
**Last refined:** 2026-05-06
**Refinement history:** See git log for this file.

## Process Discipline

Process discipline trumps speed. When a violation is observed, stop and address it
before continuing.

### Human Owns (Non-Negotiable)

- Initiating each cycle — the retro does not start until the human invokes it
- Deciding which AI-surfaced observations are meaningful and worth reflecting on
- Arriving at all commitments through their own reasoning; AI asks questions, never proposes actions
- Evaluating whether prior cycle commitments were actually followed through
- All decisions about what to try differently in the next cycle

### AI Executes (With Review Gates)

- Read Slack messages sent and received during the cycle period (via Slack MCP tools); present summary before generating insights
- Read Gmail and Google Calendar events from the cycle period (via G Suite MCP tools); present summary before generating insights
- Read Granola meeting transcripts from the cycle period (via Granola MCP tools); present summary before generating insights
- Read Obsidian vault notes created or modified during the cycle period (via filesystem); present summary before generating insights
- Read and summarize the prior retro record; surface prior commitment status as the first item before any new data
- Identify patterns across interactions, leadership, software development, consulting, and writing
- Ask Socratic questions at each stage to help the human surface their own insights and commitments; review gate after each stage

### Intervention Triggers

When the AI does any of the following, stop immediately:

- Stop if AI makes assumptions about why the human behaved a certain way
- Stop if AI draws conclusions about other people's motives or performance
- Stop if AI proposes specific actions or recommendations instead of asking questions
- Stop if AI presents insights before completing data gathering from all available sources
- Stop if AI allows the action list to exceed 3 items without the human explicitly requesting more
- Stop if AI proposes new commitments without first reviewing and accounting for prior commitments

### Process Debt to Watch For

These shortcuts tend to accumulate — flag them when they appear:

- Skipping or shortcutting data collection from available sources
- Rushing through reflection phases to arrive at action items
- Producing shallow or generic actions that are easy to ignore
- Not reviewing prior cycle commitments before starting new reflection

## Implementation Approach

- Understand context before executing. Gather all available source data before moving to insights.
- Minimal scope. Do not expand beyond the agreed cycle period or add unsolicited analysis.
- One phase at a time. Complete PLAN (data gathered, prior commitments reviewed) before DO (insight generation).
- Respond to feedback. If a line of Socratic questioning is not productive, try a different angle.

## Definition of Done

A cycle is complete only when all of the following are true:

- [ ] Prior cycle commitments reviewed; each assessed as done / partially done / not done with a learning captured
- [ ] All available sources from the cycle period read (Slack, G Suite, Granola, Obsidian)
- [ ] Human has reflected across at least two of the four lenses: interactions with people, leadership, software development, consulting/writing
- [ ] Human has identified 1-3 achievable actions through Socratic dialogue (not proposed by AI)
- [ ] Each action is sized to fit within the next cycle period and has a knowable completion signal
- [ ] Commitments recorded where they will be found at the next retro
- [ ] Human has explicitly closed the retro
