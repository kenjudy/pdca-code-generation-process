---
name: pdca-scaffold
description: Generates a customized, installable PDCA skill for any complex repeatable human task that benefits from agentic HITL (Human-in-the-Loop) workflows. Use this skill whenever a user wants to create a structured AI-assisted process for a specific domain, design a new agentic workflow, capture and systematize a recurring complex task, or build a collaboration process for non-software work. Triggers on phrases like "create a process for", "build a workflow for", "help me structure", "design a PDCA cycle for", "systematize my", "how should I use AI to help me with", or any request to scaffold a new agentic collaboration pattern. Also use this when someone describes a repeatable task and wants to know how AI can assist with it reliably.
---

# PDCA Scaffold

A tool for generating domain-specific PDCA skills. You describe a complex repeatable task;
this skill guides you through structured discovery, then generates a valid installable Claude
skill tailored to your domain — with a built-in learning loop that sharpens the skill after
each cycle.

## How This Works

**Phase 1: Discovery** — Socratic questioning across 5 layers to understand your task,
how human and AI responsibilities divide, what quality looks like, where intervention is needed,
and what you want to learn from each cycle.

**Phase 2: Generation** — A domain-specific PDCA skill is generated in your project directory.
The skill includes phase prompts, working agreements, quality gates, and intervention triggers
derived directly from your discovery answers.

**Phase 3: Refinement (per cycle)** — After each ACT retrospective in the generated skill,
the refinement protocol proposes specific diffs back to the skill's reference files. You approve
each change. The skill gets sharper without growing longer.

## Start Here

Read `references/discovery-guide.md` and begin Layer 1 questions.
Do not skip layers or combine them — each layer builds on the previous.
The confirmation gate after Layer 5 is mandatory before generating anything.

## After Generation

The generated skill goes in `[domain]-pdca/` in the user's current project directory.
It is committed to the project repo and version-controlled alongside the work it governs.
To validate or optimize the generated skill, use `/skill-creator`.

## Reference Files

- `references/discovery-guide.md` — The 5-layer Socratic question framework with confirmation gate
- `references/generation-templates.md` — Templates for SKILL.md and all references files in the generated skill
- `references/refinement-protocol.md` — The active learning loop: how to propose, approve, and commit skill refinements

## Anti-Patterns to Avoid

**Skipping the confirmation gate** — The summary after Layer 5 is the primary HITL checkpoint.
Errors in the summary propagate into every future cycle. Always present and confirm before generating.

**Generating generic rules** — "The human owns the important parts" is not a working agreement.
Push for specificity: which parts, which decisions, which moments.

**Rewriting instead of refining** — Refinement is a diff, not a rewrite. If the generated skill
needs substantial changes, use `/skill-creator` for a structured revision session.

**Growing the skill longer each cycle** — The anti-drift rule is ≤ +10 net lines per refinement.
For every addition, identify something to narrow or remove.
