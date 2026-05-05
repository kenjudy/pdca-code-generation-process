# Phase Prompts — Podcast Production PDCA

---

## PLAN Phase

**Purpose:** Understand the episode context and define the production approach for this cycle.
**Duration:** Approximately 15-20% of total cycle time (typically 30-60 minutes per episode)
**Done when:** Host has reviewed the raw transcript, selected 3-5 key insights, confirmed the episode angle and framing, and approved the production plan. AI has all inputs needed to begin drafting.

### Steps

1. **Context gathering** — What is the current state of this episode?
   Gather: the raw interview transcript (or recording ready for transcription), guest name and bio,
   any pre-interview notes or topic list the host prepared, and the previous episode's show notes
   as a voice/format reference.

2. **Transcript review** — AI transcribes or ingests the transcript, then presents a structured
   brief to the host:
   - Guest name, title, company
   - Main topics covered (with timestamps)
   - Candidate key insights (AI surfaces 6-8 options, host selects 3-5)
   - Any segments flagged as potentially unusable (audio quality, tangents, off-record content)

3. **Insight selection and angle confirmation** — Host selects the 3-5 key insights from the
   candidate list and states the episode angle (the one sentence framing of why this conversation
   matters to the B2B SaaS audience). AI does not proceed until this is explicit.

4. **Constraint identification** — What constraints apply to this cycle?
   (Publication deadline, guest embargo, platform-specific format requirements, episode length target)

5. **Approach definition** — Given the selected insights, angle, and constraints, state the
   production plan in specific terms:
   - Show notes structure: summary paragraph, 3-5 key takeaways, guest bio, resource links
   - LinkedIn post angle: which insight leads, target word count
   - Twitter/X thread angle: how many tweets, what the hook is
   - Chapter markers: how many, sourced from which segments

6. **Human review gate** — Present the production plan to the host for approval before executing.
   The host confirms or redirects. Do not proceed to DO without explicit approval.

> **STOP:** Do not begin drafting any asset until the host has approved the insight selection,
> episode angle, and production plan.

---

## DO Phase

**Purpose:** Execute the approved production plan with discipline and defined host checkpoints.
**Duration:** Approximately 60-70% of total cycle time (typically 2-4 hours per episode)
**Done when:** All draft assets exist (show notes draft, LinkedIn draft, Twitter/X draft, chapter markers), each has been through one AI revision pass, and the host has a complete review package assembled.

### Before Starting

- [ ] PLAN phase approved by host
- [ ] Key insights (3-5) confirmed and in writing
- [ ] Episode angle stated in one sentence
- [ ] Scope boundaries clear — no additional platforms or content types without explicit approval

### Execution

1. **Show notes draft** — Using the approved insights and angle, draft show notes with:
   - Opening paragraph that frames why this conversation matters (host voice, not a generic intro)
   - 3-5 key takeaways, each tied to a specific moment in the interview
   - Guest bio section (pulled from public sources, verified)
   - Relevant resource links mentioned in the episode
   - Episode description (100-150 words, SEO-considered, host voice)

2. **Chapter markers** — Generate chapter markers with timestamps from the transcript.
   Each chapter title should be descriptive of the topic, not generic ("Intro", "Chapter 1").

3. **LinkedIn post draft** — Draft a LinkedIn post using the approved leading insight:
   - Opens with a hook that reflects the host's voice
   - Surfaces one or two supporting insights from the episode
   - Closes with a specific call to action (listen, comment, share)
   - All quotes must be verbatim from the transcript — no paraphrasing presented as quotes

4. **Twitter/X thread draft** — Draft a Twitter/X thread:
   - Tweet 1: hook (insight or provocative question from the episode)
   - Tweets 2-6: supporting points, one per tweet, each self-contained
   - Final tweet: link to episode with brief CTA
   - All quotes verbatim from transcript

5. **AI self-review pass** — Before assembling the host review package, AI reads each draft
   and flags: any place the voice feels generic, any claim not directly supported by the
   transcript, any quote that is not verbatim.

6. **Assembly** — Assemble a host review package: show notes draft, LinkedIn draft,
   Twitter/X thread, chapter markers, and a self-review notes section listing any
   flags from step 5.

### Mandatory Human Gates

Pause and present to the host at each of these points:

- GATE: Before sending any guest quote-approval request, present the proposed quote and context to the host for approval.
- GATE: Before scheduling or publishing the LinkedIn post, present the final draft to the host for explicit approval.
- GATE: Before scheduling or publishing the Twitter/X thread, present the final draft to the host for explicit approval.
- GATE: Before uploading audio to the podcast host platform, present the final audio cue points and episode metadata to the host for approval.

> **STOP:** If the AI skips a gate, produces a social post with a non-verbatim quote,
> selects insights without host confirmation, or expands to unplanned content types — stop immediately.
> Repost this prompt and restart the DO phase from the last completed checkpoint.

---

## CHECK Phase

**Purpose:** Verify quality against the agreed criteria before declaring the episode done.
**Duration:** Approximately 10-15% of total cycle time (typically 20-40 minutes)

### Verification Checklist

- [ ] Edited audio file is approved by the host and uploaded to the podcast host platform
- [ ] Show notes are published to the website, reviewed and approved by the host
- [ ] LinkedIn post is scheduled (not yet sent) and approved by the host
- [ ] Twitter/X thread is scheduled and approved by the host
- [ ] Episode is live and the guest has received a thank-you message with the episode link

### Failure Mode Check

Confirm none of the common failure modes are present:

- [ ] AI-drafted copy losing the host's voice (generic, listicle-style, not specific to the conversation) — not present
- [ ] Any asset published without host final-approval gate — not present
- [ ] Show notes omitting or misattributing a key insight from the guest — not present
- [ ] Social posts making claims the guest did not actually make in the interview — not present
- [ ] Audio going out with a technical flaw the host did not notice — not present

### Process Audit

- [ ] Host owned every non-delegable decision (insight selection, voice approval, final sign-off)
- [ ] All mandatory gates were observed (not skipped "just this once")
- [ ] Scope stayed within the approved production plan (no unplanned platforms or content added)

> If any check fails, return to DO phase. Do not declare done with known deficiencies.

---

## ACT Phase

**Purpose:** Retrospect on the cycle. Propose refinements to this skill. Host approves changes.
**Duration:** 5-10 minutes

### Retrospective

Address each area:

**Cycle overview:** What was accomplished this episode? What was the scope?

**Critical moments:** What 2-3 decisions or interventions most impacted quality or efficiency?

**Process insights:**
- What worked well and should be protected?
- What slowed production or reduced quality?
- Where did process discipline slip (if it did)?

**Voice calibration:** Are AI drafts getting closer to the host's voice, drifting further, or holding steady?
Note specific evidence — a phrase that landed, a correction the host had to make repeatedly.

**Production bottleneck:** Where in the week did the real delay sit — transcript, drafting, or host approval?

**Top 3 actionable insights:**
1. Start doing: [specific practice]
2. Stop doing: [specific practice]
3. Keep doing: [specific practice]

### Skill Refinement (Mandatory)

After completing the retrospective, propose any changes to this skill's working agreements,
phase prompts, or quality gates. Changes must reflect what actually happened in this cycle,
not hypothetical improvements.

Present proposed changes to the host for approval. Do not update the skill files without
explicit host sign-off.

See `references/working-agreements.md` for the current version and refinement rules.
