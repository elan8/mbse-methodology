# Recursive modeling pattern

## One system, three roles

Import the shared definitions; do not copy them into each project.

`SystemSpecification`, `SystemArchitecture` and `SystemIntegration` are independent abstract role definitions. The concrete system types below establish the specification → architecture → integration specialization chain. See the [diagram](images/recursive-system-pattern.svg) and [tooling rules](tooling-rules.md).

```sysml
private import Elan8::SystemsEngineering::*;

part def DriveSpecification :> SystemSpecification;
part def DriveArchitecture :> DriveSpecification, SystemArchitecture;

part def MachineSpecification :> SystemSpecification;
part def MachineArchitecture :> MachineSpecification, SystemArchitecture {
    part drive : DriveSpecification;
}
part def MachineIntegration :> MachineArchitecture, SystemIntegration {
    part redefines drive : DriveArchitecture;
}
part selectedMachine : MachineIntegration;
```

An architecture specializes its **actual contract** as well as the method role. Integration specializes its selected architecture and redefines inherited child usages. A folder or similarly named part does not establish these relationships.

Definitions describe reusable types/designs; usages identify roles or configurations in context. Repeat the pattern at useful engineering boundaries. A leaf can select an architecture directly when it has no deeper selections. The [elevator example](../examples/elevator/model/60_systems/Elevator/system.sysml) shows a quantitative selection.

## Specification

Describe observable behavior, typed boundary interfaces, measurable properties, assumptions and constraints. Put system requirements alongside this contract, with clear subjects and assessable criteria. Stakeholder obligations remain in `20_requirements`.

Internal constituent systems belong in architecture. Structured items, ports and action parameters can still be part of a boundary contract. Reference external participants from context.

A BB has no structural `part` or `ref part` features. GB constituents must have the most specific role BB, not merely inherit the specification marker through an existing design. WB selects GB/WB definitions by redefining those inherited constituents. The tooling rules define these scopes precisely, including inherited features and partial selections.

## Binding requirements to the BB

A neighboring requirement is not automatically part of a system contract. Declare the authoritative requirement alongside the BB and explicitly assert it **inside** the BB:

```sysml
requirement def ResponseRequirement {
    subject system : MachineSpecification;
    require constraint { system.latency <= system.limit }
}
requirement <'SYS-001'> response : ResponseRequirement;
part def MachineSpecification :> Elan8::SystemsEngineering::SystemSpecification {
    attribute latency : ISQ::TimeValue;
    attribute limit : ISQ::TimeValue = 0.20 [SI::s];
    satisfy response;
}
```

Per SysML v2.0 Part 1 §7.21.4, omitting `by` inside a definition implicitly binds the satisfying subject to that containing definition's self feature. The inherited satisfy usage is an assertion for each system occurrence. Architecture and integration inherit it through the actual specification chain; merely sharing the method role does not suffice.

Keep the criterion in the requirement definition and configure its subject-dependent parameters as needed. The example's `AcknowledgementRequirement` and BB-local `satisfy acknowledgement;` implement this recipe. Direct `assert constraint` features remain useful for interface/budget invariants that do not need separate requirement identity.

A verification objective references the authoritative requirement, while the case subject identifies the assessed configuration. An inherited assertion is a design obligation, not measured evidence. Record a result separately before claiming verification.

## Architecture

Type constituent usages by child specifications. Describe their interactions, behavior and responsibilities as needed. Use connections for topology, flows for transfer, bindings for identity/equality and allocations for responsibility mapping.

Quantitative budgets need units, an aggregation rule and operating assumptions. Account for overhead and margin where relevant.

## Integration

Redefine inherited constituents with selected compatible child architectures or integrations. Selecting an architecture can leave deeper choices unresolved; make that visible. A child integration includes its deeper choices.

A parent-local refinement does not edit an independently defined child design. For example, a reusable panel permitting 80 ms may receive a 50 ms allocation in a parent. A 60 ms design meets the reusable contract but fails that installation. Check the selected design against both obligations.

Keep alternative designs distinct and identify the configuration being assessed. Type compatibility alone does not establish behavioral, interface or quantitative compatibility.

## Requirements and evidence

Keep each obligation authoritative in one place and reference it from designs, analyses and verification cases. Give requirements stable identities and retain useful source/derivation rationale. Native typing, specialization, redefinition, allocation, satisfaction and verification relationships express different claims.

Satisfaction is a claim. A verification case is a plan until execution supplies a result. Verification checks specified obligations; validation assesses fitness for stakeholder use. Neither the modeling sequence nor a rendered diagram establishes compliance.
