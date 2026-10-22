# BB / GB / WB tooling rules

These are model diagnostics, not a development process. Use the resolved SysML semantic model, not file paths, suffixes or text searches. The [rule catalog](../tooling/bb-gb-wb-rules.json) provides stable IDs; [fixtures and expected findings](../examples/tooling-rules/README.md) provide implementation examples. The reference checker implements the structural subset described below; Spec42 itself does not enforce these method rules.

## Foundation

The INCOSE [recursive decomposition presentation](https://www.incose.org/wp-content/uploads/2026/10/A_SysML_V2_Modeling_Pattern_for_Recursive_System_Decompostion_Presentation.pdf), slides 7–12, motivates boundary contracts, contract-typed constituents and selection by refinement. It also warns that local refinements need reconciliation. The definitions, diagnostic scope, completeness option and algorithms below are Elan8 implementation decisions.

The three library markers are independent:

```sysml
abstract part def SystemSpecification;
abstract part def SystemArchitecture;
abstract part def SystemIntegration;
```

Project definitions establish the actual chain:

```sysml
part def MachineSpecification :> SystemSpecification;
part def MachineArchitecture :> MachineSpecification, SystemArchitecture;
part def MachineIntegration :> MachineArchitecture, SystemIntegration;
```

BB permits observable properties, assumptions, requirements and constraints as well as interfaces and behavior. “Only behavior and interfaces” would exclude useful contract content. It has no structural part usages, including `ref part`; external participants belong in context.

## Shared queries

Resolve the marker identities through `Elan8::SystemsEngineering`. Imported aliases denote the same objects. Exclude only those three framework definitions from rule targets; abstract project definitions are still checked.

Definition ownership is independent of these rules. Directly system-owned definitions are the default; optional nested packages, arbitrary grouping names and definition names without role suffixes must produce the same role/selection checks. Do not require `Specification`, `Architecture` or `Integration` package paths.

```text
role(T):
  if T conforms to SystemIntegration: return WB
  if T conforms to SystemArchitecture: return GB
  if T conforms to SystemSpecification: return BB
  return NONE

principalBases(T, R):
  candidates = proper ancestors of T whose role is R, excluding framework markers
  remove any candidate that is a supertype of another candidate
  return remaining candidates
```

Although the markers are independent, project GB/WB definitions inherit earlier markers through their actual contract/design chain. Precedence WB > GB > BB prevents a GB being mistaken for a BB. An ordinary type has role NONE. Cyclic or unresolved ancestry produces an unknown result; do not guess.

`parts(T)` means effective direct structural features classified by `SysML::PartUsage`, including inherited/redefined and referential features, **excluding `ConnectionUsage` and `ViewUsage` and their subtypes**. Connections are also PartUsages in the SysML metamodel, but are topology, not constituent systems; this exclusion also covers interfaces/allocations classified as connections. Do not recursively collect requirement subjects, action/case parameters, port payloads or parts owned by another nested definition. They are not constituent features of T. Owning a helper definition alone is not composition. Use native feature membership/ownership, not raw lexical nesting.

For role-bearing usages, include their usage-local refinements. Check definitions once, then report only additional contextual violations on usages. Suppress duplicate findings by rule, offending semantic feature and configuration context.

## Rules

| ID | Scope | Violation / diagnostic | Suggested assistance |
|---|---|---|---|
| E8-BB-001 | BB | `parts(T)` is nonempty. **Error.** | Move implementation constituents to architecture, or external participants to context. Preserve boundary behavior/interfaces. |
| E8-GB-001 | GB definition | `principalBases(T, BB)` contains no actual contract. **Error.** | Add the intended specification specialization. A marker alone is insufficient. |
| E8-GB-002 | GB child | A constituent is untyped, typed only by a bare method marker, or has resolved most specific role GB/WB/NONE. **Error.** Unresolved type references defer this check to language diagnostics. | Type the architecture constituent by a child specification. Select the child design in integration. Use an adapter contract for an opaque supplied component. |
| E8-WB-001 | WB definition | `principalBases(T, GB)` contains no actual architecture. **Error.** | Specialize the intended architecture. Neither a marker nor a BB alone identifies it. |
| E8-WB-002 | WB child | A new constituent has no redefinition chain to a child of the selected GB base set, or several effective replacements compete for that child. **Error.** | Redefine the inherited child identity; put new composition in a revised architecture. Name similarity and subsetting are insufficient. |
| E8-WB-003 | Explicit WB selection | The selected child type is not a project GB or WB. **Error.** | Select a child architecture/integration, not a BB or bare method marker. |
| E8-WB-004 | WB configuration | A possible constituent remains an inherited BB with no design selection. **Warning** normally; **error** with `completeSelection=true`. | Mark the configuration partial or select a design. A child whose resolved upper multiplicity is zero is excluded. Unknown multiplicity is not assumed absent. |
| E8-WB-005 | WB selection | The selected design definition does not conform to every contract type required by the inherited GB child. **Error.** | Choose a compatible design or deliberately revise the contract/architecture. Reuse native type/multiplicity/feature compatibility diagnostics. |
| E8-CTX-001 | WB contextual constraints | A constraint on the effective selected child is demonstrably false. **Error.** If undecidable/unavailable, report **info: not assessed**. | Show the parent-local condition and selected value/assumption. Do not mark an unresolved check passed. |

Multiple actual contracts or architectures are allowed by default: their obligations are conjunctive, and native language validation must resolve any conflicting feature refinements. A named combined specification can improve readability but is not required. Optional `singlePrincipalBase=true` emits **E8-STYLE-001 / warning** when more than one most specific actual base exists. This is a style convention, not a BB/GB/WB semantic error. Additional unrelated domain classifiers are allowed.

Leaf architectures may contain no child parts. A WB need not have parts if its selected architecture is a leaf. Optional multiplicity alone does not waive selection: `[0..1]` still permits an occurrence. `completeSelection` checks selection completeness, not verification status or readiness for release.

## Selection algorithm

1. Validate language/imports first. Block only dependent method checks when types or redefinitions are unresolved; continue independent checks.
2. Classify roles and resolve the actual GB base set of each WB. Enumerate their combined effective child identities.
3. Map each WB child to an inherited GB child through **redefinition**, retaining transitive redefinition identity across configuration variants. Report additions/competing replacements before checking their types.
4. If there is no selection, emit WB-004. If there is an explicit BB/non-design selection, emit WB-003 instead; avoid both findings for the same cause.
5. For a real selection, check the selected definition's own type ancestry against the inherited required contract types. Do not use the merged usage's inherited type list as proof: that would make the check circular. Evaluate multiple declared types as a conjunction using native type-conformance semantics.
6. Evaluate selected values and constraints **in the parent context**, preserving local refinements, inherited assumptions, units and multiplicity. Native equality/redefinition constraints still apply. A default value is not itself a maximum/minimum requirement. Where analysis or evidence is needed, return not-assessed instead of synthesizing a pass.
7. Recurse through selected child integrations to check deeper selections. A selected child architecture with unresolved constituent contracts makes the overall configuration partial. Track active selected definition identities on each traversal branch; report recursive expansion as unresolved completeness rather than unrolling forever. Memoization may also cache finite contexts; a leaf architecture is resolved without an extra WB wrapper.

For example, a 60 ms panel may meet its independent 80 ms contract and a 200 ms system total, yet violate a parent-local 50 ms allocation. E8-CTX-001 must assess the 50 ms context; type conformance and the system total do not discharge that obligation.

## Diagnostic output

Return the stable rule ID, severity, status (`violation`, `unresolved`, `not-assessed`), offending element identity/source range, configuration identity where relevant, concise message and related contract/architecture/feature identities. Suggest a fix; never silently change a contract, convert `ref part` ownership or replace a design.

## Reference implementation and coverage

[check_structure.py](../scripts/check_structure.py) consumes complete, error-free Spec42 schema-1 semantic exports and implements E8-BB-001, E8-GB-001/002 and E8-WB-001–005 for workspace **definitions**, plus the optional style warning. It merges inherited/redefined constituents, checks selections transitively, and handles absent, optional and recursively typed children. Use `--dependency-export` for externally defined project types; missing ancestry produces E8-EXPORT-001/info and defers dependent checks.

The adapter recognizes the exact canonical semantic marker identities `SystemsEngineering::SystemSpecification`, `SystemArchitecture`, `SystemIntegration` from the pinned library, resolving referenced token identities rather than suffixes. The export's concrete native metaclass distinguishes constituent PartUsage records from ConnectionUsage/ViewUsage records.

Current limits: root usage-local overrides, constraint evaluation (E8-CTX-001), behavior/port compatibility and verification evidence are **not assessed** by this reference implementation. The report exposes those coverage limits. It must not be presented as full method conformance or a release/verification verdict. Native language diagnostics remain separate.

[test_structure.py](../scripts/test_structure.py) runs the case expectations against a live export in default, complete-selection and optional-style modes. It also checks rejection of truncated/error exports and the parts-only view regression. See [tooling commands](library-and-tooling.md).
