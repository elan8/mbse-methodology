# Examples

## SE pattern fixtures

| Example | Path | Purpose |
| --- | --- | --- |
| Minimal traceability | [se-patterns/minimal-traceability](se-patterns/minimal-traceability/) | derive → satisfy → verify |
| Missing verification | [se-patterns/missing-verification](se-patterns/missing-verification/) | intentional verification gap |

These use `Elan8::Method::Requirements` and `Elan8::Method::Metadata`.

## Compliant showcase: robot vacuum

The sibling repository [`sysml-robot-vacuum-cleaner`](../../sysml-robot-vacuum-cleaner) is the end-to-end Elan8 Method showcase for **one engineering increment** (cliff safe-stop):

- Folders `00_project` … `90_library`
- Imports `mbse-methodology/library` and `sysml-domain-libraries`
- Increment spine: need → scenario `CliffSafeStopGoldenThread` → architecture links → analysis → verification

Start with [`docs/ELAN8_METHOD_TOUR.md`](../../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md) and the method page [engineering-increments.md](../docs/engineering-increments.md).
