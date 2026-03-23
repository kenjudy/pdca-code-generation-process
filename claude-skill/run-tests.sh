#!/bin/bash
# Canonical test runner for PDCA Framework Skill
# Builds the skill package, then runs the unit test suite (no API calls).
# Used by: git pre-commit hook (warn-only) and GitHub Actions CI (enforcing).
#
# Exit codes:
#   0 — tests passed (or --warn-only mode)
#   1 — tests failed (default; CI uses this to block merges)
#
# Usage:
#   bash run-tests.sh              # exit 1 on failure (CI mode)
#   WARN_ONLY=1 bash run-tests.sh  # exit 0 always (hook mode)
#
# For LLM eval tests (requires ANTHROPIC_API_KEY, incurs API cost):
#   bash run-evals.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WARN_ONLY="${WARN_ONLY:-0}"

echo "=== Building PDCA Framework Skill ==="
bash "$SCRIPT_DIR/build-skill.sh"

echo ""
echo "=== Running Test Suite ==="
set +e
(cd "$SCRIPT_DIR" && uv run python -m pytest tests/ -m "not eval" -v) 2>&1
TEST_EXIT=$?
set -e

if [ "$TEST_EXIT" -eq 0 ]; then
    echo ""
    echo "✓ All tests passed."
    exit 0
else
    echo ""
    echo "✗ Tests failed (exit $TEST_EXIT)."
    if [ "$WARN_ONLY" = "1" ]; then
        echo "  (warn-only mode — commit allowed)"
        exit 0
    else
        exit 1
    fi
fi
