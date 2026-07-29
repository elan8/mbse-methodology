# Library migration: systems-engineering → Elan8 Method

**Status: complete.** There are no re-exports in `sysml-domain-libraries`.

## What moved

| Former location (sysml-domain-libraries)                               | Canonical location (mbse-methodology)      | Package rename                                         |
| ---------------------------------------------------------------------- | ------------------------------------------ | ------------------------------------------------------ |
| `generic/systems-engineering/requirements/RequirementManagement.sysml` | `library/Requirements.sysml` | `RequirementManagement` → `Elan8::Method::Requirements` |
| `generic/systems-engineering/requirements/RequirementMetadata.sysml`   | `library/Metadata.sysml`   | `RequirementMetadata` → `Elan8::Method::Metadata`     |
| `generic/systems-engineering/examples/…`                               | `examples/se-patterns/…`                   | same example package names                             |

The `generic/systems-engineering/` tree has been **deleted**.

## What stays in domain libraries

- `technical/**` (electronics, communication, software)
- `generic/units/MonetaryUnits.sysml`

## Import rule

```sysml
import Elan8::Method::Requirements::*;
import Elan8::Method::Metadata::*;
import Elan8::Method::Core::*;
```

Do not import `RequirementManagement` or `RequirementMetadata` — those package names no longer exist.

## Sibling checkout

```text
elan8/
  mbse-methodology/
  sysml-domain-libraries/
  sysml-robot-vacuum-cleaner/
```

Spec42 must include `--library-path ../mbse-methodology/library` whenever models use Elan8 Method packages.

## Split rule

| Belongs in                 | Content                                                                  |
| -------------------------- | ------------------------------------------------------------------------ |
| **mbse-methodology**       | How Elan8 expects models to be authored, traced, reviewed, and assured   |
| **sysml-domain-libraries** | Vocabulary for things in the system (domains and technical capabilities) |
