# Act Phase: Session Analysis & Process Improvement

**Purpose:** Analyze collaboration effectiveness and identify process improvements
**When to use:** At the end of every coding session, regardless of scope
**Prerequisites:** Completed work session (successful or not)
**Expected output:** Critical moments analysis, actionable insights, working agreement updates
**Typical duration:** 5-10 minutes
**Next step:** Update working agreements and process templates based on learnings
**Critical:** Capture learnings while session details are fresh

---
## 5. Retrospection

```markdown
Let's retrospect on our coding session. Please address whichever of these areas seem most relevant:

**Session Overview:** What was our main goal and scope?

**Critical Moments Analysis:** 
- What were the 2-3 moments where our approach most impacted success/failure?
- What specific decisions or interventions were game-changers?

**Technical & Process Insights:** 
- What patterns in our collaboration most impacted effectiveness?
- What would have accelerated progress?
- What process elements worked well vs. need improvement?

**Collaboration Analysis:**
- Where did process discipline break down (if it did)?
- How effective was the "process police" intervention?
- What communication patterns helped vs. hindered progress?

**Top 3 Actionable Insights:**
1. **Start doing:** What prompting/guidance practice should you implement next time?
2. **Stop doing:** What setup/intervention approach should you eliminate?  
3. **Keep doing:** What guidance pattern was most valuable and should be protected?


**Next Session Setup Decisions:**
- **Process boundaries:** What rules should be non-negotiable vs. flexible?
- **Intervention triggers:** What specific behaviors should prompt immediate correction?  
- **Success metrics:** How will we know the process is working in the first 30 minutes?
- **Escape hatches:** When is it acceptable to deviate from the established process?
- **Discipline balance:** How can we maintain discipline while staying flexible?

Finally, **If you could only change ONE thing about our collaboration approach, what would it be and why?**

```

---

## License & Attribution

This template is part of the Human-AI PDCA Collaboration Process framework.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Process framework developed by [Ken Judy](https://github.com/kenjudy) with Claude Anthropic 4

**Usage:** You are free to use, modify, and distribute this template with appropriate attribution. 

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

---
*2025*


---

# Beads Integration (Optional)

**If beads is configured**, store retrospective learnings for future cycles:

## Capture Retrospective

```bash
# Add retrospective to epic
bd update [epic-id] --add-message "$(cat <<'EOF'
## Retrospective

**Session goal:** [original objective]

**What worked:**
- [Specific practices/decisions that accelerated progress]
- [Tools/patterns that proved valuable]

**What to improve:**
- [Process breakdowns or inefficiencies encountered]
- [Knowledge gaps that slowed implementation]

**Key insights:**
- [Architectural learnings]
- [Testing strategies discovered]
- [Gotchas to remember for similar features]

**Action items for next cycle:**
1. [Specific improvement to working agreements/prompts]
2. [Tool/setup to add]
3. [Pattern to reuse]
EOF
)"
```

## Tag and Close Epic

```bash
# Mark epic complete
bd close [epic-id]

# Optional: Add searchable metadata
bd update [epic-id] --metadata pdca_complete=true,domain=auth,complexity=medium
```

## Search Past Retrospectives

When starting new work, learn from past cycles:

```bash
# Find retrospectives about similar features
bd list --closed --type epic | grep -i [domain]

# Read full retrospective
bd show [epic-id]

# Find patterns
bd list --closed --metadata domain=auth
```

**Why use beads in ACT phase:**
- Retrospectives are searchable (not buried in chat history)
- Future PDCA cycles can reference past learnings
- Team members can discover solutions to similar problems
- Builds institutional knowledge over time

---

**PDCA Cycle Complete!**

Your analysis, implementation steps, and retrospective are now:
- ✓ Stored in git (.beads/dolt/)
- ✓ Searchable via `bd` commands
- ✓ Preserved across sessions
- ✓ Available to future work

Run `bd list --closed --type epic` to see your completed PDCA cycles.
