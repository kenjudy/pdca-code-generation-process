#!/bin/bash
# Build script for PDCA Framework Claude Skill
# Generates TWO skill packages:
#   1. pdca-framework.skill (standard, no beads)
#   2. pdca-framework-beads.skill (with beads integration)

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Building PDCA Framework Skill (Dual Package)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}\n"

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
CORE_DIR="$SRC_DIR/core"
BEADS_DIR="$SRC_DIR/beads-addon"

# Master source files
MASTER_1A="$REPO_ROOT/1. Plan/1a Analyze to determine approach for achieving the goal.md"
MASTER_1B="$REPO_ROOT/1. Plan/1b Create a detailed implementation plan.md"
MASTER_2="$REPO_ROOT/2. Do/2. Test Drive the Change.md"
MASTER_3="$REPO_ROOT/3. Check/3. Completeness Check.md"
MASTER_4="$REPO_ROOT/4. Act/4. Retrospect for continuous improvement.md"
MASTER_WORKING_AGREEMENTS="$REPO_ROOT/Human Working Agreements.md"

# Beads addon files
BEADS_PLAN_ADDON="$BEADS_DIR/references/plan-beads-addon.md"
BEADS_DO_ADDON="$BEADS_DIR/references/do-beads-addon.md"
BEADS_CHECK_ADDON="$BEADS_DIR/references/check-beads-addon.md"
BEADS_ACT_ADDON="$BEADS_DIR/references/act-beads-addon.md"
BEADS_INTEGRATION="$BEADS_DIR/references/beads-integration.md"

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
for file in "$BEADS_PLAN_ADDON" "$BEADS_DO_ADDON" "$BEADS_CHECK_ADDON" "$BEADS_ACT_ADDON" "$BEADS_INTEGRATION"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: Beads addon file not found: $file${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ All beads addon files found${NC}\n"

# Create build directories
mkdir -p "$CORE_DIR/references"
mkdir -p "$BEADS_DIR/references/build"

# ═══════════════════════════════════════════════════════
# BUILD STANDARD PACKAGE (pdca-framework.skill)
# ═══════════════════════════════════════════════════════

echo -e "${YELLOW}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│  Building Standard Package (no beads)               │${NC}"
echo -e "${YELLOW}└─────────────────────────────────────────────────────┘${NC}\n"

# Build core plan-prompts.md (combines 1a and 1b)
echo -e "${BLUE}Building core/plan-prompts.md...${NC}"
cat > "$CORE_DIR/references/plan-prompts.md" << 'EOF'
# PLAN Phase: Analysis & Detailed Planning

This file contains prompts for both analysis (1a) and planning (1b) phases.

---

EOF
cat "$MASTER_1A" >> "$CORE_DIR/references/plan-prompts.md"
echo -e "\n---\n" >> "$CORE_DIR/references/plan-prompts.md"
cat "$MASTER_1B" >> "$CORE_DIR/references/plan-prompts.md"
echo -e "${GREEN}✓ Created core/plan-prompts.md${NC}"

# Build core do-prompts.md
echo -e "${BLUE}Building core/do-prompts.md...${NC}"
cp "$MASTER_2" "$CORE_DIR/references/do-prompts.md"
echo -e "${GREEN}✓ Created core/do-prompts.md${NC}"

# Build core check-prompts.md
echo -e "${BLUE}Building core/check-prompts.md...${NC}"
cp "$MASTER_3" "$CORE_DIR/references/check-prompts.md"
echo -e "${GREEN}✓ Created core/check-prompts.md${NC}"

# Build core act-prompts.md
echo -e "${BLUE}Building core/act-prompts.md...${NC}"
cp "$MASTER_4" "$CORE_DIR/references/act-prompts.md"
echo -e "${GREEN}✓ Created core/act-prompts.md${NC}"

# Build core working-agreements.md
echo -e "${BLUE}Building core/working-agreements.md...${NC}"
cp "$MASTER_WORKING_AGREEMENTS" "$CORE_DIR/references/working-agreements.md"
echo -e "${GREEN}✓ Created core/working-agreements.md${NC}\n"

# Verify SKILL.md exists
if [ ! -f "$CORE_DIR/SKILL.md" ]; then
    echo -e "${RED}Error: core/SKILL.md not found${NC}"
    exit 1
fi

# Create standard skill package
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
# BUILD BEADS PACKAGE (pdca-framework-beads.skill)
# ═══════════════════════════════════════════════════════

echo -e "${YELLOW}┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│  Building Beads Package (with beads integration)    │${NC}"
echo -e "${YELLOW}└─────────────────────────────────────────────────────┘${NC}\n"

# Build beads plan-prompts.md (core + beads addon)
echo -e "${BLUE}Building beads/plan-prompts.md...${NC}"
cat > "$BEADS_DIR/references/build/plan-prompts.md" << 'EOF'
# PLAN Phase: Analysis & Detailed Planning

This file contains prompts for both analysis (1a) and planning (1b) phases.

---

EOF
cat "$MASTER_1A" >> "$BEADS_DIR/references/build/plan-prompts.md"
echo -e "\n---\n" >> "$BEADS_DIR/references/build/plan-prompts.md"
cat "$MASTER_1B" >> "$BEADS_DIR/references/build/plan-prompts.md"
cat "$BEADS_PLAN_ADDON" >> "$BEADS_DIR/references/build/plan-prompts.md"
echo -e "${GREEN}✓ Created beads/plan-prompts.md (core + addon)${NC}"

# Build beads do-prompts.md (core + beads addon)
echo -e "${BLUE}Building beads/do-prompts.md...${NC}"
cat "$MASTER_2" "$BEADS_DO_ADDON" > "$BEADS_DIR/references/build/do-prompts.md"
echo -e "${GREEN}✓ Created beads/do-prompts.md (core + addon)${NC}"

# Build beads check-prompts.md (core + beads addon)
echo -e "${BLUE}Building beads/check-prompts.md...${NC}"
cat "$MASTER_3" "$BEADS_CHECK_ADDON" > "$BEADS_DIR/references/build/check-prompts.md"
echo -e "${GREEN}✓ Created beads/check-prompts.md (core + addon)${NC}"

# Build beads act-prompts.md (core + beads addon)
echo -e "${BLUE}Building beads/act-prompts.md...${NC}"
cat "$MASTER_4" "$BEADS_ACT_ADDON" > "$BEADS_DIR/references/build/act-prompts.md"
echo -e "${GREEN}✓ Created beads/act-prompts.md (core + addon)${NC}"

# Build beads working-agreements.md (same as core for now)
echo -e "${BLUE}Building beads/working-agreements.md...${NC}"
cp "$MASTER_WORKING_AGREEMENTS" "$BEADS_DIR/references/build/working-agreements.md"
echo -e "${GREEN}✓ Created beads/working-agreements.md${NC}\n"

# Verify SKILL-beads.md exists
if [ ! -f "$BEADS_DIR/SKILL-beads.md" ]; then
    echo -e "${RED}Error: beads-addon/SKILL-beads.md not found${NC}"
    exit 1
fi

# Create beads skill package
echo -e "${BLUE}Creating pdca-framework-beads.skill package...${NC}"
cd "$BEADS_DIR"
BEADS_SKILL_FILE="$SCRIPT_DIR/pdca-framework-beads.skill"
[ -f "$BEADS_SKILL_FILE" ] && rm "$BEADS_SKILL_FILE"

# Copy SKILL-beads.md to SKILL.md for packaging
cp SKILL-beads.md SKILL.md

zip -r "$BEADS_SKILL_FILE" \
    SKILL.md \
    references/build/plan-prompts.md \
    references/build/do-prompts.md \
    references/build/check-prompts.md \
    references/build/act-prompts.md \
    references/build/working-agreements.md \
    references/beads-integration.md \
    -x "*.DS_Store" \
    -q

# Clean up temp SKILL.md
rm SKILL.md

cd "$SCRIPT_DIR"

if [ ! -f "$BEADS_SKILL_FILE" ]; then
    echo -e "${RED}Error: Failed to create pdca-framework-beads.skill${NC}"
    exit 1
fi

BEADS_SKILL_SIZE=$(du -h "$BEADS_SKILL_FILE" | cut -f1)
echo -e "${GREEN}✓ Created pdca-framework-beads.skill ($BEADS_SKILL_SIZE)${NC}\n"

# ═══════════════════════════════════════════════════════
# BUILD SUMMARY
# ═══════════════════════════════════════════════════════

echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}   Build Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}\n"

echo -e "${BLUE}Standard Package:${NC}"
echo -e "  File: pdca-framework.skill"
echo -e "  Size: $SKILL_SIZE"
unzip -l "$SKILL_FILE" | head -15
echo ""

echo -e "${BLUE}Beads Package:${NC}"
echo -e "  File: pdca-framework-beads.skill"
echo -e "  Size: $BEADS_SKILL_SIZE"
unzip -l "$BEADS_SKILL_FILE" | head -20

echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Review generated files in src/core/references/ and src/beads-addon/references/build/"
echo "2. Test standard skill: upload pdca-framework.skill to Claude"
echo "3. Test beads skill: upload pdca-framework-beads.skill to Claude"
echo "4. Commit changes if everything looks good"
echo ""
