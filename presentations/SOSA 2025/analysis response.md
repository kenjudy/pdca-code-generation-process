  
● ANALYSIS PHASE: Adding Mermaid.js Output Support
  
 Executive Summary
  
 Your codebase currently outputs dependency graphs as PlantUML diagrams. You need to conditionally switch to Mermaid.js format. Based on architecture discovery, I've
 identified that your system uses a Strategy Pattern with Interface Abstraction that can be extended cleanly to support multiple output formats.
  
 ---
 1. EXISTING ARCHITECTURE PATTERNS DISCOVERED
  
 Current Design Pattern: Strategy Pattern with Single Implementation
  
 Key Components:
  
 IUmlDiagramGenerator (Interface)
   ↓ implements
 PlantUmlDiagramGenerator (Strategy)
   ↓ creates
 ClassStructurePlantUmlFileRenderer (Renderer)
   ↓ uses
 IScoredOutputNodeMap (Data Model)
  
 Single Instantiation Point:
 - File: DependencyTracer\PlantUml\PlantUmlDiagramGenerator.cs
 - Line 23: var renderer = new ClassStructurePlantUmlFileRenderer(scoredOutputNodeMap, symbolAnalyzer);
  
 Format Selection:
 - Currently hardcoded to PlantUML via the action=puml command-line argument
 - No abstraction for output format selection exists yet
 - Diagram TYPE selection (Class vs Sequence) uses UmlDiagramType enum with metadata attributes
  
 ---
 2. MERMAID.JS FORMAT REQUIREMENTS
  
 Syntax Comparison: PlantUML vs Mermaid.js
  
 | Feature      | PlantUML           | Mermaid.js         | Complexity          |
 |-------------------|-------------------------------|----------------------------|-------------------------------|
 | Class Diagrams  |                |              |                |
 | Wrapper      | @startuml / @enduml      | classDiagram        | Simple            |
 | Class definition | class Foo {}         | class Foo or class Foo {} | Simple            |
 | Visibility    | + - # ~            | + - # ~          | Identical           |
 | Methods      | + method(params) : returnType | +method(params) returnType | Simple (no colon)       |
 | Relationships   | `<              | --, *--, o--, -->, ..>`  | `<              |
 | Stereotypes    | <<interface>>         | <<Interface>>       | Simple (capitalization)    |
 | Namespaces    | namespace Foo {}       | namespace Foo {}      | Identical           |
 | Generics     | Foo<T>            | Foo~T~           | Medium (different delimiters) |
 | Notes       | note left of Foo       | note for Foo "text"    | Medium            |
 | Sequence Diagrams |                |              |                |
 | Wrapper      | @startuml / @enduml      | sequenceDiagram      | Simple            |
 | Participants   | participant Foo        | participant Foo      | Identical           |
 | Calls       | Foo -> Bar: method()     | Foo->>Bar: method()    | Simple (arrow syntax)     |
 | Activation    | activate Foo         | activate Foo or + suffix  | Simple            |
 | Deactivation   | deactivate Foo        | deactivate Foo or - suffix | Simple            |
 | Returns      | Foo --> Bar: return      | Foo-->>Bar: return     | Simple (arrow syntax)     |
 | Loops       | loop / end          | loop / end         | Identical           |
 | Notes       | note over Foo,Bar       | Note over Foo,Bar     | Simple (capitalization)    |
  
 Key Insight: Syntax is ~85% similar between PlantUML and Mermaid.js! Most differences are superficial (arrow styles, delimiters).
  
 ---
 3. RECOMMENDED APPROACHES
  
 Option A: Template Method Pattern (RECOMMENDED)
  
 Create abstract base renderer with format-specific subclasses
  
 AbstractDiagramRenderer (Abstract Base)
   ├─ PlantUmlDiagramRenderer (inherits)
   └─ MermaidJsDiagramRenderer (inherits)
  
 Pros:
 - ✅ Maximizes code reuse - shared logic in base class (80-90% of ClassStructurePlantUmlFileRenderer)
 - ✅ Minimizes redundancy - only format-specific syntax in subclasses
 - ✅ Strong cohesion - rendering logic grouped by format
 - ✅ Open/Closed Principle - easy to add new formats (GraphViz, D2, etc.)
 - ✅ Testable - can test shared logic once, format-specific logic separately
  
 Cons:
 - ⚠️ Requires refactoring ClassStructurePlantUmlFileRenderer into base + subclass
 - ⚠️ Medium complexity (20-30 hours initial refactoring)
  
 Implementation:
 1. Extract format-agnostic logic to AbstractCodeStructureRenderer
 2. Create format-specific methods as abstract (e.g., GetDiagramHeader(), FormatClassMember())
 3. Subclass for PlantUML and Mermaid.js
 4. Add format selection via new enum or configuration
  
 ---
 Option B: Strategy Pattern with Format Adapters
  
 Delegate format-specific rendering to adapter objects
  
 ClassStructureDiagramRenderer
   ├─ uses → IFormatAdapter
          ├─ PlantUmlFormatAdapter
          └─ MermaidJsFormatAdapter
  
 Pros:
 - ✅ Composition over inheritance - more flexible
 - ✅ No refactoring of existing ClassStructurePlantUmlFileRenderer
 - ✅ Runtime format switching possible
 - ✅ Good separation - format syntax isolated in adapters
  
 Cons:
 - ⚠️ More indirection - adapters add complexity
 - ⚠️ Potential duplication - adapters may duplicate rendering logic
 - ⚠️ Coupling - renderer must know all adapter methods
  
 ---
 Option C: Renderer Factory with Parallel Implementations
  
 Create completely separate renderers, selected by factory
  
 ICodeStructureRenderer (Interface)
   ├─ ClassStructurePlantUmlFileRenderer (existing)
   └─ ClassStructureMermaidJsFileRenderer (new, parallel)
  
 DiagramRendererFactory.Create(format) → ICodeStructureRenderer
  
 Pros:
 - ✅ No refactoring of existing code
 - ✅ Simple - clear separation
 - ✅ Safe - won't break existing PlantUML generation
  
 Cons:
 - ❌ Massive duplication - 1600+ lines duplicated between renderers
 - ❌ Maintenance nightmare - bugs must be fixed in both places
 - ❌ Violates DRY principle
 - ❌ Poor cohesion - same logic in multiple places
  
 ---
 4. COMPLEXITY ASSESSMENT
  
 Delegation Complexity: MEDIUM-HIGH
  
 Implementation Complexity: Medium-High
 - 1600+ line renderer class with complex conditional logic
 - Requires understanding PlantUML → Mermaid.js syntax mapping
 - Multiple rendering paths (Class, Sequence, Summary modes)
  
 Pattern Clarity: Clear
 - Existing strategy pattern is discoverable
 - Single instantiation point makes changes localized
 - Interface abstraction already exists
  
 Context Scope: Medium
 - 5-7 files need modification (renderer, generator, interface, factory, config)
 - No database/external dependencies
 - Well-isolated in PlantUml namespace
  
 Debugging Likelihood: Medium
 - Syntax differences will require iterative testing
 - Output validation against real Mermaid.js renderer needed
 - Edge cases (generics, nested types, special characters) require attention
  
 External System Integration: Simple
 - Mermaid.js is text-based output format (like PlantUML)
 - No API calls or parsing of external data
 - Validation possible with online Mermaid.js editor
  
 ---
 5. RECOMMENDED SOLUTION
  
 Option A: Template Method Pattern (Best for long-term maintainability)
  
 Why this approach:
 6. Minimizes redundant code - ~85% of logic is shared between formats
 7. Preserves coherence - rendering algorithm structure stays intact
 8. Maintains cohesion - format-specific concerns isolated to subclasses
 9. Future-proof - easy to add GraphViz, D2, or other formats later
  
 Existing Abstractions to Reuse:
 - IScoredOutputNodeMap - data model (no changes)
 - ISymbolAnalyzer - symbol analysis (no changes)
 - UmlDiagramType enum - diagram type selection (no changes)
 - IUmlDiagramGenerator - needs extension to accept format parameter
  
 Integration Touch Points:
 1. PlantUmlDiagramGenerator.cs (line 23) - instantiation logic
 2. OutputGenerator.cs (line 440) - generator creation
 3. Program.cs (line 24) - add new action=mermaid or generalize to format= parameter
 4. TracerOptions.cs - add OutputFormat configuration property
  
 ---
 6. FORMAT SELECTION STRATEGY
  
 Recommended: Configuration-Based Selection
  
 Add to TracerOptions.cs:
 public enum DiagramOutputFormat
 {
   PlantUml,
   MermaidJs
 }
  
 public DiagramOutputFormat OutputFormat { get; set; } = DiagramOutputFormat.PlantUml;
  
 Command-line argument:
 action=puml format=mermaid
  
 This allows:
 - Backward compatibility (default to PlantUML)
 - Future extensibility (add GraphViz, D2, etc.)
 - Per-project configuration via appsettings.json
  
 ---
 7. NEXT STEPS
  
 If proceeding with Option A (Template Method):
  
 8. Extract abstract base class from ClassStructurePlantUmlFileRenderer
 9. Identify format-specific methods to make abstract/virtual
 10. Create MermaidJsCodeStructureRenderer subclass
 11. Add format selection to configuration and command-line parsing
 12. Update factory/generator to instantiate correct renderer
 13. Write tests for both formats
 14. Add file extension logic (.puml vs .mmd)
  
 Estimated effort:
 - Initial refactoring: 12-16 hours
 - Mermaid.js implementation: 8-12 hours
 - Testing & edge cases: 6-8 hours
 - Total: 26-36 hours
  
 ---
 8. RISK AREAS TO MONITOR
  
 9. Namespace handling - PlantUML and Mermaid.js differ slightly
 10. Generic type syntax - Foo<T> vs Foo~T~
 11. Special characters - sanitization may differ between formats
 12. Notes positioning - syntax differs significantly
 13. Database diagrams - Mermaid.js has limited ER diagram support (may need fallback to PlantUML)
  
 ---
 Ready for Planning Phase? I can create a detailed, numbered implementation plan with TDD steps if you'd like to proceed with Option A.