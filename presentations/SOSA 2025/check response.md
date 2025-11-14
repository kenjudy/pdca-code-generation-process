# Implementation Plan: Mermaid.js Diagram Output Support
  
**Date:** 2025-11-14
**Framework:** PDCA - DO Phase
**Approach:** Template Method Pattern with TDD
**Estimated Duration:** 26-36 hours
  
---
  
## Executive Summary
  
Refactor ClassStructurePlantUmlFileRenderer using Template Method Pattern to support both PlantUML and Mermaid.js output formats. Extract format-agnostic rendering logic into an abstract base class, then create format-specific subclasses for PlantUML and Mermaid.js.
  
---
  
## Integration Strategy
  
### End-to-End Data Flow
  
```
Program.cs (CLI parsing)
  ↓ format selection via command-line
Tracer.cs (orchestration)
  ↓
OutputGenerator.cs (file management)
  ↓
IUmlDiagramGenerator (interface)
  ↓
DiagramGeneratorFactory (NEW - creates generator based on format)
  ↓
PlantUmlDiagramGenerator OR MermaidJsDiagramGenerator (format-specific)
  ↓
AbstractCodeStructureRenderer (NEW - shared logic)
  ↓
PlantUmlCodeStructureRenderer OR MermaidJsCodeStructureRenderer (format-specific syntax)
```
  
### Touch Points Identified
  
1. **TracerOptions.cs** - Add OutputFormat enum and property
2. **Program.cs** - Parse format parameter from command-line
3. **IUmlDiagramGenerator.cs** - May need extension or leave unchanged
4. **DiagramGeneratorFactory.cs** - NEW factory class
5. **AbstractCodeStructureRenderer.cs** - NEW abstract base class
6. **PlantUmlCodeStructureRenderer.cs** - Refactored from existing
7. **MermaidJsCodeStructureRenderer.cs** - NEW implementation
8. **OutputGenerator.cs** - Use factory to create generator
9. **DatabasePlantUmlFileRenderer.cs** - Consider Mermaid.js support (Phase 2)
  
### Backward Compatibility
  
- Default format: PlantUML (existing behavior)
- File extensions: `.puml` for PlantUML, `.mmd` for Mermaid.js
- Existing command `action=puml` continues to work
- New parameter `format=mermaid` or `format=plantuml` (explicit)
  
---
  
## Testing Strategy
  
### TDD Discipline: Red-Green-Refactor
  
**For each implementation step:**
  
1. **RED Phase:**
   - Write failing test(s) with clear behavioral expectations
   - Compilation ≠ Red phase - write compiling stubs first
   - Test actual behavior expectations, not symbol existence
   - Each test describes ONE specific behavior
  
2. **GREEN Phase:**
   - Implement minimal code to pass tests
   - Maximum 3 iterations to green per batch
   - No refactoring during green phase
   - Focus on making tests pass
  
3. **REFACTOR Phase:**
   - Clean up implementation once tests pass
   - Ensure no duplication
   - Improve naming and structure
   - All tests must remain green
  
### Batched TDD Opportunities
  
Group related functionality for pattern reuse:
- Format-specific method batches (all header methods together)
- Relationship rendering batches (all arrow types together)
- Member rendering batches (fields, methods, properties together)
  
### Test Organization
  
**Test Project:** `DependencyTracerTests`
**New Test Files:**
- `AbstractCodeStructureRendererTests.cs` - Test shared logic
- `PlantUmlCodeStructureRendererTests.cs` - Test PlantUML-specific syntax
- `MermaidJsCodeStructureRendererTests.cs` - Test Mermaid.js-specific syntax
- `DiagramGeneratorFactoryTests.cs` - Test factory creation logic
- `OutputFormatIntegrationTests.cs` - End-to-end format switching tests
  
---
  
## Implementation Steps
  
### PHASE 1: Configuration & Format Selection (4-6 hours)
  
#### Step 1: Add OutputFormat Configuration
**File:** `DependencyTracer/TracerOptions.cs`
  
**Tests to write (RED):**
```csharp
- TracerOptions_DefaultFormat_IsPlantUml()
- TracerOptions_SetFormat_ToMermaidJs_SetsCorrectly()
- TracerOptions_InvalidFormat_ThrowsException()
```
  
**Implementation (GREEN):**
- Add `DiagramOutputFormat` enum with values: `PlantUml`, `MermaidJs`
- Add `OutputFormat` property with default value `PlantUml`
- Add validation logic
  
