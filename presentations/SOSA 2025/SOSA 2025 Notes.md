
**Author:** Ken Judy  
**Links:** [LinkedIn](https://www.linkedin.com/in/kenjudy/) | [GitHub](https://github.com/kenjudy) | [Stride](https://stride.build/)

---

## Business Context: Software Development with LLMs

### Current Landscape

- **Hype curve:** Sentiment whiplash, low credibility, high investment
- **Tech sector correction:** Low trust environment
- **Leadership focus:** Increased profits and cost savings from AI
- **Management focus:** Demonstrate adoption through usage metrics (% of generated code adopted)

### Core Problems

- General lack of understanding of what software engineering is
- Poor measurement of code quality or delivery in terms of impact/results
- Expecting developers to stay accountable through passive code review of massive AI-generated code chunks

---

## The Research

### Productivity Paradox

Research shows developers are often faster with AI, but this isn't leading to faster delivery:

- **METR study:** Experienced developers 19% slower (vs. predictions of 39% faster)
- **Google DORA 2024:** Every 25% increase in AI adoption = 7.2% decrease in delivery stability
- **GitHub data:** Least experienced developers showing greatest increase in output

### Quality Degradation

- **GitClear (211M lines):** 10x increase in duplicated code blocks in 2024 vs. 2022
    - First year copy/paste exceeded moved code (since 2020)
- **Wagner et al.:** 17% of cloned code contains bugs
- **Mondal et al.:** 18.42% of bugs propagate to other copies
- **Impact:** Type 3 cloning makes troubleshooting more expensive and riskier

### Sustainability Concerns

- **ChatGPT alone:** 1 GWh daily (equivalent to 33,000 US households)
- **CISQ 2022:** $1.52 trillion in US technical debt

---

## Why Plan-Do-Check-Act (PDCA)?

### The Root Cause

"Unstructured approach optimizes immediate output while undermining maintainability" (GitClear)

**Don't focus on tool limitations — close process gaps**

### Our Opportunity

We already know rapid delivery requires systematic practices:

- **Sahoo et al. 2024:** Structured prompting outperforms ad-hoc by 1-74%
    - Why agentic coding environments have introduced planning mode
- **Ning et al. 2010:** PDCA reduced software defects by 61%

### PDCA Framework

- **Repository:** https://github.com/kenjudy/pdca-code-generation-process
- **Working Agreements:** https://github.com/kenjudy/pdca-code-generation-process/blob/main/Human%20Working%20Agreements.md

---

## Plan Phase: High-Level Analysis

### Analysis Instructions

https://github.com/kenjudy/pdca-code-generation-process/blob/main/1.%20Plan/1a%20Analyze%20to%20determine%20approach%20for%20achieving%20the%20goal.md

### Analysis Prompt

```
I currently have a @ClassStructurePlanUmlFileRenderer.cs that outputs subgraphs 
of a code syntax tree as PlantUML class diagrams and sequence diagrams. I need to 
be able to conditionally switch that output to Mermaid.js format. Per the PDCA 
skill, analyze the best approach to doing this that minimizes redundant code and 
best preserves coherence and cohesion.
```

**Response:** [[analysis response]]

---

## Plan Phase: Detailed Breakdown

### Planning Instructions

https://github.com/kenjudy/pdca-code-generation-process/blob/main/1.%20Plan/1b%20Create%20a%20detailed%20implementation%20plan.md

### Planning Prompt

```
Per PDCA skill, create your plan for implementing Mermaid.js diagrams.
```

**Response:** [[detailed planning response]]

---

## Do Phase: Implementation

### Implementation Instructions

https://github.com/kenjudy/pdca-code-generation-process/blob/main/2.%20Do/2.%20Test-Driven%20Implementation.md

### Implementation Prompt

```
Write out the plan in markdown to /plans so I can track progress. Then per PDCA 
skill, test drive the implementation (Do phase).
```

### Implementation Summary

**Commits:** 11 total

**Statistics:**

- **Total Files Changed:** 39
- **New Production Code Files:** 4
- **New Test Files:** 14
- **Lines of Production Code Added:** ~750+
- **Lines of Test Code Added:** ~1,500+
- **Test Coverage:** Comprehensive unit and integration tests for both PlantUML and Mermaid.js paths

---

## Key Human Interventions

### #0: Refactoring Strategy

**Intervention:** "Extract to abstract class, prove zero regressions, THEN add new implementation"

- **Enforced:** Separate refactoring from feature work; validate before proceeding

### #1: Architectural Naming

**Intervention:** "Mermaid.js in PlantUml namespace needs renaming"

- **Action:** PlantUml → Diagrams namespace
- **Enforced:** Name things for what they ARE, not what they WERE

### #2: History Preservation

**Intervention:** "Use git operation to preserve history"

- **Action:** `mv` → `git mv`
- **Enforced:** Refactoring must preserve git blame/evolution

### #3: Blast Radius Control

**Intervention:** "Isn't CreateClassHierarchy used for PlantUml tests?"

- **Action:** Blocked modification of shared utility used by 8+ tests
- **Enforced:** Adjust test expectations, not shared infrastructure

### #4: Domain Semantics

**Intervention:** "ILogger might be relevant in a class diagram?"

- **Clarification:** ILogger as separate class + relationship, NOT as ConsoleLogger member
- **Enforced:** Domain correctness over test convenience

### Pattern

Human set methodology (#0) then enforced discipline (#1-4) when AI took expedient shortcuts over principled refactoring.

---

## Check Phase: Completeness Verification

### Completeness Check Instructions

https://github.com/kenjudy/pdca-code-generation-process/blob/main/3.%20Check/3.%20Completeness%20Check.md

**Note:** Completion check performed as part of implementation checklist per the skill

**Response:** [[check response]]

---

## Act Phase: Retrospection

### Retrospection Instructions

https://github.com/kenjudy/pdca-code-generation-process/blob/main/4.%20Act/4.%20Retrospect%20for%20continuous%20improvement.md

### Retrospection Prompt

```
Per PDCA skill, retrospect so I can act on what we've learned to improve the next session.
```

**Response:** [[retrospective response]]

---

## Total Model Usage (All Cycles)

### Overall Activity

- **Total tokens:** 46.9M across 14 API requests
- **Input:** 46.7M tokens (99.5%)
- **Output:** 225K tokens (0.5%)
- **Web searches:** 2 (during the 17:00 hour)

### Cache Performance

**Cache efficiency:** 1,635% - reading from cache over 16x more than writing

- Cache writes: 2.7M tokens
- Cache reads: 43.5M tokens
- Non-cached input: 525K tokens

### Model Split

- **Claude Sonnet 4.5:** 97% of activity (45.5M tokens) - primary workhorse
- **Claude Haiku 4.5:** 3% of activity (1.4M tokens) - quick operations

### Activity Timeline (UTC)

- **13:00-14:00:** Light activity (18-19K tokens/hour) - ramping up
- **17:00:** Moderate ramp (1.5M tokens) - included 2 web searches
- **18:00-20:00:** Peak intensive work (13-14.6M tokens/hour) - sustained heavy lifting with large context windows
- **21:00:** Winding down (3.4M tokens) - still significant but declining

**Peak Hour:** 20:00 UTC with 14.6M tokens processed, demonstrating intensive coding work with massive context utilization.
