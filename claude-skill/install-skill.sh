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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   PDCA Framework Skill Installer for Claude Code${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Step 1: Select Package
echo -e "${YELLOW}Step 1: Select Package${NC}"
echo ""
echo "Two packages available:"
echo ""
echo "  ${GREEN}1)${NC} Standard (pdca-framework.skill)"
echo "     • Core PDCA framework (Plan→Do→Check→Act)"
echo "     • Works out of the box, no additional setup"
echo "     • Perfect for single-session work (1-3 hours)"
echo "     • Size: 16K"
echo ""
echo "  ${GREEN}2)${NC} Beads (pdca-framework-beads.skill)"
echo "     • Everything in Standard package"
echo "     • Plus: Persistent task tracking across sessions"
echo "     • Plus: Git-backed memory and searchable retrospectives"
echo "     • Requires: beads CLI + MCP server installed"
echo "     • Size: 20K"
echo ""
read -p "Which package? (1 for Standard, 2 for Beads) [1]: " PACKAGE_CHOICE
PACKAGE_CHOICE=${PACKAGE_CHOICE:-1}

# Determine package file and skill name
case "$PACKAGE_CHOICE" in
    1|standard|s)
        SKILL_FILE="$SCRIPT_DIR/pdca-framework.skill"
        SKILL_NAME="pdca-framework"
        PACKAGE_TYPE="Standard"
        ;;
    2|beads|b)
        SKILL_FILE="$SCRIPT_DIR/pdca-framework-beads.skill"
        SKILL_NAME="pdca-framework-beads"
        PACKAGE_TYPE="Beads"
        ;;
    *)
        echo -e "${RED}Error: Invalid choice: $PACKAGE_CHOICE${NC}"
        echo "Please choose 1 (Standard) or 2 (Beads)"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}✓ Selected: $PACKAGE_TYPE package${NC}"
echo ""

# Validate skill file exists
if [ ! -f "$SKILL_FILE" ]; then
    echo -e "${RED}Error: Skill file not found: $SKILL_FILE${NC}"
    echo "Please run ./build-skill.sh first to create the skill packages."
    exit 1
fi

# Step 2: Select Installation Type
INSTALL_TYPE="${1:-personal}"

echo -e "${YELLOW}Step 2: Select Installation Scope${NC}"
echo ""

# Determine installation directory
case "$INSTALL_TYPE" in
    personal|p)
        INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"
        SCOPE="Personal"
        SCOPE_DESC="Available across all your projects"
        ;;
    project|proj)
        INSTALL_DIR="$PWD/.claude/skills/$SKILL_NAME"
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

echo -e "${BLUE}Package:${NC} $PACKAGE_TYPE ($SKILL_FILE)"
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

# Show beads setup instructions if beads package was installed
if [ "$PACKAGE_TYPE" = "Beads" ]; then
    echo -e "${YELLOW}⚠️  Beads Package Requires Additional Setup${NC}"
    echo ""
    echo "The beads skill requires beads CLI and MCP server to be installed:"
    echo ""
    echo -e "${BLUE}1. Install beads CLI:${NC}"
    echo "   brew install go icu4c dolt"
    echo "   ICU_PATH=\$(brew --prefix icu4c@78)"
    echo "   export CGO_CFLAGS=\"-I\${ICU_PATH}/include\""
    echo "   export CGO_CXXFLAGS=\"-I\${ICU_PATH}/include\""
    echo "   export CGO_LDFLAGS=\"-L\${ICU_PATH}/lib\""
    echo "   CGO_ENABLED=1 go install github.com/steveyegge/beads/cmd/bd@latest"
    echo ""
    echo -e "${BLUE}2. Install beads MCP server (optional):${NC}"
    echo "   pip3 install beads-mcp"
    echo ""
    echo -e "${BLUE}3. Initialize beads in your project:${NC}"
    echo "   cd /path/to/your/project"
    echo "   bd init"
    echo ""
    echo -e "${BLUE}4. Configure .gitignore for beads:${NC}"
    echo "   echo '.beads/*' >> .gitignore"
    echo "   echo '!.beads/issues.jsonl' >> .gitignore"
    echo "   echo '!.beads/config.yaml' >> .gitignore"
    echo ""
    echo "   (Tracks issues.jsonl and config.yaml, excludes binary dolt database)"
    echo ""
    echo "For detailed setup instructions, see:"
    echo "  $SCRIPT_DIR/README.md#beads-integration"
    echo ""
    echo -e "${BLUE}Note:${NC} All beads commands in the prompts are optional."
    echo "The skill works with or without beads installed."
    echo ""
fi

echo -e "${BLUE}Documentation:${NC}"
echo "  README: $SCRIPT_DIR/README.md"
echo "  Build:  $SCRIPT_DIR/BUILD.md"
echo ""
echo -e "${BLUE}Uninstall:${NC}"
echo "  rm -rf $INSTALL_DIR"