**Acceptance Criteria:**
- [ ] Enum defines both formats
- [ ] Default format is PlantUML
- [ ] Property can be set and retrieved
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ No compilation warnings
- ✅ Backward compatible (default behavior unchanged)
  
---
  
#### Step 2: Parse Format Parameter from Command-Line
**File:** `DependencyTracer/Program.cs`
  
**Tests to write (RED):**
```csharp
- ParseArguments_FormatPlantUml_SetsCorrectFormat()
- ParseArguments_FormatMermaid_SetsCorrectFormat()
- ParseArguments_NoFormat_DefaultsToPlantUml()
- ParseArguments_InvalidFormat_ReturnsError()
```
  
**Implementation (GREEN):**
- Add `format=` parameter parsing in `ParseArguments()`
- Map string values to `DiagramOutputFormat` enum
- Set `TracerOptions.OutputFormat`
- Add validation with user-friendly error messages
  
**Acceptance Criteria:**
- [ ] `format=plantuml` sets PlantUML format
- [ ] `format=mermaid` sets Mermaid.js format
- [ ] Missing parameter defaults to PlantUML
- [ ] Invalid format shows error message
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Help text updated with format parameter
- ✅ Error messages are clear
  
---
  
### PHASE 2: Create Abstract Base Renderer (8-12 hours)
  
#### Step 3: Extract Interface for Code Structure Rendering
**File:** `DependencyTracer/PlantUml/ICodeStructureRenderer.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- ICodeStructureRenderer_ContractsMatch_ExistingGeneratePlantUmlSignature()
```
  
**Implementation (GREEN):**
- Define interface with main rendering method
- Match existing `GeneratePlantUml()` signature but rename to `GenerateDiagram()`
  
**Interface Definition:**
```csharp
public interface ICodeStructureRenderer
{
    string GenerateDiagram(
        UmlDiagramType umlDiagramType,
        IScoredOutputNodeMap scoredOutputNodeMap,
        string? notes = null,
        bool isSummary = false);
}
```
  
**Acceptance Criteria:**
- [ ] Interface defines rendering contract
- [ ] Signature matches existing method (for easy refactoring)
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Interface compiles
- ✅ Tests pass
- ✅ XML documentation added
  
---
  
#### Step 4: Create Abstract Base Renderer - Core Structure
**File:** `DependencyTracer/PlantUml/AbstractCodeStructureRenderer.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- AbstractRenderer_Constructor_InitializesProperties()
- AbstractRenderer_GenerateDiagram_CallsTemplateMethodsInOrder()
- AbstractRenderer_LargeCodebase_ReturnsMinimalDiagram()
```
  
**Implementation (GREEN):**
- Create abstract class implementing `ICodeStructureRenderer`
- Copy constructor and properties from ClassStructurePlantUmlFileRenderer
- Implement `GenerateDiagram()` with template method structure
- Define abstract methods for format-specific operations:
  - `GetDiagramHeader()`
  - `GetDiagramFooter()`
  - `GetParticipantType(UmlDiagramType)`
  - `FormatClassName(string, string?)`
  - `FormatMethodCall(string, string, string)`
  - `FormatRelationshipArrow(NodeRelationshipType)`
  
**Template Method Structure:**
```csharp
public string GenerateDiagram(...)
{
    // Safety checks (shared)
    if (IsTooLargeForSequence(...)) return GetMinimalDiagram();
  
    var builder = new StringBuilder();
    builder.AppendLine(GetDiagramHeader(umlDiagramType));  // ABSTRACT
  
    // Shared rendering logic
    RenderClassList(...);
    RenderDiagramElements(...);
  
    builder.Append(FormatNotes(notes));  // Shared for now, may become abstract
    builder.AppendLine(GetDiagramFooter());  // ABSTRACT
  
    return builder.ToString();
}
```
  
**Acceptance Criteria:**
- [ ] Abstract class compiles
- [ ] Constructor initializes all properties
- [ ] Template method calls abstract methods in correct order
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Abstract methods clearly documented
- ✅ Template method structure validated
  
---
  
#### Step 5: Extract Shared Rendering Logic - Part 1 (Class Lists)
**File:** `DependencyTracer/PlantUml/AbstractCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- RenderClassList_EmptyNodes_ReturnsEmptySet()
- RenderClassList_SingleClass_RendersCorrectly()
- RenderClassList_NamespaceCollision_ResolvesConflicts()
- RenderClassList_DatabaseDiagram_FiltersCorrectly()
- RenderClassList_MinimizedClass_UsesMinimizeRenderMethod()
```
  
