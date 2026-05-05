# Structured AI-Assisted Client Status Reporting Process

## The Core Problem

Your current process has two failure points that compound each other:

1. The review step gets compressed because data collection and writing take longer than expected, leaving little buffer before the Friday noon deadline.
2. Risks get undersold because by the time you are writing under time pressure, there is psychological incentive to minimize friction rather than surface uncomfortable information.

AI can help you fix both by shifting work earlier in the week and by separating risk identification from report drafting so risks are surfaced before the writing pressure sets in.

---

## Weekly Rhythm (Tuesday through Friday)

### Tuesday: Data Pull and Normalization (30-45 minutes)

**What you do:**
- Export raw data from your project tracking tool, time billing system, and Jira.
- Drop the exports into a working folder.

**Where AI helps:**
Paste the raw data into your AI assistant with this prompt:

> I have three data sources for [Client Name] for the week of [date]. Here is the project tracking export: [paste]. Here is the time billing data: [paste]. Here is the Jira export: [paste].
>
> Please produce a normalized summary table with these columns: Workstream, Planned Hours, Actual Hours, Variance, Jira Tickets Closed, Jira Tickets Open, Blockers Noted in Data.
>
> Flag anything where actual hours exceeded planned by more than 15%, any ticket that has been open more than two weeks without status change, and any blocker mentioned in more than one source.

**Output:** A normalized data summary you can review and correct in 10 minutes. Save this as `[client]-week-[date]-data.md`.

---

### Wednesday: Risk Identification (Separate Step, 20-30 minutes)

This is the step you should add. Do not combine risk identification with report writing.

**What you do:**
Review the normalized data summary with fresh eyes.

**Where AI helps:**
Paste the normalized summary and use this prompt:

> You are a senior project manager reviewing engagement data for a client. Your job is to identify risks, not to write a status report. Do not soften findings.
>
> Here is the normalized data: [paste from Tuesday]
>
> Please produce a risk register with these columns: Risk Description, Evidence from Data, Likelihood (High/Medium/Low), Impact (High/Medium/Low), Suggested Mitigation.
>
> Then write a one-paragraph "honest assessment" that you would tell a colleague privately, not a client-facing version. What would you be worried about if this were your engagement?

**Why this matters:** The "honest assessment" prompt forces the AI (and you) to surface what the data actually says before the framing instinct kicks in. You will not publish this paragraph, but reading it helps you calibrate how much to soften the client-facing risks section.

**Output:** A risk register plus the private honest assessment. Share the risk register with the account lead on Wednesday afternoon with a short note: "Flagging these before I write the report. Anything here you want to reframe or escalate?"

**This is your early review checkpoint.** The account lead responds to a focused risk document, not a draft report, which is much faster to review and harder to wave through.

---

### Thursday Morning: Report Draft (45-60 minutes)

By now you have: normalized data, a reviewed risk register, and account lead input on risks.

**Where AI helps:**
Use this prompt:

> Write a client status report for [Client Name] for the week ending [date].
>
> Use this structure:
> - Executive Summary (3-5 sentences, factual)
> - Accomplishments This Week (bulleted, sourced from data only)
> - Metrics (include the normalized table)
> - Risks and Mitigations (use the approved risk register, do not soften unless the account lead specifically directed a reframe)
> - Next Week's Priorities
> - Open Questions for Client
>
> Here is the normalized data: [paste]
> Here is the reviewed risk register: [paste]
> Account lead notes: [paste any feedback received Wednesday]
>
> Tone: direct, professional, consultative. Avoid vague positive framing. Do not say things like "we are making good progress" without citing specific evidence.

**Output:** A draft report. Review it yourself for accuracy. The AI will sometimes hallucinate a positive spin; correct those before sending to the account lead.

---

### Thursday Afternoon: Final Review (Account Lead Reviews Full Draft)

Send the account lead the draft with a clear ask:

> Draft attached. Risk section reflects what we discussed Wednesday. I need your approval or edits by [specific time, e.g., 9am Friday]. If I do not hear back by then, I will send as-is or hold, whichever you prefer as a default.

Set a default in advance with your account lead: "send as-is if no response" or "hold if no response." This eliminates the ambiguity that leads to rushed decisions.

---

### Friday Morning: Final Polish and Send (15 minutes)

- Incorporate any account lead edits.
- Run a final AI check:

> Review this report for: (1) any claim not supported by the data we started with, (2) any risk that appears in the data but is absent from the risks section, (3) any vague positive language unsupported by evidence. List issues only, do not rewrite.

- Fix any flagged issues.
- Send by noon.

---

## Structural Changes to Make Now

**1. Create a standing Wednesday calendar block** for risk identification. Treat it as non-negotiable. This is the step that prevents underselling.

**2. Establish a "risk review first" norm with the account lead.** Frame it as: "I want to give you more lead time on the hard stuff, so I'm going to flag risks on Wednesday and send the full draft Thursday." Most account leads prefer this.

**3. Build a client-specific risk taxonomy.** After two or three weeks of using this process, you will notice recurring risk categories for each client. Keep a running list. Add it to your Wednesday prompt: "Also check against these recurring risks for this client: [list]."

**4. Keep a decision log.** When the account lead asks you to reframe a risk, note it: what the data showed, what the client-facing language became, and who made the call. This protects you and creates institutional memory.

---

## Prompt Templates (Ready to Copy)

**Tuesday: Data Normalization**
```
I have three data sources for [Client] for the week of [date].

Project tracking export: [paste]
Time billing export: [paste]
Jira export: [paste]

Produce a normalized summary table: Workstream | Planned Hours | Actual Hours | Variance | Jira Closed | Jira Open | Blockers.

Flag: hours over plan by >15%, tickets open >2 weeks without movement, blockers appearing in multiple sources.
```

**Wednesday: Risk Identification**
```
You are a senior PM reviewing engagement data. Identify risks only, do not write a report.

Data: [paste normalized summary]

Produce a risk register: Risk Description | Evidence | Likelihood | Impact | Mitigation.

Then write one paragraph as an honest private assessment: what would you actually be worried about here?
```

**Thursday: Report Draft**
```
Write a client status report for [Client], week ending [date].

Structure: Executive Summary, Accomplishments, Metrics (include table), Risks and Mitigations, Next Week Priorities, Open Questions.

Data: [paste]
Risk register (reviewed): [paste]
Account lead notes: [paste]

Tone: direct, professional, evidence-based. No vague positive framing without supporting data.
```

**Friday: Final Check**
```
Review this report for:
1. Claims not supported by the source data
2. Risks visible in the data but missing from the risks section
3. Vague positive language without evidence

List issues only. Do not rewrite.
```

---

## What This Process Does Not Solve

- If the account lead is consistently unavailable Wednesday and Thursday, the review problem is a relationship and expectation-setting problem, not a process problem. You may need a direct conversation about what happens when reviews are not completed in time.
- AI will not catch political risks, relationship risks, or context it does not have. The honest assessment prompt helps, but you still need to add judgment about things not in the data.
- This adds structure on Tuesday and Wednesday. If those days are already fully booked, you need to protect time or the Friday crunch will persist.
