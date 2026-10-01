# Examples

## Full-stage project example

[Two-elevator office service](elevator/README.md) populates all seven stages with customer and system requirements, typed scenarios and exchanges, logical-to-physical realization, analyses, and synthetic verification cases. Its walkthrough covers three increments, architecture alternatives, validation gaps, and change impact.

## Smaller tailored project example

[Guard-stop controller](guard-stop/README.md) connects a stakeholder concern, shared requirements, an actor-facing use case with nominal/degraded scenarios, allocated functions, a selected controller, analysis, and verdict-producing verification cases. It uses the current template structure and explicit stage tailoring. Measurements are synthetic; known tool limitations are documented.

## SE pattern fixtures

| Example | Path | Purpose |
| --- | --- | --- |
| Minimal traceability | [se-patterns/minimal-traceability](se-patterns/minimal-traceability/) | derive → satisfy → verify |
| Missing verification | [se-patterns/missing-verification](se-patterns/missing-verification/) | intentional verification gap |

These use native SysML requirements and `Elan8Method::Metadata`.
