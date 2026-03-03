# Beads Integration Guide for PDCA Framework

**Optional Enhancement**: This guide explains how to use beads for persistent task tracking across PDCA sessions.

## What is Beads?

Beads is a git-backed issue tracker that provides:
- **Persistent memory** across Claude Code sessions
- **Dependency tracking** for task relationships
- **Git integration** with full audit trail
- **Cross-session continuity** for long-running development cycles

## Prerequisites

### System Requirements

**Required:**
- Go 1.23+ (install via `brew install go`)
- ICU headers (install via `brew install icu4c`)
- Dolt database (install via `brew install dolt`)

**Installation:**

```bash
# Install beads CLI with CGO support
ICU_PATH=$(brew --prefix icu4c@78)
export CGO_CFLAGS="-I${ICU_PATH}/include"
export CGO_CXXFLAGS="-I${ICU_PATH}/include"
export CGO_LDFLAGS="-L${ICU_PATH}/lib"
CGO_ENABLED=1 go install github.com/steveyegge/beads/cmd/bd@latest

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$HOME/go/bin:$PATH"

# Verify installation
bd --version
```

**Optional: MCP Server Integration**

For native Claude Code tool integration:

```bash
# Install beads-mcp
pip3 install beads-mcp

# Configure in Claude Desktop/Code
# Add to ~/Library/Application Support/Claude/claude_desktop_config.json:
{
  "mcpServers": {
    "beads": {
      "command": "beads-mcp"
    }
  }
}
```

**Restart Claude Desktop/Code** after MCP configuration.

---

## PDCA → Beads Mapping

Each PDCA cycle creates a hierarchical task structure in beads:

| PDCA Phase | Beads Task Type | Purpose |
|------------|----------------|---------|
| **PLAN** | Epic | Capture analysis, store approach decisions |
| **DO** | Subtasks | Track individual TDD steps |
| **CHECK** | Verification | Validate completeness against plan |
| **ACT** | Retrospective | Store learnings for future cycles |

**Task Metadata Convention:**
```json
{
  "phase": "plan|do|check|act",
  "pdca_cycle": "uuid-or-epic-id",
  "step_number": 1,
  "tdd_state": "red|green|refactor"
}
```

---

## Workflow Example

### 1. PLAN Phase: Create Epic

**During Analysis:**

```bash
# Create epic for this PDCA cycle
bd create "Feature: Add user authentication" --type epic

# Returns: PDCA Process-a1b2

# Capture analysis notes
bd update PDCA Process-a1b2 --add-message "$(cat <<'EOF'
## Analysis Summary
- Examined existing auth patterns in codebase
- Decided on JWT-based approach
- Dependencies: middleware layer, user model
- Estimated complexity: Medium
EOF
)"
```

**Why:** Preserves analysis across sessions, creates audit trail of decisions.

---

### 2. DO Phase: Track TDD Steps

**Before Each TDD Iteration:**

```bash
# Create subtask for this step
bd create "Step 1: Write failing test for JWT middleware" \
  --parent PDCA Process-a1b2 \
  --type task

# Returns: PDCA Process-a1b2.1

# Claim and mark in progress
bd update PDCA Process-a1b2.1 --claim --status in_progress
```

**After RED → GREEN → REFACTOR:**

```bash
# Close with commit reference
bd close PDCA Process-a1b2.1 --message "✓ Tests pass, committed abc123"
```

**Why:** Each TDD cycle has a discrete task; dependency graph shows implementation sequence.

---

### 3. CHECK Phase: Validate Completeness

**Review All Planned Tasks:**

```bash
# List all subtasks for this epic
bd list --parent PDCA Process-a1b2

# Check for incomplete work
bd list --parent PDCA Process-a1b2 --status open,in_progress

# Review epic with full context
bd show PDCA Process-a1b2
```

**Why:** Beads task list = objective completeness checklist.

---

### 4. ACT Phase: Store Retrospective

**Capture Learnings:**

```bash
# Add retrospective message
bd update PDCA Process-a1b2 --add-message "$(cat <<'EOF'
## Retrospective

**What worked:**
- TDD discipline kept scope focused
- Real component testing caught integration issues early

**What to improve:**
- Should have checked auth patterns before planning
- Batching related tests would have been faster

**Key insight:**
Always grep for similar implementations BEFORE analysis phase.
EOF
)"

# Mark epic complete
bd close PDCA Process-a1b2
```

**Why:** Searchable retrospectives inform future PDCA cycles.

---

## Cross-Session Continuity

**Scenario:** You start a feature, get interrupted, return days later.

**Without Beads:**
- User must re-explain context
- Agent re-discovers architectural patterns
- Lost: decision rationale, attempted approaches

**With Beads:**

```bash
# Resume work
bd ready  # Shows tasks ready to work on

# Review epic context
bd show PDCA Process-a1b2
# Displays: analysis, subtasks, messages, dependencies

# Agent loads full context instantly
```

---

## Git Integration

Beads stores task data in `.beads/` in your project root. The `.beads/` directory contains both the dolt SQL database (binary) and an `issues.jsonl` export file (text). For git tracking, commit the text files and exclude the binary database:

```bash
# Add to your project's .gitignore
# Track issues.jsonl and config.yaml, exclude binary dolt database
echo ".beads/*" >> .gitignore
echo "!.beads/issues.jsonl" >> .gitignore
echo "!.beads/config.yaml" >> .gitignore
```

