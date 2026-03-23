---

# Beads Integration (Optional)

**If beads is configured**, track this PDCA cycle with persistent tasks:

## Create Epic for This Cycle

```bash
# Create epic to track this PDCA cycle
bd create "Feature: [goal description]" --type epic

# Example: bd create "Feature: Add user authentication" --type epic
# Returns: [prefix]-a1b2 (your epic ID)
```

## Capture Analysis Notes

After completing your analysis, store key decisions:

```bash
# Add analysis summary to epic
bd update [epic-id] --add-message "$(cat <<'EOF'
## Analysis Summary
- [Key architectural patterns discovered]
- [Chosen approach and rationale]
- [Dependencies identified]
- [Complexity assessment]
EOF
)"
```

**Why use beads in PLAN phase:**
- Preserves analysis across sessions
- Creates audit trail of decision rationale
- Provides context for resuming work later
- Links dependencies between features

**Save the epic ID** - you'll reference it in DO, CHECK, and ACT phases.

---

**Next**: Proceed to Planning phase (1b), then move to DO phase with your epic ID ready.
