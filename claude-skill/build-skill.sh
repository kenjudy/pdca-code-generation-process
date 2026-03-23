#!/bin/bash
# Build script for PDCA Framework Claude Skill
# Generates ONE unified skill package: pdca-framework.skill
# Includes base prompt files + optional beads addon files (progressive disclosure)

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Building PDCA Framework Skill (Unified Package)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}\n"

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
CORE_DIR="$SRC_DIR/core"
BEADS_DIR="$SRC_DIR/beads-addon"

# Master source files (Obsidian notes — source of truth for prompt content)
MASTER_1A="$REPO_ROOT/1. Plan/1a Analyze to determine approach for achieving the goal.md"
MASTER_1B="$REPO_ROOT/1. Plan/1b Create a detailed implementation plan.md"
MASTER_2="$REPO_ROOT/2. Do/2. Test Drive the Change.md"
MASTER_3="$REPO_ROOT/3. Check/3. Completeness Check.md"
MASTER_4="$REPO_ROOT/4. Act/4. Retrospect for continuous improvement.md"
MASTER_WORKING_AGREEMENTS="$REPO_ROOT/Human Working Agreements.md"

# Beads addon files (source — NOT build artifacts)
BEADS_PLAN_ADDON="$BEADS_DIR/references/plan-beads-addon.md"
BEADS_DO_ADDON="$BEADS_DIR/references/do-beads-addon.md"
BEADS_CHECK_ADDON="$BEADS_DIR/references/check-beads-addon.md"
BEADS_ACT_ADDON="$BEADS_DIR/references/act-beads-addon.md"
BEADS_SETUP="$BEADS_DIR/references/beads-setup.md"
BEADS_WORKFLOW="$BEADS_DIR/references/beads-workflow.md"

