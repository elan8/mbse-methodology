# Method mapping (orientation)

Elan8 model areas and engineering practices compared to familiar MBSE
approaches. This is **orientation**, not a claim of one-to-one equivalence.

## Model areas vs familiar perspectives

Every project has the same six model-area packages (`10_context` …
`80_verification`, see [engineering-increments.md](engineering-increments.md)
and the [project template](../templates/project-template/README.md)). This
table is the closer, structural comparison for teams coming from a
phase-based methodology:

| Elan8 area | Typical activities | SYSMOD (approx.) | OOSEM (approx.) | Arcadia (approx.) | INCOSE process flavor |
| --- | --- | --- | --- | --- | --- |
| Context | Problem, boundary, stakeholders, concerns | System idea, stakeholder needs | Stakeholder needs, context | Operational Analysis (need) | Stakeholder needs definition |
| Use Cases | Actor goals, nominal/degraded scenarios | Use cases / processes | Scenario analysis | Operational Analysis (scenarios) | Use case / scenario definition |
| Functions | Requirement derivation and functional analysis | Logical behavior | Functional analysis | System Functional Analysis | Functional analysis & allocation |
| Logical Architecture | Responsibilities and interface contracts | System architecture | Logical architecture | Logical Architecture (LA) | Architecture definition |
| Physical Architecture | Implementation selection and allocation | System architecture | Physical architecture | Physical Architecture (PA) | Architecture definition |
| Verification | Verification definition and evidence | Requirements & test | Verification planning | Integration & IVV hooks | Verification & validation |

Elan8 does not have a dedicated Arcadia-style "System Analysis" (SA) area;
its scope spans Context, Use Cases, and Functions. Arcadia models operational capabilities and system capabilities across its perspectives; Elan8 captures useful capability reasoning within Context rather than a separate area. The mapping is approximate, not a claim that Arcadia lacks capabilities.

## Applying established practices

Elan8 uses engineering questions and reviewable increments as its working method. The six model areas organize content; they are not equivalent to another method's process phases. Adapt familiar activities to the question and retain useful logical structure only when it clarifies responsibility or a choice. Native SysML constructs, canonical requirements, evidence provenance and reviewable changes support the reasoning.

## Practices adopted and sources

Elan8 strengthens problem/solution separation, lifecycle stakeholder analysis, scenario continuity, architecture justification, and stakeholder validation within its existing model areas. See [increment review](increment-review.md). These practices do not imply conformance to another methodology or require its library.

- [SYSMOD overview](https://mbse4u.com/wp-content/sysmod/sysmodv5-reveal.html): problem, needs, solution, verification and validation as tailorable artifacts.
- [Arcadia guidance](https://mbse-capella.org/arcadia-qna.html): scenario/function/exchange continuity, capability perspectives, and architecture justification.
- [OOSEM evolution presented through INCOSE](https://www.incose.org/docs/default-source/working-groups/requirements-wg/rwg_meetings_2025/2025.04.22_ison_oosem_final-incoserwg.pdf?sfvrsn=fb7051c7_4): lifecycle needs and distinction between stakeholder validation and requirement verification. This is an evolution proposal and implementation discussion, not a universal OOSEM mandate.
