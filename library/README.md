# Elan8 Method SysML libraries

Canonical SysML v2 packages for the Elan8 Method.

| Package | File | Purpose |
| --- | --- | --- |
| `Elan8RequirementManagement` | `Elan8RequirementManagement.sysml` | Evidence, baselines, traceability concerns |
| `Elan8RequirementMetadata` | `Elan8RequirementMetadata.sysml` | Requirement role and identity annotations |
| `Elan8Method` | `Elan8Method.sysml` | Concerns, abstraction levels, decisions, increments |
| `Elan8Viewpoints` | `Elan8Viewpoints.sysml` | Five standard viewpoints and view stubs |

These packages are the canonical systems-engineering / method libraries. Domain vocabulary lives in sibling `sysml-domain-libraries` only.

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
