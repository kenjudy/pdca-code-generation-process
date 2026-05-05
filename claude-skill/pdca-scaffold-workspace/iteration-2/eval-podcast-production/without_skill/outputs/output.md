# AI-Assisted Podcast Production: A Repeatable Process for Show Notes and Social Posts

## The Core Problem

You have two bottlenecks: show notes and social posts. They take too long and the quality is inconsistent. The inconsistency usually comes from starting from scratch each time, with no defined standard for what "good" looks like. The time cost comes from writing when you should be editing AI output.

This process flips your workflow: AI drafts, you edit and approve. You stay in control of every editorial decision, but you're no longer staring at a blank page.

---

## What You Need Before Starting

**A transcript.** If you don't already have one, use Whisper (free, local), Descript, or Otter.ai. Clean transcription is the foundation everything else builds on.

**A style reference document** (one-time setup). Before you use this process the first time, spend 30 minutes writing down:
- Your show's point of view and tone (conversational? authoritative? skeptical?)
- 3-5 example show notes you're proud of, with notes on what makes them work
- Your social post voice on each platform (LinkedIn vs. Twitter/X vs. elsewhere)
- Topics and angles you deliberately avoid
- Terminology specific to your show or guest niche

Keep this as a plain text file. You'll paste it into every AI prompt as context.

---

## The Workflow: Steps 1-4 Stay the Same

Record, transcribe, edit audio -- no changes there. The process changes at step 4.

---

## Step 4: Extract Before You Write

Before touching show notes or social posts, do a 15-minute extraction pass on the transcript.

Run this prompt:

```
You are helping produce a B2B SaaS podcast. Here is the transcript from this episode:

[PASTE TRANSCRIPT]

Extract the following. Be specific and direct -- no filler:

1. The guest's central argument or main claim (one sentence)
2. The 3-5 most specific, actionable, or counterintuitive things they said
3. Any data points, numbers, or named frameworks they referenced
4. The sharpest quote in the episode (something that would make someone stop scrolling)
5. Any moments where the host and guest disagreed or pushed back
6. What problem this episode solves for a B2B SaaS operator

Do not write prose. Use bullet points. Quote the transcript directly where possible.
```

Review what comes back. Mark the 2-3 points that resonate most with you. Add anything the AI missed. This extraction becomes your source material for everything else.

---

## Step 5: Show Notes

**Target time: 20 minutes (5 AI, 15 you)**

Run this prompt, pasting in your extraction output and style reference:

```
You are writing show notes for a B2B SaaS podcast. Here is context about the show's voice and standards:

[PASTE YOUR STYLE REFERENCE DOCUMENT]

Here is the extracted key content from this episode:

[PASTE EXTRACTION OUTPUT]

Write show notes with this structure:
- Opening paragraph (2-3 sentences): What is this episode about and why does it matter right now?
- What you'll learn (3-5 bullet points, each one specific and outcome-oriented)
- Episode highlights (3-4 paragraphs, each built around one key idea from the extraction)
- Guest bio (2-3 sentences, professional, no superlatives)
- Resources mentioned (leave as [TO BE FILLED] if not in the extraction)

Write in [YOUR TONE]. Do not use the words "delve", "dive", "journey", "transformative", or "game-changer". Do not start any paragraph with "In this episode".

Target length: 400-600 words.
```

When you get the draft back:

1. Read it once straight through, marking anything that feels off-tone or inaccurate
2. Fix factual errors first (the AI may misremember something from the extraction)
3. Rewrite any paragraph that doesn't sound like you -- don't just tweak words, rewrite the idea in your voice
4. Check the opening paragraph: it should make someone want to listen, not summarize what they already know from the title
5. Final read-through for flow

Your 15 minutes is not proofreading -- it is editorial judgment. You are deciding what the episode means and whether the draft captures it.

---

## Step 6: Social Posts

**Target time: 15 minutes (3 AI, 12 you)**

