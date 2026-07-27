# Examples

## SE pattern fixtures

| Example | Path | Purpose |
| --- | --- | --- |
| Minimal traceability | [se-patterns/minimal-traceability](se-patterns/minimal-traceability/) | derive → satisfy → verify |
| Missing verification | [se-patterns/missing-verification](se-patterns/missing-verification/) | intentional verification gap |

These use `Elan8RequirementManagement` and `Elan8RequirementMetadata`.

## Compliant showcase: robot vacuum

The sibling repository [`sysml-robot-vacuum-cleaner`](../../sysml-robot-vacuum-cleaner) is the end-to-end Elan8 Method showcase:

- Folders `00_project` … `90_library`
- Imports `mbse-methodology/library` and `sysml-domain-libraries`
- Cliff-safe-stop vertical increment (`INC-CLIFF-001`)

Start with [`docs/ELAN8_METHOD_TOUR.md`](../../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md).
