# Building the PDCA Framework Skill

This document explains how to build and install the PDCA Framework skill package.

## Quick Start

**Just want to use the skill?** See [README.md](README.md) for installation instructions.

**Building from source:**

```bash
# Build the skill package
./build-skill.sh

# Install for Claude Code
./install-skill.sh personal   # Available across all projects
# or
./install-skill.sh project    # Available in current project only
```

## Overview

The skill package is automatically composed from your master prompt files located in the repository root:

```
Master Sources → Build Script → Skill Package → Installation
├── 1. Plan/1a...md       ─┐
├── 1. Plan/1b...md       ─┤→ src/references/plan-prompts.md  ─┐
├── 2. Do/2...md          ─┤→ src/references/do-prompts.md     │
├── 3. Check/3...md       ─┤→ src/references/check-prompts.md  ├→ pdca-framework.skill
├── 4. Act/4...md         ─┤→ src/references/act-prompts.md    │                         │
└── Human Working Agr...  ─┤→ src/references/working-agr...md  │                         │
                          └→ src/SKILL.md (manually maintained) ─┘                         │
                                                                                            │
For Claude.ai: Upload .skill file ←───────────────────────────────────────────────────────┘
For Claude Code: Extract to ~/.claude/skills/pdca-framework/ ←────────────────────────────┘
```

## Prerequisites

- Bash shell (macOS/Linux built-in)
- `zip` command (pre-installed on macOS/Linux)
- Master source files in their expected locations

## Building the Skill

### Quick Build

From the repository root:

```bash
cd claude-skill
./build-skill.sh
```

### What the Build Script Does

1. **Verifies** all master source files exist
2. **Composes** reference files:
   - Combines `1a` and `1b` into `plan-prompts.md`
   - Copies other phase files to `references/`
3. **Creates** the skill package (ZIP with `.skill` extension)
4. **Reports** the package size and contents

### Build Output

```
claude-skill/
├── build-skill.sh              # The build script
├── pdca-framework.skill       # Generated (can be committed or ignored)
└── src/                        # Generated source files
    ├── SKILL.md               # Manually maintained
    └── references/            # Auto-generated from masters
        ├── plan-prompts.md
        ├── do-prompts.md
        ├── check-prompts.md
        ├── act-prompts.md
        └── working-agreements.md
```

## When to Rebuild

Rebuild the skill whenever you update any of these master files:

- `1. Plan/1a Analyze to determine approach for achieving the goal.md`
- `1. Plan/1b Create a detailed implementation plan.md`
- `2. Do/2. Test Drive the Change.md`
- `3. Check/3. Completeness Check.md`
- `4. Act/4. Retrospect for continuous improvement.md`
- `Human Working Agreements.md`

## Git Strategy

### Option 1: Commit Generated Files (Recommended)

**Pros:**
- Users can download the skill directly from GitHub
- See exactly what's in the latest release
- Easy to track changes in skill package

**Cons:**
- Generated files tracked in git

**Setup:**
```bash
# Build and commit
./build-skill.sh
git add src/references/ pdca-framework.skill
git commit -m "Rebuild skill from updated master prompts"
```

### Option 2: Ignore Generated Files

**Pros:**
- Only source files in git
- Build from masters on demand

**Cons:**
- Users must build locally
- Can't download skill directly from GitHub

**Setup:**
Add to `.gitignore`:
```gitignore
# Build artifacts
claude-skill/src/references/
claude-skill/pdca-framework.skill
```

Then build locally:
```bash
./build-skill.sh
# Use the skill but don't commit it
```

## Customizing the Build

### Change Master File Locations

Edit `build-skill.sh` and update these variables:

```bash
MASTER_1A="$REPO_ROOT/1. Plan/1a Analyze..."
MASTER_1B="$REPO_ROOT/1. Plan/1b Create..."
# etc.
```

### Add Additional Files

To include more files in the skill package:

1. Add the source to `src/references/`
2. Update the `zip` command in `build-skill.sh`:
   ```bash
   zip -r "$SKILL_FILE" \
       SKILL.md \
       references/plan-prompts.md \
       references/your-new-file.md \  # Add here
       ...
   ```

### Customize the Package Structure

The `.skill` file is a ZIP archive. You can customize:

- Directory structure inside the ZIP
- Which files are included
- Compression settings

## Testing the Skill

After building:

1. **Verify the package contents:**
   ```bash
   unzip -l pdca-framework.skill
   ```

2. **Test in Claude:**
   - Upload `pdca-framework.skill` to Claude.ai
   - Or install in Claude Code (skills sync automatically)
   - Test with: `@pdca-framework Show me the analysis prompt`

3. **Review generated files:**
   ```bash
   ls -lh src/references/
   cat src/references/plan-prompts.md  # Check composition
   ```

## Troubleshooting

### "Master file not found" error

**Cause:** Master files moved or renamed

**Solution:** Update the paths in `build-skill.sh`

### Build succeeds but skill doesn't work

**Cause:** `SKILL.md` may need updating

**Solution:** Check that `SKILL.md` references the correct file paths

### Permission denied when running script

**Cause:** Script not executable

**Solution:**
```bash
chmod +x build-skill.sh
```

### ZIP file seems wrong

**Cause:** Working directory issue in script

**Solution:** Ensure script runs from `claude-skill/` directory:
```bash
cd claude-skill && ./build-skill.sh
```

## Automation Ideas

### Git Hook (Pre-Commit)

Automatically rebuild when masters change:

```bash
# .git/hooks/pre-commit
#!/bin/bash
cd claude-skill && ./build-skill.sh
git add src/references/ pdca-framework.skill
```

### CI/CD (GitHub Actions)

Build and release on push:

```yaml
name: Build Skill
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: cd claude-skill && ./build-skill.sh
      - uses: actions/upload-artifact@v2
        with:
          name: pdca-skill
          path: claude-skill/pdca-framework.skill
```

### Makefile

Add to repository root:

```makefile
.PHONY: skill
skill:
	cd claude-skill && ./build-skill.sh

.PHONY: skill-clean
skill-clean:
	rm -f claude-skill/pdca-framework.skill
	rm -rf claude-skill/src/references/
```

Usage: `make skill`

## Version Management

Consider versioning your skill builds:

```bash
# In build-skill.sh, add version to filename
VERSION="1.0.0"
SKILL_FILE="$SCRIPT_DIR/pdca-framework-v${VERSION}.skill"
```

Or use git tags:

```bash
git tag v1.0.0
git push --tags
# Build includes git tag in skill metadata
```

## Contributing

When submitting PRs that modify master prompts:

1. Update the master files in their original locations
2. Run `./build-skill.sh` to regenerate the skill
3. Commit both the masters and the regenerated files
4. Note in PR: "Skill rebuilt from updated masters"

---

**Questions?** Open an issue on [GitHub](https://github.com/kenjudy/human-ai-collaboration-process)
