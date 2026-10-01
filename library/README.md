# Elan8 Method SysML libraries

Canonical SysML v2 packages for the Elan8 Method.

| Package | File | Purpose |
| --- | --- | --- |
| `Elan8Method::Verification` | `Verification.sysml` | References to external verification evidence |
| `Elan8Method::Metadata` | `Metadata.sysml` | Requirement role and identity annotations |
| `Elan8Method::MethodCore` | `Core.sysml` | Concerns, stage disposition, decisions, project info |
| `Elan8Method::Viewpoints` | `Viewpoints.sysml` | Five standard viewpoints and view stubs |

These packages are the canonical systems-engineering / method libraries. Domain vocabulary lives in sibling `sysml-domain-libraries` only.

`Elan8Method.sysml` declares the single `Elan8Method` facade and publicly imports MethodCore and Viewpoints. Its Metadata namespace publicly imports the separately declared MethodMetadata package, avoiding the standard Metadata package name. Its Verification namespace publicly imports the contents of the separately declared MethodVerification package. No method file declares `Elan8`; that root belongs to the domain-library facade. Nested packages are valid, but repeating declarations does not reopen or merge a namespace.

This changes consumer imports from `Elan8::Method::…` to `Elan8Method::…`. Update existing models when adopting these sources; released archives retain their earlier namespaces until a new release is published.

Import narrowly, for example:

```sysml
private import Elan8Method::MethodCore::EngineeringConcern;
private import Elan8Method::Metadata::*;
```

Avoid `import Elan8::*`; the root namespace intentionally contains multiple library families.

## Sibling checkout

Spec42 discovers libraries by path. Typical layout:

```text
elan8/
  mbse-methodology/library/     # this folder
  sysml-domain-libraries/       # domain + technical vocabulary
  sysml-robot-vacuum-cleaner/   # method-compliant showcase
```

Pass both roots to Spec42, for example:

```sh
spec42 --library-path ../mbse-methodology/library \
       --library-path ../sysml-domain-libraries/domain \
       --library-path ../sysml-domain-libraries/technical \
       --library-path ../sysml-domain-libraries/generic \
       check .
```

## Migration

SE packages formerly under `sysml-domain-libraries/generic/systems-engineering/` were moved here. That tree is removed (no re-exports). See [docs/library-migration.md](../docs/library-migration.md).

## Native requirements and scalar types

The former Requirements package is removed: native SysML supplies requirements and their relationships. Metadata retains role and identity annotations. Names, identifiers, and evidence URIs use `ScalarValues::String`; the former unconstrained Identifier, Name, and EvidenceUri attribute definitions are not needed. Move evidence imports to `Elan8Method::Verification` and associate evidence with its verification case.