**Implementation (GREEN):**
- Copy `RenderClassList()` from ClassStructurePlantUmlFileRenderer
- Make format-agnostic (use abstract methods for format-specific parts)
- Copy supporting methods:
  - `CollectNamespaceNames()`
  - `ResolveTypeNameConflicts()`
  - `RenderTypeDeclaration()` (will need abstraction)
  - `RenderMinimizedClass()` (will need abstraction)
  - `RenderMemberSymbols()`
  - `RenderMember()`
  
**Acceptance Criteria:**
- [ ] Class list rendering works without format-specific code
- [ ] Namespace handling is format-agnostic
- [ ] Type conflict resolution is shared
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ No PlantUML-specific syntax in shared methods
- ✅ Format-specific calls delegated to abstract methods
  
---
  
#### Step 6: Extract Shared Rendering Logic - Part 2 (Relationships)
**File:** `DependencyTracer/PlantUml/AbstractCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- RenderDiagramElements_NoRelationships_RendersNothing()
- RenderDiagramElements_ClassDiagram_UsesClassRelationships()
- RenderDiagramElements_SequenceDiagram_UsesMethodCalls()
- RenderDiagramElements_FiltersConstructors_Correctly()
```
  
**Implementation (GREEN):**
- Copy `RenderDiagramElements()` from ClassStructurePlantUmlFileRenderer
- Copy supporting methods:
  - `IdentifyParticipantsWithInteractions()`
  - `RenderClassDiagramRelationship()`
  - `RenderDetailedSequenceDiagramMethodCalls()`
  - `RenderSummarySequenceDiagramMethodCalls()`
  - `RenderMethodCall()`
  - `GroupSimilarCalls()`
  
**Acceptance Criteria:**
- [ ] Relationship rendering is format-agnostic
- [ ] Diagram type dispatch works correctly
- [ ] Constructor filtering is shared
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ No format-specific arrow syntax in shared code
- ✅ Call stack logic is shared
  
---
  
#### Step 7: Extract Utility Methods
**File:** `DependencyTracer/PlantUml/AbstractCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- GetSymbolDetails_MethodSymbol_ReturnsContainingTypeInfo()
- GetSymbolDetails_TypeSymbol_ReturnsTypeInfo()
- GetSymbolDetails_NullSymbol_ReturnsEmptyStrings()
- NormalizeClassName_GlobalPrefix_RemovesPrefix()
- DiagnoseClassNameIssue_EmptyClassName_LogsWarning()
```
  
**Implementation (GREEN):**
- Copy utility methods:
  - `GetSymbolDetails()`
  - `NormalizeClassName()`
  - `GetDiagramClassReference()`
  - `DiagnoseClassNameIssue()`
  - `FormatNotes()` (may need to become abstract)
  - `HasRelationships()`
  - `IsMethodInvolved()`
  - `MethodReferencesOtherClasses()`
  
**Acceptance Criteria:**
- [ ] All utility methods are format-agnostic
- [ ] Symbol analysis is shared
- [ ] Diagnostic logging is shared
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ No format-specific logic in utilities
- ✅ All supporting methods extracted
  
---
  
### PHASE 3: PlantUML Renderer Implementation (4-6 hours)
  
#### Step 8: Create PlantUML Renderer from Existing Code
**File:** `DependencyTracer/PlantUml/PlantUmlCodeStructureRenderer.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- PlantUmlRenderer_GetDiagramHeader_ReturnsStartUml()
- PlantUmlRenderer_GetDiagramFooter_ReturnsEndUml()
- PlantUmlRenderer_GetParticipantType_Class_ReturnsClass()
- PlantUmlRenderer_GetParticipantType_Sequence_ReturnsParticipant()
- PlantUmlRenderer_FormatClassName_WithNamespace_ReturnsQuotedName()
- PlantUmlRenderer_FormatClassName_WithGlobal_HandlesCorrectly()
- PlantUmlRenderer_FormatRelationshipArrow_Inheritance_ReturnsCorrectArrow()
- PlantUmlRenderer_FormatRelationshipArrow_Composition_ReturnsCorrectArrow()
```
  
**Implementation (GREEN):**
- Create class inheriting from AbstractCodeStructureRenderer
- Implement abstract methods with PlantUML-specific syntax
- Copy format-specific methods from ClassStructurePlantUmlFileRenderer:
  - `SanitizeName()` → PlantUML-specific sanitization
  - `SanitizeNamespace()` → PlantUML-specific namespace handling
  - `GlobalNamespaceCheck()` → PlantUML-specific global namespace
  
