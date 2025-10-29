# Project Development Workflow

This project follows a strict PDCA (Plan-Do-Check-Act) development process with TDD discipline.

## Workflow Phases

### Phase 1a: Analysis (MANDATORY FIRST)
- Execute codebase_search to discover existing patterns
- Validate external system formats before making assumptions
- Document architectural constraints
- Assess delegation complexity

### Phase 1b: Planning
- Create numbered, atomic implementation steps
- Define testing strategy (TDD with red-green-refactor)
- Identify integration touch points
- Plan for incremental delivery

### Phase 2: Test-Driven Implementation
**CRITICAL RULES:**
- ❌ DON'T test interfaces - test concrete implementations
- ❌ DON'T use compilation errors as RED phase
- ✅ DO write failing behavioral tests FIRST
- ✅ DO use real components over mocks
- Max 3 iterations per red-green cycle

### Phase 3: Completeness Check
- Verify all objectives met
- Audit process discipline
- Confirm no TODOs remain

### Phase 4: Retrospection
- Analyze critical moments
- Extract actionable insights
- Update working agreements

## Testing Conventions
- NUnit with Assert.That syntax
- Leverage TestUtils.cs and fixtures directory
- Add tests to existing fixtures when coherent
- Avoid proliferating new test files

## Process Checkpoints
Before proceeding with implementation:
- [ ] Have I searched for similar implementations?
- [ ] Have I validated external system formats?
- [ ] Have I written a FAILING test first?
- [ ] Am I implementing ONLY enough to pass the test?