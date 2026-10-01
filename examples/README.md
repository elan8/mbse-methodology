# Examples

## SE pattern fixtures

| Example | Path | Purpose |
| --- | --- | --- |
| Minimal traceability | [se-patterns/minimal-traceability](se-patterns/minimal-traceability/) | derive → satisfy → verify |
| Missing verification | [se-patterns/missing-verification](se-patterns/missing-verification/) | intentional verification gap |

These use native SysML requirements and `Elan8Method::Metadata`.

## Traceability showcase: robot vacuum

The sibling repository [`sysml-robot-vacuum-cleaner`](../../sysml-robot-vacuum-cleaner) is the end-to-end Elan8 Method showcase for **one engineering increment** (cliff safe-stop):

- Earlier concern-based folders (`10_purpose`, `20_behavior`, `30_architecture`, etc.); not yet migrated to the seven-stage template
- Imports `mbse-methodology/library` and `sysml-domain-libraries`
- Increment spine: need → scenario `CliffSafeStopScenario` → architecture links → analysis → verification

The showcase demonstrates the engineering traceability chain, but does not yet demonstrate current folder or `StageDisposition` compliance. Its earlier layout maps to the current template as follows:

| Showcase folder | Current template placement |
| --- | --- |
| `10_purpose` | `10_context` (context) and `05_requirements` (needs and requirements) |
| `20_behavior` | `20_usecases` and `40_functions`; assess `30_capabilities` explicitly |
| `30_architecture` | `50_logical` and `60_physical`, with explicit tailoring |
| `40_analysis` | `70_analysis` |
| `50_verification` | `80_verification` |
| `60_views` | `90_views` |
| `90_library` | `99_library` |

A migration must preserve the existing derivation, satisfaction, allocation, and verification relationships, and add a disposition to each of the seven stage packages. Renaming folders alone does not establish compliance.

Start with [`docs/ELAN8_METHOD_TOUR.md`](../../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md) and the method page [engineering-increments.md](../docs/engineering-increments.md).
