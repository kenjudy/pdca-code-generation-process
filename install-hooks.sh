#!/bin/bash
# Install git hooks for this repository.
# Run once after cloning: bash install-hooks.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
GIT_HOOKS_DIR="$REPO_ROOT/.git/hooks"

if [ ! -d "$GIT_HOOKS_DIR" ]; then
    echo "Error: .git/hooks not found. Run this from within a git repository."
    exit 1
fi

cp "$SCRIPT_DIR/hooks/pre-commit" "$GIT_HOOKS_DIR/pre-commit"
chmod +x "$GIT_HOOKS_DIR/pre-commit"

echo "✓ Installed pre-commit hook → .git/hooks/pre-commit"
echo "  Tests will run (warn-only) before each commit."
