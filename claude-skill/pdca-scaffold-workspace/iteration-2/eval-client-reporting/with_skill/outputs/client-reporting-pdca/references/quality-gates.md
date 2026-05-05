# Quality Gates — Client Reporting PDCA

## Definition of Done

A cycle is complete when all of the following are true:

1. The report has been sent to the confirmed client contact(s) before Friday 5 PM. "Sent"
   means delivered to the client's inbox — not drafted, not in review, not scheduled.

2. All metrics fields are populated with sourced data. No placeholder text, no "TBD",
   no fields left blank. Each metric includes the source (tool name, date range, export date).

3. Every risk listed in the report includes a cited source: a ticket number, a standup
   date, or a named document. No risk appears that cannot be traced to a concrete artifact.

4. The account lead has explicitly reviewed and approved the report before it was sent.
   "Explicitly" means a recorded or witnessed approval — not inferred from silence,
   not assumed because individual sections were approved earlier.

5. The report matches the firm's template exactly: correct header format, section order
   (metrics, status narrative, risks, recommendations), and tone consistent with the
   client relationship tier.

## Common Failure Modes

Watch for these and treat them as quality failures requiring remediation:

- **Stale metrics** — Metrics sourced from the wrong sprint, the wrong week, or not
  updated since the previous report. Indicator: source date on the metric does not match
  the reporting period. Remediation: re-pull from the confirmed source for the correct
  date range.

- **Unsourced risks** — Risks included based on team opinion or informal conversation
  without a traceable artifact. Indicator: risk row has no ticket number, date, or
  document reference. Remediation: either find and add the citation, or remove the risk
  and flag it for the account lead to handle through a different channel.

- **Skipped account lead review** — Report sent without explicit send approval. Indicator:
  no documented approval before send (no reply, no message, no verbal confirmation on record).
  Remediation: this is a process failure regardless of report quality — flag it in the ACT
  retrospective and reinforce the send gate for the next cycle.

- **Vague recommendations** — Recommendations that do not specify who acts, what they do,
  or by when. Indicator: language like "we will monitor", "the team should consider", or
  "additional review may be needed". Remediation: return to the account lead for specific,
  actionable language with an owner and a timeframe.

- **Wrong contact list** — Report addressed to a contact not confirmed for this cycle.
  Indicator: recipient differs from the contact confirmed in the PLAN phase. Remediation:
  if already sent, notify the account lead immediately; do not attempt to recall without
  account lead direction.

## Gate Escalation

If a quality gate cannot be passed:

1. Identify the specific gap — name which gate failed and what evidence is missing
2. Return to DO phase to address the specific gap — do not rework unrelated sections
3. Do not reduce the quality bar to make the gate pass — fix the work instead
4. If the gap cannot be resolved within the cycle (e.g., a data source is unavailable),
   escalate to the account lead with a specific question: "I cannot source the [metric]
   because [reason]. Options are: (a) note as unavailable with an explanation, (b) use
   last week's figure with a footnote, or (c) delay the send. Which do you prefer?"
   The account lead decides; the AI executes the chosen option.
