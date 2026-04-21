# PDCA Framework Skill - Update Summary

## v1.0.3 (2026-04-21)

### Added
- `beads-setup.md`: Pre-flight Check section before Installation -- checks `bd --version`, `dolt version`, and `brew outdated beads dolt` before proceeding, with explicit upgrade commands and a warning against running `bd init` on outdated installs
- `beads-setup.md`: MCP server status check (`pip3 show beads-mcp`, `grep` against `claude_desktop_config.json`) before install instructions -- user knows whether to proceed without opening config manually
- `beads-setup.md`: "Initializing Beads in a Project" section with "Post-Init: Align CLAUDE.md with Working Agreements" subsection -- patches the autonomous-agent rules `bd init` generates to cooperate with human-in-the-loop working agreements; includes `.gitignore` reversal step
- `beads-workflow.md`: "Resume a Session" section immediately after Prerequisites -- `bd ready`, `bd list --status in_progress`, `bd show` orientation commands, now the first thing to read when returning to in-progress work
- `beads-workflow.md`: `brew outdated beads dolt` one-liner appended to Resume section as a periodic version check reminder
- `beads-workflow.md`: "Export Requirements Document" section with `export-requirements.sh` usage and a copyable `.claude/commands/requirements-doc.md` slash command template
- `beads-addon/scripts/export-requirements.sh`: new script to generate a structured requirements document from all open epics and their tasks (open or closed) using `bd graph --all --compact` for the dependency overview and `bd list --parent` for per-epic task detail
- 11 new tests in `TestBeadsWorkflowContent` covering all content changes above

### Changed
- `beads-workflow.md` Git Integration section: removed bare `git push` autonomous instruction; replaced with commit-only guidance and explicit note that pushing is human-initiated per working agreements
- `act-beads-addon.md` closing checklist: "Stored in git (.beads/dolt/)" updated to "Committed to git (.beads/) -- push when ready per working agreements"
- `build-skill.sh` post-build note: removed `.beads/*` `.gitignore` template that contradicted commit guidance; replaced with "commit .beads/ like any other project file"
- `.gitignore`: removed `.beads/` exclusion block -- beads data now committed in full alongside the code it tracks

### Fixed
- `beads-setup.md` and `build-skill.sh` no longer instruct users to exclude `.beads/` from version control, which conflicted with the goal of persistent cross-session task tracking

---

## v1.0.2 (2026-03-27)

### Added
- `testing-anti-patterns.md` reference file in DO phase — adapted from obra/superpowers (MIT) with PDCA-specific additions covering six common TDD anti-patterns
- SKILL.md now links to the anti-patterns reference from the DO phase description
- CLAUDE.md at repo root incorporating session startup, beads workflow, and supervision rules from AGENTS.md for Claude Code auto-loading
- `.gitignore` suppresses iCloud sync conflict duplicates (`* 2.*`)

### Fixed
- `rubric_1b.py` clarified that ASCII structural diagrams are not "runnable code" violations
- Build pipeline (bash + PS1) and test_build.py updated for new anti-patterns file
- Enhanced GitHub Actions metrics workflows with percentile stats and commit quality scoring

## What Changed

Your PDCA skill has been updated with your latest prompts and working agreements from your GitHub repository.

### Major Updates

#### 1. **PLAN Phase - Analysis (1a)**
**New additions:**
- **Mandatory Architecture Pattern Discovery** - Three required codebase searches BEFORE any analysis
- **External System Validation** - Mandatory validation of external APIs/formats before implementation
- **Delegation Complexity Assessment** - Structured evaluation of task complexity
- **STOP CONDITIONS** - Blocking checkpoints to ensure proper pattern discovery

**Impact:** This prevents architectural drift and ensures AI agents discover and follow existing patterns before proposing solutions.

#### 2. **PLAN Phase - Detailed Planning (1b)**
**New additions:**
- **Execution Context** - Explicit guidance about TDD discipline and human supervision
- **Compilation ≠ Red Phase** - Clarification that compilation errors are not valid TDD red phase
- **Model Match Verification** - Checkpoint to ensure appropriate model complexity for task

**Impact:** Better alignment of agent behavior with TDD principles and more appropriate model selection.

#### 3. **DO Phase - TDD Implementation (2)**
**New additions:**
- **Integration Testing Emphasis** - Default to real components over mocks
- **Production Bug Handling** - Specific guidance for when unit tests can't replicate production bugs
- **Test Fixture Guidance** - Prefer adding to existing fixtures vs. creating new files
- **Real-World Validation** - Mandatory inspection of external system behavior before implementation

**Key principle changes:**
- ❌ DON'T test interfaces - test concrete implementations
- ❌ DON'T use compilation errors as RED phase
- ✅ DO create stub implementations that compile but fail behaviorally
- ✅ DO use real components over mocks when possible

**Impact:** Stronger emphasis on integration testing and real-world validation, reducing mock-heavy testing that misses production issues.

#### 4. **Working Agreements**
**Changes:**
- "STRICT TDD FOR ALL CHANGES" → "USE TDD FOR CHANGES" (slightly softer language)
- Removed redundant "Session Startup Protocol" section
- Maintained all 10 implementation guidelines unchanged

**Impact:** More pragmatic language while maintaining process discipline.

#### 5. **License & Attribution**
**Added to all files:**
- Creative Commons Attribution 4.0 International (CC BY 4.0)
- Attribution to Ken Judy with Claude Anthropic 4
- Link to GitHub repository
- Living document philosophy

### What Stayed the Same

- CHECK phase prompts (completeness verification)
- ACT phase prompts (retrospection structure)
- Overall PDCA cycle structure
- Human commitments for each phase
- Context drift recovery guidance

## Key Philosophy Shifts

### 1. Architecture-First Approach
The new analysis phase **requires** discovering existing patterns before proposing solutions. This prevents AI agents from inventing new abstractions when existing ones would suffice.

### 2. Integration Over Isolation
Strong preference for integration tests with real components over unit tests with mocks. Recognizes that many production bugs occur at integration boundaries.

### 3. Real-World Validation
Mandatory validation of external system behavior before implementation. No assumptions about data formats without seeing real examples.

### 4. Compilation vs. Behavior
Clear distinction that compilation is not TDD red phase - behavioral failures are. This prevents false reds from symbol resolution issues.

## How These Changes Help

**Reduces Technical Debt:**
- Mandatory pattern discovery prevents proliferation of new abstractions
- Real-world validation prevents assumptions that lead to bugs
- Integration testing catches issues unit tests miss

**Improves Code Quality:**
- Following existing patterns maintains consistency
- Testing real components reduces mock-heavy test suites
- Production bug handling ensures proper test coverage

**Better Human-AI Collaboration:**
- STOP conditions force critical thinking checkpoints
- Delegation complexity assessment helps right-size AI involvement
- Clear red/green definitions prevent confusion

## Files Updated

1. `references/plan-prompts.md` - Analysis and planning templates
2. `references/do-prompts.md` - TDD implementation guidance
3. `references/working-agreements.md` - Human commitments
4. `SKILL.md` - Added license and attribution

## Using the Updated Skill

The updated skill file `pdca-framework.skill` is in your outputs directory. Simply:

1. Remove the old version from Claude (if installed)
2. Upload the new version
3. All your conversations will now use the updated prompts

The skill will automatically load the new templates when triggered, so no changes to your workflow are needed.

---

**Generated:** 2025
**Version:** Based on GitHub repository prompts as of upload date
