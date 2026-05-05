# Working Agreements: Client Status Reporting

These agreements define the exact division of labor between human and AI for every reporting cycle.
They are binding — the AI does not proceed past a gate without explicit human sign-off.

## Division of Labor

### AI Does

- Accepts raw exports: TargetProcess CSV, BillQuick CSV, Jira ticket list (CSV or paste)
- Formats metrics into a structured table matching the standard report template
- Computes and displays the billable hours vs. sprint velocity ratio for anomaly detection
- Drafts the full risks section — each risk must include all four fields: description, severity
  (High/Medium/Low), mitigation action, and named owner
- Drafts the accomplishments section from completed Jira tickets
- Drafts the upcoming milestones section from Jira roadmap items
- Drafts a 3-4 sentence executive summary in plain English (no acronyms, no sprint jargon)
- Drafts the review-request email to Sarah, including a bulleted list of risks flagged High
- Drafts the client-delivery email with report attached

### Human Does

- Provides the three raw exports at the start of each cycle
- Adds any contextual notes about the week (exceptions, client conversations, scope changes)
- Reviews every AI-flagged anomaly and decides: accept the AI interpretation, override it,
  or escalate (see Escalation Rules below)
- Confirms each High-severity risk before it enters the report
- Edits the draft — tone, narrative framing, sensitive issue handling
- Sends the review-request email to Sarah (AI drafts, human sends)
- Incorporates Sarah's review comments; AI may assist with rewriting specific sections
- Gives explicit Gate 4 approval and sends the final report to the client

## Escalation Rules

The AI stops and waits for human input when:

1. Any data discrepancy exceeds 10% (e.g., billed hours vs. sprint point ratio is off by more
   than 10% from the prior-week baseline)
2. A risk is classified as High severity — AI presents it with a recommendation; human confirms
   before it is written into the draft
3. Jira shows a newly opened P0 or P1 bug not previously discussed in any prior report
4. Any data source export is empty or unavailable
5. The draft risks section produces zero entries — AI surfaces the anomaly and asks the human
   to confirm there are genuinely no risks before continuing

The AI does not auto-resolve these situations. It presents the issue, states what it would
recommend, and waits.

## Escalation: Do Not Proceed

These conditions mean stop the cycle entirely and contact the account lead directly:

- Two or more data sources are unavailable simultaneously
- It is Thursday 3pm and Sarah has not responded to the review request — do not send another
  email; call her

## Non-Negotiables

- The account lead (Sarah) must have at least 24 hours with the draft before the final send
- Zero risks in the report is never acceptable — the AI flags this as an error condition
- The executive summary must pass a plain-English check: no acronyms, no sprint terminology,
  readable by a non-technical VP
- The human always sends the final report — the AI never sends directly to the client
- Every risk must have all four fields populated: description, severity, mitigation, owner
  A risk missing any field is incomplete and blocks Gate 3

## Tone and Framing

- Bad news weeks: the human frames the narrative; AI provides structural support only
- Sensitive issues: human decides whether to surface to client or handle internally;
  AI does not include sensitive issues in the draft without explicit human instruction
- Client relationship context: AI does not have it; human adds it as a note before drafting begins