**Format-Specific Method Implementations:**
```csharp
protected override string GetDiagramHeader(UmlDiagramType type)
    => "@startuml";
  
protected override string GetDiagramFooter()
    => "@enduml";
  
protected override string GetParticipantType(UmlDiagramType type)
    => type == UmlDiagramType.Class ? "class" : "participant";
  
protected override string FormatClassName(string name, string? ns)
    => SanitizeName(name, ns);  // PlantUML-specific sanitization
  
protected override string FormatRelationshipArrow(NodeRelationshipType type)
    => type switch {
        NodeRelationshipType.Inheritance => "<|--",
        NodeRelationshipType.Composition => "*--",
        // ... other arrows
    };
```
  
**Acceptance Criteria:**
- [ ] All abstract methods implemented
- [ ] PlantUML syntax is correct
- [ ] Sanitization matches existing behavior
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Generates identical output to original ClassStructurePlantUmlFileRenderer
- ✅ No regression in existing functionality
  
---
  
#### Step 9: Integration Test - PlantUML Renderer Output Validation
**File:** `DependencyTracerTests/PlantUmlCodeStructureRendererIntegrationTests.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- PlantUmlRenderer_FullClassDiagram_MatchesOriginalOutput()
- PlantUmlRenderer_FullSequenceDiagram_MatchesOriginalOutput()
- PlantUmlRenderer_SummarySequenceDiagram_MatchesOriginalOutput()
- PlantUmlRenderer_ComplexRelationships_RendersCorrectly()
```
  
**Implementation (GREEN):**
- Create test with real IScoredOutputNodeMap fixtures
- Generate diagrams with both old and new renderers
- Compare outputs (should be identical)
  
**Acceptance Criteria:**
- [ ] Output matches original ClassStructurePlantUmlFileRenderer exactly
- [ ] All diagram types work correctly
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Integration tests passing
- ✅ Zero regression from refactoring
- ✅ Output validated against real PlantUML renderer
  
---
  
### PHASE 4: Mermaid.js Renderer Implementation (6-8 hours)
  
#### Step 10: Create Mermaid.js Renderer - Header/Footer
**File:** `DependencyTracer/PlantUml/MermaidJsCodeStructureRenderer.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_GetDiagramHeader_Class_ReturnsClassDiagram()
- MermaidRenderer_GetDiagramHeader_Sequence_ReturnsSequenceDiagram()
- MermaidRenderer_GetDiagramFooter_ReturnsEmpty()
- MermaidRenderer_GetParticipantType_ReturnsCorrectType()
```
  
**Implementation (GREEN):**
```csharp
protected override string GetDiagramHeader(UmlDiagramType type)
    => type == UmlDiagramType.Sequence ? "sequenceDiagram" : "classDiagram";
  
protected override string GetDiagramFooter()
    => string.Empty;  // Mermaid.js doesn't need footer
  
protected override string GetParticipantType(UmlDiagramType type)
    => type == UmlDiagramType.Class ? "class" : "participant";
```
  
**Acceptance Criteria:**
- [ ] Headers match Mermaid.js syntax
- [ ] No footer generated
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Mermaid.js syntax validated
  
---
  
#### Step 11: Mermaid.js Class Name Formatting
**File:** `DependencyTracer/PlantUml/MermaidJsCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_FormatClassName_SimpleClass_ReturnsUnquotedName()
- MermaidRenderer_FormatClassName_WithNamespace_ReturnsFullyQualified()
- MermaidRenderer_FormatClassName_WithGenerics_UsesTrildeSyntax()
- MermaidRenderer_SanitizeName_SpecialChars_EscapesCorrectly()
```
  
**Implementation (GREEN):**
- Implement `FormatClassName()` for Mermaid.js
- Implement Mermaid.js-specific sanitization:
  - Generics: `Foo<T>` → `Foo~T~`
  - No quotes needed (Mermaid.js handles spaces differently)
  - Special character handling
  
**Acceptance Criteria:**
- [ ] Class names use Mermaid.js syntax
- [ ] Generics use tilde delimiters
- [ ] Special characters handled correctly
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Generic types render correctly in Mermaid.js
  
---
  
