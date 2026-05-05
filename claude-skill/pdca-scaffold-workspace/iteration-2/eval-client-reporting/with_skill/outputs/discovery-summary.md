# Socratic Discovery Summary — Client Status Reporting PDCA

**Generated for eval:** iteration-2/eval-client-reporting/with_skill
**Date:** 2026-05-05

This document records the invented realistic discovery answers used to generate the
client-reporting-pdca skill. In a real session, these answers would come from the human
through the five-layer Socratic dialogue.

---

## Layer 1 — Task Essence

**Q1. In one sentence: what is the task, and what does a completed cycle deliver?**

> Weekly client status report — delivers a reviewed, approved, and sent report for each
> of 8 active engagements, containing current metrics, risks flagged since the previous
> week, and account lead recommendations.

**Q2. How often is one full cycle performed?**

> Weekly. Reports are due to clients every Friday by 5 PM. A full cycle covers one client
> engagement. With 8 active engagements, 8 cycles run per week, staggered through
> Wednesday–Friday.

---

## Layer 2 — Human-AI Role Division

**Q3. What parts require human judgment that cannot be delegated to AI?**

> - Account lead narrative: interpreting the relationship health and what to emphasize
>   given the client's mood and recent interactions not captured in project tools
> - Risk framing: deciding whether a risk should be surfaced to the client now or
>   handled internally, based on contractual and political sensitivity
> - Recommendations: the account lead must own every recommendation — AI can draft,
>   but the lead's voice and judgment must drive the final language
> - The decision to send: the account lead must explicitly approve before the report
>   leaves the firm

**Q4. What can AI execute autonomously, with the human reviewing only at defined gates?**

> - Pulling current metrics from project tracking tools (Jira, Harvest, Notion) and
>   formatting them into the report template
> - Drafting the "status since last week" narrative from ticket activity and standup notes
> - Drafting the risks section from flagged items in the project log
> - Formatting the full report draft to match the firm's template
> - Generating a summary of changes from the prior week's report for the account lead's
>   review reference

**Q5. Irreversible or highest-stakes moments the human must own:**

> - Framing a risk as "critical" vs. "watch item" — escalation language cannot be
>   undone once the client reads it
> - Any recommendation involving resourcing, timeline, or budget — these have contractual
>   implications
> - The send decision: once the report is in the client's inbox, it cannot be recalled

---

## Layer 3 — Quality Contract

**Q6. How do you know when one cycle is successfully complete? (3-5 observable signals)**

> 1. The report has been sent to the client contact(s) before Friday 5 PM
> 2. All metrics are present and sourced (no placeholders or "TBD" fields)
> 3. Every risk listed includes evidence (a ticket number, a date, or a standup note) —
>    no speculative risks
> 4. The account lead has reviewed and signed off (explicit approval, not assumed)
> 5. The report matches the firm's template exactly — header, section order, tone

**Q7. Most common failure modes to prevent:**

> - Metrics are stale (pulled from the wrong sprint or wrong week)
> - Risks are listed without evidence — opinion-based flagging that clients challenge
> - Account lead review is skipped "because it looks fine" — the send happens without sign-off
> - Recommendations are vague ("we will monitor the situation") rather than specific
>   and actionable
> - Report goes to the wrong contact list (client contact vs. internal stakeholder confusion)

---

## Layer 4 — Process Shape

**Q8. Phase boundaries:**

> **Analysis done looks like:** The account lead has reviewed the prior week's report,
> confirmed the metrics sources for this week, and named any known risks or context items
> the AI should factor into the draft. The AI has a confirmed scope: which sections to
> draft, what data sources to pull from, and who the client contact is.
>
> **Execution done looks like:** A complete draft exists matching the firm template, all
> metrics are populated with sourced data, the risks section contains only evidenced items,
> and the recommendations section has been written with the account lead's input. The draft
> is ready for the account lead's final review — not yet sent.

**Q9. AI behaviors that should trigger immediate STOP and human intervention:**

> - AI sends or schedules the report without explicit account lead approval
> - AI lists a risk without citing a source (ticket, date, or standup note)
> - AI writes a recommendation involving resourcing, timeline, or budget without human input
> - AI pulls metrics without confirming the data source with the human first
> - AI addresses the report to a contact not explicitly confirmed by the account lead

---

## Layer 5 — Learning Loop

**Q10. Process debt that tends to accumulate:**

> - Skipping the prior-week comparison ("we all know what changed") — leads to drift in
>   risk tracking across weeks
> - Using last week's metrics as a shortcut when the new data is "basically the same"
> - Skipping account lead review when the lead is traveling ("just send it, it's fine")
> - Accumulating vague "watch item" risks that never get resolved or escalated

**Q11. What to learn and improve from each cycle:**

> - Which data sources were hard to pull from — can any be automated or pre-fetched?
> - Which parts of the draft required the most account lead revision — what drafting
>   patterns caused rework?
> - Whether any clients flagged confusion or asked follow-up questions — indicator of
>   clarity failures
> - Whether the Friday deadline was met comfortably or under pressure — indicator of
>   cycle timing issues

---

## Confirmation Summary (as presented to human before generation)

**Task:** Weekly client status report — delivers a reviewed, approved, and sent report for
each active engagement, containing current metrics, risks with evidence, and account lead
recommendations.
**Cycle frequency:** Weekly (8 reports per cycle, due Friday 5 PM)

**Human owns:**
- Account lead narrative and relationship-context interpretation
- Risk framing decisions (surface to client vs. handle internally)
- Every recommendation — AI drafts, lead finalizes
- Risk escalation language (critical vs. watch item)
- Resourcing, timeline, or budget recommendations
- The send decision (explicit approval required before sending)

**AI executes (with review gates):**
- Pulling and formatting metrics from project tracking tools
- Drafting the status narrative from ticket activity and standup notes
- Drafting the risks section from flagged items (with evidence citations)
- Formatting the full report to match the firm template
- Generating a prior-week comparison summary for the account lead's reference

**Done looks like:**
- Report sent to confirmed client contacts before Friday 5 PM
- All metrics present and sourced (no placeholders)
- Every risk has a cited source (ticket, date, or standup note)
- Account lead has explicitly approved (not assumed)
- Report matches firm template exactly

**Common failure modes to prevent:**
- Stale metrics (wrong sprint or wrong week)
- Unsourced risks (opinion-based flagging)
- Skipped account lead review before send
- Vague recommendations
- Wrong contact list used

**Phase boundaries:**
- Analysis done: Account lead has confirmed metrics sources, named known risks and context,
  and the AI has confirmed scope, data sources, and client contact
- Execution done: Complete draft exists matching firm template, all sections populated with
  sourced data, ready for account lead final review (not yet sent)

**STOP triggers:**
- AI sends or schedules report without explicit account lead approval
- AI lists a risk without a cited source
- AI writes a budget/timeline/resourcing recommendation without human input
- AI pulls metrics without confirming the data source
- AI addresses the report to an unconfirmed contact

**Learning loop focus:**
- Data source friction (what can be pre-fetched or automated)
- Drafting patterns that cause account lead rework
- Client confusion signals in follow-up questions
- Friday deadline pressure as a cycle timing indicator

Human confirmed this summary before generation proceeded.
