# DO Phase Prompts

## TDD Implementation Checklist

**Purpose:** Execute planned changes using strict Test-Driven Development discipline
**Duration:** Variable (15 minutes to several hours depending on scope)
**Prerequisites:** Detailed implementation plan with atomic steps defined
**Next step:** Completeness check (3) when all planned steps complete
**Critical:** Human must intervene immediately when TDD discipline breaks

If possible, rather than trigger a build, switch to agent mode and use this prompt to provide guidance to the build.

```markdown
Try to add tests to existing fixtures where the tests fit coherently into the concerns of that fixture rather than proliferate new test files.

**TDD Implementation**

1. ❌ DON'T test interfaces - test concrete implementations
2. ❌ DON'T use compilation errors as RED phase - use behavioral failures  
3. ✅ DO create stub implementations that compile but fail behaviorally
4. ✅ DO use real components over mocks when possible
   
   THIS MEANS: Compilation errors are not a valid red. A red test is when an invocation does not meet the expectation. So, that would imply the project can compile and the method stubs exist but the behavior is not fully implemented.

**🚨 TDD DISCIPLINE CHECK 🚨**
- [ ] Have I written a FAILING test first? (RED phase mandatory)
- [ ] Am I implementing ONLY enough to make the test pass? (GREEN phase)
- [ ] Is this test simple enough? (Complex scenarios → simplify first)
- [ ] Am I using mocks when I should be using real components
- [ ] Did I check how existing code handles this pattern?

**Integration Tests & Real-World Validation**
- [ ] Default to real components + temporary resources
- [ ] Question complex mocking: Ask "Why not use real File access with temporary directories?"
- [ ] **CRITICAL**: Before implementing any external system integration, inspect actual system behavior/outputs first
- [ ] Build end-to-end scaffolding early, not as an afterthought
- [ ] Test against real data/systems before optimizing unit tests
      
**When Unit Tests Can't Replicate Production Bugs:**
If you have production evidence (logs, metrics) proving a bug exists but unit tests pass:
- **Diagnosis:** Testing at wrong scope - unit test fixtures too small to trigger scale-dependent behavior
- **Solution 1 (PREFERRED):** Write integration test with realistic data scale (accept slower execution)
- **Solution 2 (ACCEPTABLE):** Write unit-level regression test AND document production evidence in test comments
- **Anti-pattern:** Never call it RED phase if test passes - be honest it's a regression test
- **Required:** Commit message must include production metrics showing bug before/after (node counts, file sizes, performance data)
    
**AI Command Transparency:**
- [ ] Show reasoning, particularly when you need to deviate from plan.

**Current step:** 
**Red phase:** Write the failing test first (NO exceptions)
**Green phase:** Make it pass with minimal code
**Refactor:** Clean up if needed

**Test Complexity Management:**
- Start with single-file, basic scenarios
- Avoid multi-file compilations initially
- If test setup gets complex, simplify the scenario
- Build complexity gradually in subsequent iterations

**Ready for commit?** 
- [ ] Test written and failing first ✅
- [ ] Implementation makes test pass ✅
- [ ] Code is clean ✅
- [ ] TDD discipline maintained ✅
- [ ] Commit message ready

**Next:** What's the next smallest testable piece?
**⚠️ Process Police Alert:** User should intervene if TDD discipline breaks!
```

**Human's Commitment:** Follow the agent's internal conversation as it proceeds. Intervene and ask questions as soon and as often as needed. This reduces wasted tokens and code that needs to be reverted.

## Context Drift Recovery

If you notice the agent making changes without test driving, making sprawling edits, or breaking rules of engagement:

**Steps:**
1. Stop the thread immediately
2. Tell it what you observe happening
3. Repost the relevant DO phase prompts
4. Tell it to proceed with renewed focus

**Example intervention:**
"You're making changes across multiple files without writing tests first. Let's stop and refocus. We need to follow our TDD discipline. Please review the implementation guidelines and continue with step [X], starting with a failing test."

## Handling Test Regressions

When existing tests break due to recent changes:

```markdown
We have failing tests in [Reference Test Fixture]. These failures may be due to recent changes that introduced regressions. 

**Regression Analysis First:**
- Analyze ALL failing tests together before starting fixes to identify common patterns
- Understand what changed in the production code that caused these failures
- Determine if tests expect old behavior or if production behavior changed intentionally

**Change Discipline:**
Be careful not to change both production code and test expectations in one pass as that might change behavior. So, you are free to adjust test setup. But stop and ask permission to change production code or expectations. So that we can agree on the changes. 

**Batch Processing:**
- When you identify a common pattern across multiple failing tests, propose batching similar fixes
- Apply TDD discipline: one test or logical batch at a time, red/green/refactor

**Validation:**
When a broken test goes green, re-run the fixture to ensure no further regressions.

**Focus Areas:**
- Implementation details vs. behavior: Are tests failing due to logging levels, error messages, or actual behavior changes?
- Configuration thresholds: Are failures due to environment-specific settings (timeouts, limits, etc.)?
- Expected failure modes: Do tests expect certain exceptions/failures that no longer occur?
```

## Code Reuse Opportunities

After completing a section of work:

```markdown
Review the code we have generated to meet this objective. Suggest opportunities to improve supportability through code reuse. Do not change code.
```

This identifies refactoring opportunities without triggering premature optimization.
