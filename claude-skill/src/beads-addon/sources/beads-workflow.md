# Beads Workflow Reference

> Load this during active PDCA sessions when beads is installed.

## PDCA → Beads Mapping

| PDCA Phase | Beads Task Type | Purpose |
|------------|----------------|---------|
| **PLAN** | Epic | Capture analysis, store approach decisions |
| **DO** | Subtasks | Track individual TDD steps |
| **CHECK** | Verification | Validate completeness against plan |
| **ACT** | Retrospective | Store learnings for future cycles |

---

## Phase Workflows

### PLAN: Create Epic

```bash
bd create "Feature: [goal description]" --type epic
# Returns: [prefix]-a1b2 (your epic ID)

bd update [epic-id] --add-message "$(cat <<'EOF'
## Analysis Summary
- [Key architectural patterns discovered]
- [Chosen approach and rationale]
- [Dependencies identified]

## Acceptance Criteria
- [ ] [Observable outcome 1 — user-visible or test-verifiable]
- [ ] [Observable outcome 2]
- [ ] [Edge cases explicitly handled or deferred]

## Out of Scope
- [What this cycle explicitly does NOT cover]

## Resumption Context
- Start point: [file:line or entry command to begin next session]
- Key constraint: [the thing most likely to trip up a fresh session]
- Open questions: [anything unresolved at session end, or "none"]
EOF
)"
```

**Save the epic ID** — you'll reference it in DO, CHECK, and ACT.

---

### DO: Track TDD Steps

**Before each TDD iteration:**

```bash
bd create "Step [N]: [description]" --parent [epic-id] --type task
bd update [task-id] --claim --status in_progress
bd update [task-id] --add-message "$(cat <<'EOF'
Before: [current behavior or failing test name]
After: [expected behavior when this step is done]
Done when: [specific test passes or explicit verifiable condition]
EOF
)"
```

**After RED → GREEN → REFACTOR:**

```bash
bd close [task-id] --message "✓ Tests pass, committed [hash]"
```

**Review progress:**

```bash
bd list --parent [epic-id]
bd list --parent [epic-id] --status in_progress
```

---

### CHECK: Validate Completeness

```bash
bd list --parent [epic-id]                              # All subtasks
bd list --parent [epic-id] --status open,in_progress    # Incomplete work
bd show [epic-id]                                       # Full context
```

All planned subtasks closed? No tasks in-progress? → Proceed to ACT.

---

### ACT: Store Retrospective

```bash
bd update [epic-id] --add-message "$(cat <<'EOF'
## Retrospective
**What worked:** [practices that accelerated progress]
**What to improve:** [process breakdowns or inefficiencies]
**Key insights:** [architectural learnings, gotchas]
**Action items:** [1-3 improvements for next cycle]
EOF
)"

bd close [epic-id]
```

---

## Cross-Session Continuity

```bash
bd ready          # Tasks with no blockers
bd show [epic-id] # Full context: analysis, subtasks, messages, dependencies
```

---

## Common Commands

```bash
# Create
bd create "Title" --type epic|task|bug|feature
bd create "Subtask" --parent <id>

# Manage
bd ready                        # No-blocker tasks
bd list --status open           # Filter by status
bd show <id>                    # Detail view
bd update <id> --status in_progress
bd close <id>

# Dependencies
bd dep add <blocked> <blocker> blocks
bd blocked

# Search past cycles
bd list --closed --type epic | grep -i [domain]
```

---

## Git Integration

```bash
git add .beads/
git commit -m "Complete [feature] epic ([epic-id])"
git push
```
