# Elan8 Method SysML libraries

Canonical SysML v2 packages for the Elan8 Method.

| Package | File | Purpose |
| --- | --- | --- |
| `Elan8Method::Verification` | `Verification.sysml` | References to external verification evidence |
| `Elan8Method::Metadata` | `Metadata.sysml` | Requirement role annotations; identifiers use native short names |
| `Elan8Method::MethodCore` | `Core.sysml` | Concerns, stage disposition, decisions, project info |
| `Elan8Method::Viewpoints` | `Viewpoints.sysml` | Five standard viewpoints and view stubs |

These packages are the canonical systems-engineering / method libraries. Domain vocabulary belongs in project-local definitions or explicitly selected external domain libraries.

`Elan8Method.sysml` declares the single `Elan8Method` facade and publicly imports MethodCore and Viewpoints. Its Metadata namespace publicly imports the separately declared MethodMetadata package, avoiding the standard Metadata package name. Its Verification namespace publicly imports the contents of the separately declared MethodVerification package. No method file declares `Elan8`; that root belongs to the domain-library facade. Nested packages are valid, but repeating declarations does not reopen or merge a namespace.

This changes consumer imports from `Elan8::Method::…` to `Elan8Method::…`. Update existing models when adopting these sources; released archives retain their earlier namespaces until a new release is published.

Import narrowly, for example:

```sysml
private import Elan8Method::MethodCore::EngineeringConcern;
private import Elan8Method::Metadata::*;
```

Avoid `import Elan8::*`; the root namespace intentionally contains multiple library families.

## Loading the library

Load every `.sysml` file in this directory together with the standard SysML v2 libraries. Configure the library source path or archive through your modeling environment. The included examples and project template do not require any other repository.

Avoid loading both this source library and an older archive of the same library in one workspace. See [library migration](../docs/library-migration.md) for the current namespace and import changes.

## Native requirements and scalar types

The former Requirements package is removed: native SysML supplies requirements and their relationships. Metadata retains role annotations; identifiers use native short names. Text attributes such as project names, decision identifiers, and evidence URIs use `ScalarValues::String`; the former unconstrained Identifier, Name, and EvidenceUri attribute definitions are not needed. Move evidence imports to `Elan8Method::Verification` and associate evidence with its verification case.
