#!/bin/bash
# Build script for PDCA Framework Claude Skill
# Composes skill package from master source files

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Building PDCA Framework Skill...${NC}"

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
SRC_DIR="$SCRIPT_DIR/src"

# Master source files
MASTER_1A="$REPO_ROOT/1. Plan/1a Analyze to determine approach for achieving the goal.md"
MASTER_1B="$REPO_ROOT/1. Plan/1b Create a detailed implementation plan.md"
MASTER_2="$REPO_ROOT/2. Do/2. Test Drive the Change.md"
MASTER_3="$REPO_ROOT/3. Check/3. Completeness Check.md"
MASTER_4="$REPO_ROOT/4. Act/4. Retrospect for continuous improvement.md"
MASTER_WORKING_AGREEMENTS="$REPO_ROOT/Human Working Agreements.md"

# Output files
OUTPUT_PLAN="$SRC_DIR/references/plan-prompts.md"
OUTPUT_DO="$SRC_DIR/references/do-prompts.md"
OUTPUT_CHECK="$SRC_DIR/references/check-prompts.md"
OUTPUT_ACT="$SRC_DIR/references/act-prompts.md"
OUTPUT_WORKING_AGREEMENTS="$SRC_DIR/references/working-agreements.md"

# Verify master files exist
echo -e "${BLUE}Verifying master source files...${NC}"
for file in "$MASTER_1A" "$MASTER_1B" "$MASTER_2" "$MASTER_3" "$MASTER_4" "$MASTER_WORKING_AGREEMENTS"; do
    if [ ! -f "$file" ]; then
        echo -e "${RED}Error: Master file not found: $file${NC}"
        exit 1
    fi
done
echo -e "${GREEN}✓ All master files found${NC}"

# Create directories
mkdir -p "$SRC_DIR/references"

# Build plan-prompts.md (combines 1a and 1b)
echo -e "${BLUE}Building plan-prompts.md...${NC}"
cat > "$OUTPUT_PLAN" << 'EOF'
# PLAN Phase: Analysis & Detailed Planning

This file contains prompts for both analysis (1a) and planning (1b) phases.

---

EOF

cat "$MASTER_1A" >> "$OUTPUT_PLAN"
echo -e "\n---\n" >> "$OUTPUT_PLAN"
cat "$MASTER_1B" >> "$OUTPUT_PLAN"
echo -e "${GREEN}✓ Created plan-prompts.md${NC}"

# Build do-prompts.md
echo -e "${BLUE}Building do-prompts.md...${NC}"
cp "$MASTER_2" "$OUTPUT_DO"
echo -e "${GREEN}✓ Created do-prompts.md${NC}"

# Build check-prompts.md
echo -e "${BLUE}Building check-prompts.md...${NC}"
cp "$MASTER_3" "$OUTPUT_CHECK"
echo -e "${GREEN}✓ Created check-prompts.md${NC}"

# Build act-prompts.md
echo -e "${BLUE}Building act-prompts.md...${NC}"
cp "$MASTER_4" "$OUTPUT_ACT"
echo -e "${GREEN}✓ Created act-prompts.md${NC}"

# Build working-agreements.md
echo -e "${BLUE}Building working-agreements.md...${NC}"
cp "$MASTER_WORKING_AGREEMENTS" "$OUTPUT_WORKING_AGREEMENTS"
echo -e "${GREEN}✓ Created working-agreements.md${NC}"

# SKILL.md is manually maintained, so we don't overwrite it
if [ ! -f "$SRC_DIR/SKILL.md" ]; then
    echo -e "${RED}Warning: SKILL.md not found. This file should be manually maintained.${NC}"
fi

# Create the .skill package (ZIP file with .skill extension)
echo -e "${BLUE}Creating skill package...${NC}"
cd "$SRC_DIR"
SKILL_FILE="$SCRIPT_DIR/pdca-framework.skill"

# Remove old skill file if it exists
[ -f "$SKILL_FILE" ] && rm "$SKILL_FILE"

# Create ZIP with pdca-framework directory structure
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

# Verify the package was created
if [ ! -f "$SKILL_FILE" ]; then
    echo -e "${RED}Error: Failed to create skill package${NC}"
    exit 1
fi

SKILL_SIZE=$(du -h "$SKILL_FILE" | cut -f1)
echo -e "${GREEN}✓ Created pdca-framework.skill ($SKILL_SIZE)${NC}"

# Show what's in the package
echo -e "\n${BLUE}Skill package contents:${NC}"
unzip -l "$SKILL_FILE"

echo -e "\n${GREEN}Build complete!${NC}"
echo -e "${BLUE}Skill package: $SKILL_FILE${NC}"
echo -e "${BLUE}Size: $SKILL_SIZE${NC}"
echo -e "\n${BLUE}Next steps:${NC}"
echo "1. Review the generated files in src/references/"
echo "2. Test the skill by uploading pdca-framework.skill to Claude"
echo "3. Commit changes if everything looks good"