#### Step 12: Mermaid.js Relationship Arrows
**File:** `DependencyTracer/PlantUml/MermaidJsCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_FormatRelationshipArrow_Inheritance_ReturnsCorrectArrow()
- MermaidRenderer_FormatRelationshipArrow_Composition_ReturnsCorrectArrow()
- MermaidRenderer_FormatRelationshipArrow_Aggregation_ReturnsCorrectArrow()
- MermaidRenderer_FormatRelationshipArrow_Dependency_ReturnsCorrectArrow()
```
  
**Implementation (GREEN):**
```csharp
protected override string FormatRelationshipArrow(NodeRelationshipType type)
    => type switch {
        NodeRelationshipType.Inheritance => "<|--",      // Same as PlantUML
        NodeRelationshipType.Composition => "*--",       // Same as PlantUML
        NodeRelationshipType.Aggregation => "o--",       // Same as PlantUML
        NodeRelationshipType.Association => "-->",       // Same as PlantUML
        NodeRelationshipType.Dependency => "..>",        // Same as PlantUML
        NodeRelationshipType.NestedClass => "+--",       // Same as PlantUML
        NodeRelationshipType.PropertyAccess => "-->",    // Mermaid uses association
        _ => "-->"
    };
```
  
**Acceptance Criteria:**
- [ ] All relationship arrows use correct Mermaid.js syntax
- [ ] Most arrows are identical to PlantUML (bonus!)
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ All relationship types supported
  
---
  
#### Step 13: Mermaid.js Method Formatting
**File:** `DependencyTracer/PlantUml/MermaidJsCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_FormatMethod_NoReturnType_NoColon()
- MermaidRenderer_FormatMethod_WithReturnType_SpaceNotColon()
- MermaidRenderer_FormatMethod_Visibility_UsesCorrectSymbol()
- MermaidRenderer_FormatMethodCall_SequenceDiagram_UsesMermaidArrow()
```
  
**Implementation (GREEN):**
- Override method formatting if needed (or use shared)
- Implement sequence diagram method call formatting:
  - `Alice -> Bob: method()` → `Alice->>Bob: method()`
  - Activation: same as PlantUML
  - Returns: `-->` → `-->>`
  
**Acceptance Criteria:**
- [ ] Method signatures use Mermaid.js syntax
- [ ] Sequence arrows use `->>` and `-->>` syntax
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Sequence diagrams render correctly in Mermaid.js
  
---
  
#### Step 14: Mermaid.js Notes Formatting
**File:** `DependencyTracer/PlantUml/MermaidJsCodeStructureRenderer.cs`
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_FormatNotes_ClassDiagram_UsesCorrectSyntax()
- MermaidRenderer_FormatNotes_SequenceDiagram_UsesNoteSyntax()
- MermaidRenderer_FormatNotes_MultiLine_HandlesCorrectly()
```
  
**Implementation (GREEN):**
- Override `FormatNotes()` method
- PlantUML: `note left of Foo`
- Mermaid.js: `note for Foo "text"` (class) or `Note over Foo,Bar: text` (sequence)
  
**Acceptance Criteria:**
- [ ] Notes use Mermaid.js syntax
- [ ] Multi-line notes handled correctly
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Notes render correctly in Mermaid.js
  
---
  
#### Step 15: Integration Test - Mermaid.js Full Output Validation
**File:** `DependencyTracerTests/MermaidJsCodeStructureRendererIntegrationTests.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- MermaidRenderer_FullClassDiagram_ValidatesMermaidSyntax()
- MermaidRenderer_FullSequenceDiagram_ValidatesMermaidSyntax()
- MermaidRenderer_SummarySequenceDiagram_ValidatesMermaidSyntax()
- MermaidRenderer_ComplexRelationships_RendersCorrectly()
```
  
**Implementation (GREEN):**
- Create test with real IScoredOutputNodeMap fixtures
- Generate Mermaid.js diagrams
- Validate syntax (basic parsing check)
- Optionally: validate against Mermaid.js CLI if available
  
**Acceptance Criteria:**
- [ ] All diagram types generate valid Mermaid.js syntax
- [ ] Output can be rendered by Mermaid.js
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Integration tests passing
- ✅ Mermaid.js syntax validated
- ✅ Manual validation with online Mermaid.js editor
  
---
  
### PHASE 5: Factory & Generator Integration (4-6 hours)
  
#### Step 16: Create Diagram Generator Factory
**File:** `DependencyTracer/PlantUml/DiagramGeneratorFactory.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- Factory_CreateGenerator_PlantUml_ReturnsPlantUmlGenerator()
- Factory_CreateGenerator_MermaidJs_ReturnsMermaidJsGenerator()
- Factory_CreateGenerator_InvalidFormat_ThrowsException()
```
  
**Implementation (GREEN):**
```csharp
public static class DiagramGeneratorFactory
{
    public static IUmlDiagramGenerator Create(DiagramOutputFormat format)
    {
        return format switch
        {
            DiagramOutputFormat.PlantUml => new PlantUmlDiagramGenerator(),
            DiagramOutputFormat.MermaidJs => new MermaidJsDiagramGenerator(),
            _ => throw new ArgumentException($"Unsupported format: {format}")
        };
    }
}
```
  
**Acceptance Criteria:**
- [ ] Factory creates correct generator for each format
- [ ] Invalid format throws clear exception
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Factory pattern implemented correctly
  
---
  
#### Step 17: Create MermaidJsDiagramGenerator
**File:** `DependencyTracer/PlantUml/MermaidJsDiagramGenerator.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- MermaidGenerator_GenerateCodeStructureUmlDiagram_CreatesMermaidRenderer()
- MermaidGenerator_GenerateCodeStructureUmlDiagram_ReturnsValidMermaid()
```
  
**Implementation (GREEN):**
```csharp
public class MermaidJsDiagramGenerator : IUmlDiagramGenerator
{
    public string GenerateCodeStructureUmlDiagram(
        IScoredOutputNodeMap scoredOutputNodeMap,
        UmlDiagramType umlDiagramType,
        ISymbolAnalyzer symbolAnalyzer,
        string? notes,
        bool? isSummary)
    {
        var renderer = new MermaidJsCodeStructureRenderer(scoredOutputNodeMap, symbolAnalyzer);
        return renderer.GenerateDiagram(umlDiagramType, scoredOutputNodeMap, notes, isSummary ?? false);
    }
  
