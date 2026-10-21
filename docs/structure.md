# Folder and package structure

The standard adopts the [agreed proposal](../folder-structure.md): numbered model areas, a flat systems directory and one `system.sysml` per system by default. Semantic part usages define recursive composition; folder nesting does not.

## Standard layout

```text
project/
  README.md
  project.md                       # optional setup/dependency note
  model/
    Root.sysml                     # navigation; workspace loads all model sources
    00_context/
      Context.sysml                # system boundary, environment, external participants
    10_usecases/                    # optional
      UseCases.sysml
    20_requirements/
      StakeholderRequirements.sysml
    50_library/
      Library.sysml                # project-owned shared types, frames, interfaces, parts
    60_systems/
      MainSystem/
        system.sysml
      SubsystemA/
        system.sysml
      SubsystemB/
        system.sysml
    80_documents/
      Documents.sysml              # document definitions and content selections
      README.md                    # document adapter/binding and generation instructions
  records/                         # optional project notes
  evidence/                        # controlled artifacts or immutable references
  generated/                       # disposable documents, views and reports
```

The [starter](../templates/project-template/README.md) contains the model folders/files. Records and evidence folders are optional supporting areas. Remove `10_usecases` when explicit use cases add no value, recording the operational understanding elsewhere. Number gaps allow future model areas without renaming existing ones.

## System-owned content

Each uniquely named system package contains `Specification`, `Architecture`, `Integration`, `Analysis`, `Verification` and `Views` as applicable. Keep these in one file until size or team ownership warrants splitting. Ports, items, behavior and constraints live with the contract/design they describe. The specification owns system requirements; `20_requirements` owns stakeholder/customer obligations.

Systems are flat by default even when recursively composed. A parent architecture refers to a child's specification; its integration selects a child design through redefinition. Several parent usages may reference the same independently owned child. Optional domain grouping folders are organizational only.

Local context, scenarios or stakeholder obligations can be added inside a system package when they provide information beyond the project-level context or parent handoff.

## Splitting a system across files

A directory does not create a SysML namespace and repeated package declarations do not merge automatically. Declare distinct supporting packages, then make their contents available from the system package through explicit public imports when they form part of that system's public surface. Use private imports for implementation-only dependencies.

For example, `Behavior.sysml` declares `ProductBehavior`; the existing `Product` package in `system.sysml` contains:

```sysml
package Behavior {
    public import ProductBehavior::*;
}
```

This provides a `Product::Behavior` access path without duplicating authoritative elements. Their owning package remains `ProductBehavior`; the import does not move ownership. The surrounding `Product` package must be declared only once. Keep imports intentional to avoid ambiguous names and dependencies.

## Shared elements and dependencies

`50_library` owns project-specific reusable definitions such as coordinate frames, common interface/item types and components shared by systems. A developed subsystem remains in `60_systems` even when several parents use it. Reuse does not require moving it into a generic library.

Domain libraries are pinned dependencies, not editable copies in `50_library`. Method roles come from `Elan8::SystemsEngineering`; the frozen 0.5.0 candidate and hashes are provided in `libraries/` and `dependencies.lock.json`. Default validation consumes that snapshot. An explicit source override is available for development. See [tooling](library-and-tooling.md).

Reusable supplier/product libraries may remain separate projects. Use controlled references/adapters instead of copying editable definitions into several consumers.

## Documents and views

System-specific views live with each system. Project-level context and requirement views can live with those areas. Add a cross-system view package only when a concrete review question needs it.

`80_documents` owns CRS/SRS/SDS document definitions, ordering, prose and content selections. It references authoritative requirements, systems and views; it does not redefine them. Actual document generation requires a pinned document library and generator (for example Doc42), distinct from the method-role library. The starter supplies native content-selection seeds and an explicit binding TODO, not a fabricated document-generation type. Generated outputs go in `generated/`.

## Names, ownership and loading

| Item | Convention |
|---|---|
| System source | `60_systems/<SystemName>/system.sysml` |
| Definitions | `LiftSpecification`, `LiftDistributedArchitecture`, `LiftReleaseAIntegration` |
| Usage | Lower camel case role in context: `callPanel` |
| Requirement ID | Stable prefix/sequence such as `LIFT-SYS-001`; never reuse retired IDs |
| View | Catalog ID plus subject/configuration |
| External artifact | Stable URI/path plus immutable revision/hash |

Engineering IDs survive file moves. Keep them distinct from generated tool IDs and record identity mappings if necessary.

| Content | Authoritative owner |
|---|---|
| Stakeholder obligation | Project/customer requirement owner and accepting system |
| System/child requirement | Owner of the constrained system specification |
| Parent-local child obligation | Parent architecture and its named child usage |
| Shared interface | One named owner; participants reference it |
| Design decision | System making the choice |
| Verification case | Owner of the assessed obligation |
| Execution evidence | Executing team, linked to assessed configuration |
| View/document | Owner of the review/publication question, selecting authoritative content |

Load the complete active `model/` tree and explicit pinned dependencies. `Root.sysml` is navigation, not file discovery or a second system instance. Keep archives, templates and independent examples outside the active load boundary.

## Keep it small

Create only the packages and supporting records that help the project. Folder numbers are navigation, not a modeling sequence. No increment approach, process profile, gates or approval forms are required. Context, specification, architecture and integration views are provided as reusable recipes; use them where useful.
