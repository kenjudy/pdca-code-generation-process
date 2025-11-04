#!/bin/bash
# Installation script for PDCA Framework Claude Skill
# Installs the skill for use with Claude Code CLI

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Determine installation type
INSTALL_TYPE="${1:-personal}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_FILE="$SCRIPT_DIR/pdca-framework.skill"

echo -e "${BLUE}PDCA Framework Skill Installer for Claude Code${NC}"
echo ""

# Validate skill file exists
if [ ! -f "$SKILL_FILE" ]; then
    echo -e "${RED}Error: Skill file not found: $SKILL_FILE${NC}"
    echo "Please run ./build-skill.sh first to create the skill package."
    exit 1
fi

# Determine installation directory
case "$INSTALL_TYPE" in
    personal|p)
        INSTALL_DIR="$HOME/.claude/skills/pdca-framework"
        SCOPE="Personal"
        SCOPE_DESC="Available across all your projects"
        ;;
    project|proj)
        INSTALL_DIR="$PWD/.claude/skills/pdca-framework"
        SCOPE="Project"
        SCOPE_DESC="Available in current project, shared via git"
        ;;
    *)
        echo -e "${RED}Error: Invalid installation type: $INSTALL_TYPE${NC}"
        echo ""
        echo "Usage: $0 [personal|project]"
        echo ""
        echo "  personal (default) - Install to ~/.claude/skills/"
        echo "  project           - Install to .claude/skills/ in current directory"
        exit 1
        ;;
esac

echo -e "${BLUE}Installation Type:${NC} $SCOPE"
echo -e "${BLUE}Installation Path:${NC} $INSTALL_DIR"
echo -e "${BLUE}Scope:${NC} $SCOPE_DESC"
echo ""

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Warning: Skill already installed at $INSTALL_DIR${NC}"
    read -p "Overwrite existing installation? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo -e "${BLUE}Removing existing installation...${NC}"
    rm -rf "$INSTALL_DIR"
fi

# Create installation directory
echo -e "${BLUE}Creating installation directory...${NC}"
mkdir -p "$INSTALL_DIR"

# Extract skill package
echo -e "${BLUE}Extracting skill package...${NC}"
unzip -q "$SKILL_FILE" -d "$INSTALL_DIR"

# Verify installation
if [ ! -f "$INSTALL_DIR/SKILL.md" ]; then
    echo -e "${RED}Error: Installation failed - SKILL.md not found${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""

# Show what was installed
echo -e "${BLUE}Installed files:${NC}"
find "$INSTALL_DIR" -type f | sed "s|$INSTALL_DIR|  |" | sort

echo ""
echo -e "${GREEN}Success!${NC} The PDCA framework skill is now available in Claude Code."
echo ""

# Provide scope-specific next steps
if [ "$INSTALL_TYPE" = "personal" ] || [ "$INSTALL_TYPE" = "p" ]; then
    echo -e "${BLUE}Next Steps:${NC}"
    echo "1. The skill is automatically discovered by Claude Code"
    echo "2. Start a coding session: claude-code"
    echo "3. Claude will use the skill when appropriate"
    echo ""
    echo -e "${BLUE}Test it:${NC}"
    echo "   claude-code 'Show me the PDCA analysis phase prompt'"
else
    echo -e "${BLUE}Next Steps:${NC}"
    echo "1. Commit the skill to share with your team:"
    echo "   git add .claude/skills/"
    echo "   git commit -m 'Add PDCA framework skill'"
    echo ""
    echo "2. The skill is automatically discovered by Claude Code"
    echo "3. Team members who pull will get the skill automatically"
    echo ""
    echo -e "${BLUE}Test it:${NC}"
    echo "   claude-code 'Show me the PDCA analysis phase prompt'"
fi

echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  README: $SCRIPT_DIR/README.md"
echo "  Build:  $SCRIPT_DIR/BUILD.md"
echo ""
echo -e "${BLUE}Uninstall:${NC}"
echo "  rm -rf $INSTALL_DIR"
