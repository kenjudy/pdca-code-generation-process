---

# Beads Integration (Optional)

**If beads is configured and you have an epic ID from PLAN phase**, track TDD progress:

## Before Each TDD Step

```bash
# Create subtask for this TDD iteration
bd create "Step [N]: [description]" --parent [epic-id] --type task

# Example: bd create "Step 1: Write failing test for JWT middleware" --parent PDCA-a1b2

# Claim and mark in progress
bd update [task-id] --claim --status in_progress
```

## After RED → GREEN → REFACTOR

```bash
# Close task with commit reference
bd close [task-id] --message "✓ Tests pass, committed [hash]"

# Example: bd close PDCA-a1b2.1 --message "✓ Tests pass, committed abc123"
```

## Track Blocked Work

If a step reveals a dependency:

```bash
# Create blocker task
bd create "Blocker: [issue description]" --type bug

# Link dependency
bd dep add [current-task-id] [blocker-id] blocks
```

**Why use beads in DO phase:**
- Each TDD cycle has discrete task with clear done criteria
- Dependency graph shows implementation sequence
- Easy to resume after interruption
- Commit hashes linked to tasks for traceability

**Review progress anytime:**

```bash
bd list --parent [epic-id]           # See all subtasks
bd list --parent [epic-id] --status in_progress  # Current work
```

---

**Next**: When all planned steps complete, proceed to CHECK phase.
