# Elan8 Method SysML libraries

Canonical SysML v2 packages for the Elan8 Method.

| Package | File | Purpose |
| --- | --- | --- |
| `Elan8::Method::Requirements` | `Requirements.sysml` | Evidence, baselines, traceability concerns |
| `Elan8::Method::Metadata` | `Metadata.sysml` | Requirement role and identity annotations |
| `Elan8::Method` | `Method.sysml` | Concerns, abstraction levels, decisions, project info |
| `Elan8::Method::Viewpoints` | `Viewpoints.sysml` | Five standard viewpoints and view stubs |

These packages are the canonical systems-engineering / method libraries. Domain vocabulary lives in sibling `sysml-domain-libraries` only.

Import narrowly, for example:

```sysml
private import Elan8::Method::EngineeringConcern;
private import Elan8::Method::Metadata::*;
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

```powershell
spec42 --library-path ..\mbse-methodology\library `
       --library-path ..\sysml-domain-libraries\domain `
       --library-path ..\sysml-domain-libraries\technical `
       --library-path ..\sysml-domain-libraries\generic `
       check .
```

## Migration

SE packages formerly under `sysml-domain-libraries/generic/systems-engineering/` were moved here. That tree is removed (no re-exports). See [docs/library-migration.md](../docs/library-migration.md).