**Why `.beads/*` instead of `.beads/`?**

Git cannot re-include files inside a directory excluded with a trailing slash. Using `.beads/*` ignores the directory *contents* while allowing negation rules to selectively track specific files.

```bash
# Commit beads state with code
git add .beads/issues.jsonl .beads/config.yaml
git commit -m "Complete authentication epic (PDCA Process-a1b2)"

# Beads state travels with git repo
git push

# Collaborators get your task state
git clone <repo>
cd <repo>
bd list  # See your tasks
```

---

## Common Commands

### Task Creation

```bash
bd create "Task title" --type epic|task|bug|feature
bd create "Subtask" --parent <parent-id>
bd create "Blocked task" --dep <blocking-task-id>
```

### Task Management

```bash
bd ready                    # Show tasks with no blockers
bd list                     # All tasks
bd list --status open       # Filter by status
bd show <id>                # Detailed view
bd update <id> --claim      # Assign to self
bd update <id> --status in_progress
bd close <id>               # Mark complete
```

### Messages & Metadata

```bash
bd update <id> --add-message "Note text"
bd update <id> --metadata key=value
bd comments <id>            # View all messages
```

### Dependencies

```bash
bd dep add <child> <parent>            # Parent/child
bd dep add <blocked> <blocker> blocks  # Blocker
bd blocked                             # Show blocked tasks
```

---

## Integration with PDCA Prompts

All PDCA phase prompts include **optional beads sections**:

- Prompts work **with or without** beads installed
- Beads commands are **clearly marked optional**
- Users can **skip beads sections** entirely

Example from DO phase prompt:

```markdown
**Beads Task Tracking (Optional):**
Before each TDD step:
- [ ] Create subtask: `bd create "Step [N]: [description]" --parent [epic-id]`
- [ ] Claim task: `bd update [id] --claim --status in_progress`
```

---

## Troubleshooting

### "dolt: this binary was built without CGO support"

**Problem:** Beads installed via npm lacks CGO.

**Solution:** Install via Go with ICU headers:

```bash
brew install go icu4c
ICU_PATH=$(brew --prefix icu4c@78)
export CGO_CFLAGS="-I${ICU_PATH}/include"
export CGO_CXXFLAGS="-I${ICU_PATH}/include"
export CGO_LDFLAGS="-L${ICU_PATH}/lib"
CGO_ENABLED=1 go install github.com/steveyegge/beads/cmd/bd@latest
```

### "bd: command not found"

**Problem:** `~/go/bin` not in PATH.

**Solution:** Add to shell profile:

```bash
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### MCP Server Not Showing in Claude

**Problem:** MCP configuration not loaded.

**Solution:**
1. Verify `claude_desktop_config.json` has `mcpServers.beads`
2. Restart Claude Desktop/Code completely
3. Check for MCP errors in Claude logs

### Beads Init Fails

**Problem:** Dolt database issues.

**Solution:**

```bash
# Check dolt is installed
brew install dolt

# Try init with verbose output
bd init --verbose

# Check for permission issues
ls -la .beads/
```

### "could not export to JSONL: exit status 1" on git commit

**Problem:** The beads pre-commit hook fails to export issues after a PR merge or rebase. The hook uses a dolt branch-per-commit pattern that creates a dolt branch for each git commit hash. After a PR merge creates a new merge commit, the export-state file references the old commit hash — a dolt branch that no longer exists.

**Diagnosis:** Check if a stale export-state file exists:

```bash
ls .beads/export-state/
# Shows files like: d09c71ac4cf6bb48.json
```

**Solution A (recommended):** Delete the stale export-state file:

```bash
rm .beads/export-state/*.json
# Next commit will create a fresh export-state entry
```

**Solution B (alternative):** Use `no-db` mode to skip the dolt branch tracking entirely and use `issues.jsonl` as the primary data store:

```bash
# Add to .beads/config.yaml
echo "no-db: true" >> .beads/config.yaml
```

In `no-db` mode, beads reads/writes directly to `issues.jsonl` without dolt branch tracking. This avoids the stale-state problem but removes the SQL query capabilities of the dolt database.

### "Error 1105: branch not found: \<hash\>"

**Problem:** Same root cause as the JSONL export error above — a stale commit hash in `.beads/export-state/` references a dolt branch that was deleted after a PR merge.

**Solution:** Same as above — delete the stale export-state file:

```bash
rm .beads/export-state/*.json
```

---

## When to Use Beads

**Use beads when:**
- PDCA cycle spans multiple sessions (days/weeks)
- Complex feature with many TDD steps to track
- Working on multiple related features (epics with subtasks)
- Want searchable retrospectives
- Collaborating across git repo

**Skip beads when:**
- Quick bug fix (single session)
- Simple 1-2 hour PDCA cycle
- Standalone script with no git repo
- Learning/experimenting (no need for persistence)

---

## Advanced: Searching Past Cycles

**Find retrospectives about testing:**

```bash
bd list --closed | grep -i test
bd show <epic-id>  # Read full retrospective
```

**Find similar features:**

```bash
bd list --type feature --closed
bd show <id>  # See approach and learnings
```

**Track dependencies across epics:**

```bash
bd dep list <epic-id>  # What blocks/blocked this
```

---

## License & Attribution

This integration guide is part of the PDCA Framework for AI-Assisted Code Generation.

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Beads integration designed by [Ken Judy](https://github.com/kenjudy) with Claude Sonnet 4.5

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)

---
*2025*