# Verify master files exist
echo -e "${BLUE}Verifying master source files...${NC}"
for file in "$MASTER_1A" "$MASTER_1B" "$MASTER_2" "$MASTER_3" "$MASTER_4" "$MASTER_WORKING_AGREEMENTS"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: Master file not found: $file${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ All master files found${NC}\n"

# Verify beads addon files exist
echo -e "${BLUE}Verifying beads addon files...${NC}"
for file in "$BEADS_PLAN_ADDON" "$BEADS_DO_ADDON" "$BEADS_CHECK_ADDON" "$BEADS_ACT_ADDON" "$BEADS_SETUP" "$BEADS_WORKFLOW"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: Beads addon file not found: $file${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ All beads addon files found${NC}\n"

# Create build directory
mkdir -p "$CORE_DIR/references"

# Strip license block from a file — removes "## License & Attribution" to EOF.
# Source templates retain the block for GitHub/documentation; built files omit it
# since the attribution text has no value to Claude in-context.
strip_license() {
    sed '/^## License & Attribution/,$ d' "$1"
}

# ═══════════════════════════════════════════════════════
# BUILD BASE PROMPT FILES (from Obsidian masters)
# ═══════════════════════════════════════════════════════

echo -e "${YELLOW}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│  Building base prompt files from masters            │${NC}"
echo -e "${YELLOW}└─────────────────────────────────────────────────────┘${NC}\n"

# plan-prompts.md combines 1a and 1b masters (license stripped from both)
echo -e "${BLUE}Building plan-prompts.md...${NC}"
cat > "$CORE_DIR/references/plan-prompts.md" << 'EOF'
# PLAN Phase: Analysis & Detailed Planning

This file contains prompts for both analysis (1a) and planning (1b) phases.

---

EOF
strip_license "$MASTER_1A" >> "$CORE_DIR/references/plan-prompts.md"
echo -e "\n---\n" >> "$CORE_DIR/references/plan-prompts.md"
strip_license "$MASTER_1B" >> "$CORE_DIR/references/plan-prompts.md"
echo -e "${GREEN}✓ Built plan-prompts.md${NC}"

echo -e "${BLUE}Building do-prompts.md...${NC}"
strip_license "$MASTER_2" > "$CORE_DIR/references/do-prompts.md"
echo -e "${GREEN}✓ Built do-prompts.md${NC}"

echo -e "${BLUE}Building check-prompts.md...${NC}"
strip_license "$MASTER_3" > "$CORE_DIR/references/check-prompts.md"
echo -e "${GREEN}✓ Built check-prompts.md${NC}"

echo -e "${BLUE}Building act-prompts.md...${NC}"
strip_license "$MASTER_4" > "$CORE_DIR/references/act-prompts.md"
echo -e "${GREEN}✓ Built act-prompts.md${NC}"

echo -e "${BLUE}Building working-agreements.md...${NC}"
strip_license "$MASTER_WORKING_AGREEMENTS" > "$CORE_DIR/references/working-agreements.md"
echo -e "${GREEN}✓ Built working-agreements.md${NC}\n"

# ═══════════════════════════════════════════════════════
# COPY BEADS ADDON FILES (progressive disclosure references)
# ═══════════════════════════════════════════════════════

echo -e "${YELLOW}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│  Copying beads addon files                          │${NC}"
echo -e "${YELLOW}└─────────────────────────────────────────────────────┘${NC}\n"

cp "$BEADS_PLAN_ADDON"  "$CORE_DIR/references/plan-beads-addon.md"
cp "$BEADS_DO_ADDON"    "$CORE_DIR/references/do-beads-addon.md"
cp "$BEADS_CHECK_ADDON" "$CORE_DIR/references/check-beads-addon.md"
cp "$BEADS_ACT_ADDON"   "$CORE_DIR/references/act-beads-addon.md"
cp "$BEADS_SETUP"       "$CORE_DIR/references/beads-setup.md"
cp "$BEADS_WORKFLOW"    "$CORE_DIR/references/beads-workflow.md"
echo -e "${GREEN}✓ Copied 6 beads addon files${NC}\n"

# ═══════════════════════════════════════════════════════
# PACKAGE UNIFIED SKILL
# ═══════════════════════════════════════════════════════

if [ ! -f "$CORE_DIR/SKILL.md" ]; then
    echo -e "${RED}Error: core/SKILL.md not found${NC}"
    exit 1
fi

echo -e "${BLUE}Creating pdca-framework.skill package...${NC}"
cd "$CORE_DIR"
SKILL_FILE="$SCRIPT_DIR/pdca-framework.skill"
[ -f "$SKILL_FILE" ] && rm "$SKILL_FILE"

zip -r "$SKILL_FILE" \
    SKILL.md \
    references/plan-prompts.md \
    references/do-prompts.md \
    references/check-prompts.md \
    references/act-prompts.md \
    references/working-agreements.md \
    references/plan-beads-addon.md \
    references/do-beads-addon.md \
    references/check-beads-addon.md \
    references/act-beads-addon.md \
    references/beads-setup.md \
    references/beads-workflow.md \
    -x "*.DS_Store" \
    -q

cd "$SCRIPT_DIR"

if [ ! -f "$SKILL_FILE" ]; then
    echo -e "${RED}Error: Failed to create pdca-framework.skill${NC}"
    exit 1
fi

SKILL_SIZE=$(du -h "$SKILL_FILE" | cut -f1)
echo -e "${GREEN}✓ Created pdca-framework.skill ($SKILL_SIZE)${NC}\n"

# ═══════════════════════════════════════════════════════
# BUILD SUMMARY
# ═══════════════════════════════════════════════════════

echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   Build Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}\n"

echo -e "${BLUE}Unified Package:${NC}"
echo -e "  File: pdca-framework.skill"
echo -e "  Size: $SKILL_SIZE"
unzip -l "$SKILL_FILE"
echo ""

echo -e "${BLUE}Next steps:${NC}"
echo "1. Review generated files in src/core/references/"
echo "2. Install: unzip -o pdca-framework.skill -d ~/.claude/skills/pdca-framework/"
echo "3. Commit changes if everything looks good"
echo ""
echo -e "${YELLOW}Per-project beads .gitignore setup (add to each project using beads):${NC}"
echo "  .beads/*"
echo "  !.beads/issues.jsonl"
echo "  !.beads/config.yaml"
echo ""
echo "  (Use .beads/* not .beads/ — git negation rules require the wildcard form)"
echo ""
