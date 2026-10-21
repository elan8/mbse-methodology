# Recursive modeling pattern

## One system, three roles

Import the shared definitions; do not copy them into each project.

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