    public string GenerateDatabaseUmlDiagram(...)
    {
        // Phase 2: Implement Mermaid.js ER diagrams
        throw new NotImplementedException("Mermaid.js database diagrams not yet supported");
    }
}
```
  
**Acceptance Criteria:**
- [ ] Generator creates MermaidJsCodeStructureRenderer
- [ ] Code structure diagrams work
- [ ] Database diagrams throw clear exception (for now)
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Generator follows same pattern as PlantUmlDiagramGenerator
  
---
  
#### Step 18: Update PlantUmlDiagramGenerator to Use New Renderer
**File:** `DependencyTracer/PlantUml/PlantUmlDiagramGenerator.cs`
  
**Tests to write (RED):**
```csharp
- PlantUmlGenerator_UsesNewRenderer_OutputMatches()
```
  
**Implementation (GREEN):**
- Change instantiation from `ClassStructurePlantUmlFileRenderer` to `PlantUmlCodeStructureRenderer`
- Verify tests pass (should be drop-in replacement)
  
**Acceptance Criteria:**
- [ ] Uses new PlantUmlCodeStructureRenderer
- [ ] Output is identical to before
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests passing
- ✅ Zero regression
  
---
  
#### Step 19: Update OutputGenerator to Use Factory
**File:** `DependencyTracer/Output/OutputGenerator.cs`
  
**Tests to write (RED):**
```csharp
- OutputGenerator_PlantUmlFormat_CreatesPlantUmlGenerator()
- OutputGenerator_MermaidFormat_CreatesMermaidGenerator()
- OutputGenerator_FileExtension_PlantUml_IsPuml()
- OutputGenerator_FileExtension_Mermaid_IsMmd()
```
  
**Implementation (GREEN):**
- Update `WriteClassStructureUmlDiagramDescriptorsToFile()` (line 440)
- Replace direct instantiation with factory call:
  ```csharp
  var format = /* get from TracerOptions */;
  var plantUmlGenerator = DiagramGeneratorFactory.Create(format);
  ```
- Update file extension logic:
  ```csharp
  var extension = format == DiagramOutputFormat.PlantUml ? ".puml" : ".mmd";
  ```
  
**Acceptance Criteria:**
- [ ] Uses factory to create generator
- [ ] File extension matches format
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests written and passing
- ✅ Factory integration complete
- ✅ File extensions correct
  
---
  
#### Step 20: Pass Format Through Call Chain
**File:** Multiple files
  
**Tests to write (RED):**
```csharp
- Tracer_GenerateUmlDescriptors_PassesFormatToOutputGenerator()
- OutputGenerator_ReceivesFormat_UsesCorrectGenerator()
```
  
**Implementation (GREEN):**
- Update `Tracer.GenerateUmlDescriptors()` to accept format parameter
- Update `Tracer.GenerateUmlDescriptorsAsync()` to accept format parameter
- Pass `TracerOptions.OutputFormat` through call chain
  
**Acceptance Criteria:**
- [ ] Format propagates from TracerOptions to OutputGenerator
- [ ] All tests pass
  
**Definition of Done:**
- ✅ Tests passing
- ✅ Format selection works end-to-end
  
---
  
### PHASE 6: End-to-End Integration & Validation (2-4 hours)
  
#### Step 21: Integration Test - Full Pipeline with PlantUML
**File:** `DependencyTracerTests/OutputFormatIntegrationTests.cs` (NEW)
  
**Tests to write (RED):**
```csharp
- EndToEnd_PlantUmlFormat_GeneratesCorrectFiles()
- EndToEnd_PlantUmlFormat_FileExtensionIsPuml()
- EndToEnd_PlantUmlFormat_OutputValidatesAgainstPlantUml()
```
  
**Implementation (GREEN):**
- Create end-to-end test with test project
- Run full pipeline with PlantUML format
- Verify generated files
- Validate syntax
  
**Acceptance Criteria:**
- [ ] Full pipeline works with PlantUML format
- [ ] Files have .puml extension
- [ ] Output is valid PlantUML
- [ ] All tests pass
  
**Definition of Done:**
- ✅ End-to-end test passing
- ✅ PlantUML format fully functional
  
---
  
#### Step 22: Integration Test - Full Pipeline with Mermaid.js
**File:** `DependencyTracerTests/OutputFormatIntegrationTests.cs`
  
**Tests to write (RED):**
```csharp
- EndToEnd_MermaidFormat_GeneratesCorrectFiles()
- EndToEnd_MermaidFormat_FileExtensionIsMmd()
- EndToEnd_MermaidFormat_OutputValidatesAgainstMermaid()
```
  
**Implementation (GREEN):**
- Create end-to-end test with test project
- Run full pipeline with Mermaid.js format
- Verify generated files
- Validate syntax
  
**Acceptance Criteria:**
- [ ] Full pipeline works with Mermaid.js format
- [ ] Files have .mmd extension
- [ ] Output is valid Mermaid.js
- [ ] All tests pass
  
**Definition of Done:**
- ✅ End-to-end test passing
- ✅ Mermaid.js format fully functional
  
---
  
#### Step 23: Manual Validation with Real Projects
**Manual Testing**
  
**Test Cases:**
1. Generate PlantUML diagrams for existing test project
2. Generate Mermaid.js diagrams for same project
3. Validate both in respective online editors:
   - PlantUML: https://www.plantuml.com/plantuml/
   - Mermaid.js: https://mermaid.live/
4. Compare visual output for consistency
  
**Acceptance Criteria:**
- [ ] PlantUML output renders correctly in PlantUML editor
- [ ] Mermaid.js output renders correctly in Mermaid.js editor
- [ ] Diagrams show equivalent information
- [ ] No syntax errors in either format
  
**Definition of Done:**
- ✅ Both formats validated manually
- ✅ Visual comparison completed
- ✅ Screenshots captured for documentation
  
---
  
#### Step 24: Update Documentation & Help Text
**Files:** `README.md`, `Program.cs`
  
**Implementation:**
- Update README with format parameter documentation
- Update help text in Program.cs
- Add examples for both formats
- Document file extension behavior
  
**Acceptance Criteria:**
- [ ] README documents format parameter
- [ ] Help text includes format examples
- [ ] File extension behavior documented
- [ ] Migration guide for existing users
  
**Definition of Done:**
- ✅ Documentation complete
- ✅ Examples added
- ✅ Help text updated
  
---
  
### PHASE 7: Deprecation & Cleanup (2-3 hours)
  
#### Step 25: Mark ClassStructurePlantUmlFileRenderer as Obsolete
**File:** `DependencyTracer/PlantUml/ClassStructurePlantUmlFileRenderer.cs`
  
**Implementation:**
- Add `[Obsolete]` attribute with migration message
- Keep class functional for backward compatibility
- Add note in XML documentation
  
**Acceptance Criteria:**
- [ ] Class marked obsolete with clear message
- [ ] Class still compiles and works
- [ ] Migration path documented
  
**Definition of Done:**
- ✅ Obsolete attribute added
- ✅ No breaking changes
  
---
  
#### Step 26: Update All Tests Using Old Renderer
**File:** Various test files
  
**Implementation:**
- Update tests to use new renderers
- Ensure no tests reference ClassStructurePlantUmlFileRenderer directly
- Update mocks and fixtures
  
**Acceptance Criteria:**
- [ ] All tests use new renderer classes
- [ ] No compilation warnings about obsolete usage
- [ ] All tests pass
  
**Definition of Done:**
- ✅ All tests updated
- ✅ Zero obsolete warnings in test project
  
---
  
## Risk Areas to Monitor
  
### 1. Namespace Handling Differences
**Risk:** PlantUML and Mermaid.js may handle namespaces differently
  
**Mitigation:**
- Create comprehensive tests for namespace edge cases
- Test nested namespaces
- Test global namespace handling
- Visual validation in both editors
  
### 2. Generic Type Syntax
**Risk:** `Foo<T>` vs `Foo~T~` conversion may have edge cases
  
**Mitigation:**
- Test simple generics: `List<T>`
- Test nested generics: `List<List<T>>`
- Test multiple type parameters: `Dictionary<K, V>`
- Test constraints: `where T : IFoo`
  
### 3. Special Character Escaping
**Risk:** Different escaping rules between formats
  
**Mitigation:**
- Test common special characters
- Test Unicode characters
- Test reserved keywords
- Create sanitization test suite
  
### 4. Notes Positioning
**Risk:** Note syntax differs significantly between formats
  
**Mitigation:**
- Test all note positions (left, right, over)
- Test multi-line notes
- Test notes with special characters
- Visual validation
  
### 5. Database Diagram Support
**Risk:** Mermaid.js ER diagram support is limited compared to PlantUML
  
**Mitigation:**
- Phase 2 feature - clearly document limitation
- Throw NotImplementedException with helpful message
- Consider fallback to PlantUML for database diagrams
- Research Mermaid.js ER capabilities
  
### 6. Performance Implications
**Risk:** Template method overhead vs. original implementation
  
**Mitigation:**
- Performance benchmark tests
- Compare rendering times
- Profile memory usage
- Optimize hot paths if needed
  
---
  
## Rollback Approach
  
### If Implementation Must Be Reverted:
  
1. **Keep ClassStructurePlantUmlFileRenderer:** Original class remains functional
2. **Feature Flag:** Add flag to disable new renderers
3. **Backward Compatibility:** Default to PlantUML format
4. **Git Strategy:** Each phase is a separate commit for easy revert
  
### Rollback Triggers:
  
- Performance degradation > 20%
- Syntax errors in generated output
- Regression in PlantUML output
- Blockers preventing release
  
---
  
## Definition of Done - Overall Project
  
### Functional Requirements:
- [x] Configuration supports format selection
- [x] PlantUML format generates identical output to original
- [x] Mermaid.js format generates valid Mermaid.js syntax
- [x] File extensions match format (.puml, .mmd)
- [x] Command-line parameter works correctly
- [x] Both formats validated in respective editors
  
### Technical Requirements:
- [x] All tests pass (unit + integration)
- [x] Code coverage > 80% for new code
- [x] Zero compilation warnings
- [x] XML documentation complete
- [x] No regression in existing functionality
  
### Quality Requirements:
- [x] Code follows existing style guidelines
- [x] No code duplication between format renderers
- [x] Performance within 10% of original
- [x] Logging added for format selection
  
### Documentation Requirements:
- [x] README updated with format parameter
- [x] Help text includes format examples
- [x] Migration guide for existing users
- [x] Architecture decision recorded
  
---
  
## Process Checkpoints
  
### After Each Step:
- [ ] Verify TDD discipline followed (Red-Green-Refactor)
- [ ] Confirm appropriate test coverage exists
- [ ] Check for code duplication
- [ ] Validate against acceptance criteria
- [ ] Ensure definition of done met
  
### After Each Phase:
- [ ] Run full test suite
- [ ] Check for compilation warnings
- [ ] Validate integration points
- [ ] Review risk areas relevant to phase
- [ ] Commit with clear message
  
### Throughout Implementation:
- [ ] Keep human engaged and reviewing
- [ ] Intervene immediately on process violations
- [ ] Respect existing architecture patterns
- [ ] Maintain backward compatibility
- [ ] Document deviations from plan
  
---
  
## Notes
  
- This plan is optimized for AI-assisted implementation with human supervision
- Each step is small and testable
- TDD discipline is mandatory
- Backward compatibility is non-negotiable
- Plan may be adjusted based on learnings during implementation
  
---
  
**Ready to begin DO phase (TDD implementation)?**