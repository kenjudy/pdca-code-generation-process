# Beads Setup Guide

> Load this only when setting up beads for the first time.

**Optional Enhancement**: Beads is a git-backed issue tracker for persistent task tracking across PDCA sessions.

## What is Beads?

Beads provides:
- **Persistent memory** across Claude Code sessions
- **Dependency tracking** for task relationships
- **Git integration** with full audit trail
- **Cross-session continuity** for long-running development cycles

## System Requirements

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
pip3 install beads-mcp
```

Add to `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
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

## Troubleshooting

### "dolt: this binary was built without CGO support"

Install via Go with ICU headers (see System Requirements above).

### "bd: command not found"

```bash
echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

### MCP Server Not Showing in Claude

1. Verify `claude_desktop_config.json` has `mcpServers.beads`
2. Restart Claude Desktop/Code completely

### Beads Init Fails

```bash
brew install dolt && bd init --verbose
```

---

## License & Attribution

**License:** [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Attribution:** Beads integration designed by [Ken Judy](https://github.com/kenjudy) with Claude Sonnet 4.5

**Source:** [Human-AI Collaboration Process Repository](https://github.com/kenjudy/human-ai-collaboration-process)
