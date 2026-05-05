# Testing Anti-Patterns Reference

> Adapted from [obra/superpowers](https://github.com/obra/superpowers/tree/main/skills/test-driven-development)
> Copyright (c) 2025 Jesse Vincent. MIT License.
> Adapted for the PDCA Framework by Ken Judy.

Core principle: **Test what the code does, not what the mocks do.**

---

## 1. Testing Mock Behavior

Verifying that a mock was called rather than that the system behaved correctly. If your assertion is checking a mock expectation rather than an observable outcome, delete it.

*Ask yourself:* "Am I testing the behavior of a mock?" If yes — remove the assertion or stop mocking.

---

## 2. Mocking Without Understanding

Adding mocks based on assumptions about what a dependency does, before running the real implementation. This produces tests that pass even when the assumption is wrong.

*Rule:* Run tests with real implementations first to understand actual behavior. Add mocks only at confirmed infrastructure boundaries (external services, filesystem, database, clock).

---

## 3. Incomplete Mocks

Returning only the fields your current test needs from a mock response. When the production code path changes, incomplete mocks silently mask regressions.

*Rule:* Mirror the complete real API response shape — not just the fields you're asserting on right now.

---

## 4. Test-Only Methods in Production Code

Adding public methods or hooks solely for test cleanup or inspection pollutes the production API.

*Rule:* Move any test-only behavior into dedicated test utilities. If you find yourself adding a method "just for tests," stop and restructure.

---

## 5. Tests Written After Code

Tests written after implementation answer "What does this do?" Tests written first answer "What should this do?" Only tests-first catch the wrong design early.

*Consequence:* Tests that pass immediately after being written prove nothing. If your test never failed, you don't know it tests the right thing.

---

## 6. Integration Tests as Afterthought

Treating integration coverage as optional cleanup after unit tests are written misses the boundary behaviors that matter most.

*Rule:* Integration tests belong in the test sequence from the start — include them in the test list during planning (Phase 1b), not after the fact.

---

## 7. Vacuous Greens

A test that passes immediately against the current stub without any production code change. Vacuous greens feel like progress but provide no genuine RED phase — you cannot know the test is testing the right thing.

*Diagnosis:* If the next test in sequence would pass trivially against the current stub, it is a vacuous green.

*Rule:* Skip to the first test in your sequence that the current stub cannot satisfy — that is your genuine RED. Document the skipped tests as guards to add after real implementation replaces the stub. State the called shot for the test you are actually going to write, not the one you are skipping.

**Sub-case: Ordering-Triggered Vacuous Green**

Starting with the happy-path test can force the stub to grow into a full implementation, making all subsequent conditional-branch tests vacuously green. Symptom: test #2 passes immediately because test #1 already required implementing the conditional logic.

*Ask before choosing the first test:* "If I implemented only the happy path with no conditionals, would this test pass?" If yes, choose a different first test -- one that targets the conditional branch.

*Prevention:* When the feature includes conditional branches, start with the test that isolates the most conditional behavior. The happy-path test written after a genuine RED/GREEN cycle is documentation; written first, it is a trap.

*Persistent context:* In longer DO phase sessions, record the ordering decision in beads task notes at the start so it survives context compaction. `bd show [task-id]` recovers the decision before writing a GREEN phase.

*Attribution: Anti-Pattern #7 (Happy-Path Tunnel Vision) from [afbreilyn/afb-tdd](https://github.com/afbreilyn/afb-tdd) -- "for every happy-path test, ask what are all the ways this can fail and write a test for each answer."*

---

## Quick Check Before Committing

- [ ] Every assertion is on real behavior, not mock call counts
- [ ] Mocks exist only at infrastructure boundaries
- [ ] Mock responses mirror the full real API shape
- [ ] No production methods exist solely for test access
- [ ] Every test watched fail before watching it pass