Run this prompt using the same extraction output:

```
You are creating social media content for a B2B SaaS podcast episode.

Show voice and standards:
[PASTE YOUR STYLE REFERENCE DOCUMENT]

Episode extraction:
[PASTE EXTRACTION OUTPUT]

Write 5 social posts:

Post 1 - LinkedIn (long form): A 150-200 word post built around the guest's central argument. Start with a hook that is a specific claim or question, not "I had a great conversation with...". End with one question that invites response.

Post 2 - LinkedIn (short form): The sharpest quote from the episode, formatted as a pull quote. Add 1-2 sentences of context. Under 80 words total.

Post 3 - Twitter/X thread starter: The most counterintuitive thing from the episode as a punchy opening tweet (under 200 characters), plus 3-4 follow-up tweets expanding the idea. Each tweet stands alone.

Post 4 - Twitter/X single: A specific data point or claim from the episode as a standalone tweet. Include the episode name and guest.

Post 5 - Platform of your choice: [SPECIFY PLATFORM]. Write a post optimized for that platform's format and audience expectations.

Do not use hashtag spam. 2-3 relevant hashtags maximum per post.
```

Review each post and ask yourself:
- Does this make someone want to listen, or does it just summarize?
- Is the hook specific, or is it generic B2B SaaS filler?
- Would I actually post this, or does it feel like content marketing?

Rewrite any post where the answer is "no." The AI is giving you a starting structure, not a finished product.

---

## Step 7: Upload and Publish

No change from your current workflow.

---

## The Quality Standard Document (One-Time Setup)

This is the most important thing you can do. Spend time on it once, and it pays back on every episode.

Structure it like this:

```
PODCAST NAME: [Your show]
AUDIENCE: [Who listens and why]
POINT OF VIEW: [What your show believes that others don't]
TONE: [3-5 adjectives, then a sentence or two explaining what they mean in practice]

SHOW NOTES STANDARDS:
- What makes a good opening paragraph (with example)
- What we never do in show notes (list)
- Length target
- Structure we always follow

SOCIAL POST STANDARDS:
- LinkedIn voice (with example post)
- Twitter/X voice (with example post)
- Hooks we avoid (e.g., "I had an amazing conversation...")
- Hooks that work for us (with examples)

WORDS AND PHRASES TO AVOID:
[Your list]

APPROVED FORMATS:
[Any structural patterns you always use]
```

Update this document after any episode where you find yourself rewriting a lot. If you keep making the same corrections, the standard document needs updating.

---

## Calibration: First Three Episodes

The first time you run this process, plan for it to take longer than usual. That is normal and intentional.

After each of the first three episodes:
- Note which AI outputs needed the most rewriting
- Note which prompts produced output closest to what you wanted
- Adjust the prompts and the style reference document accordingly

By episode four, your prompts will be tuned to your show and you will be editing rather than rewriting.

---

## What This Gives You

**Consistency:** Every episode starts from the same structure and the same quality standard. The output varies because the content varies, not because your mood varies.

**Speed:** You eliminate blank-page time. 100% of your time is spent on editorial judgment, which is the part only you can do.

**Control:** You approve everything. Nothing goes out without your review. The AI drafts; you decide.

**A feedback loop:** Every correction you make is information about how to improve the prompts. The process gets faster over time.

---

## Common Failure Modes to Watch For

**Accepting the first draft too quickly.** The AI output is a starting point. If you publish it unchanged, your quality will converge to average.

**Not updating the style reference document.** If you find yourself making the same edits repeatedly, that is a prompt problem, not an AI problem.

**Using the AI for the extraction and trusting it completely.** Read the extraction before you use it. The AI will occasionally surface a mediocre quote and miss the best one.

**Trying to prompt your way to perfection.** Some rewriting is always required. Budget for it. The goal is less rewriting than starting from scratch, not zero rewriting.
