# PDCA Framework Skill - Update Summary

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
