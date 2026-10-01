# Stage readiness for increment review

Readiness means the material is sufficient to review the increment's question and claims. It does not mean the entire stage is finished or authorize a product release. Apply these manual criteria to the increment's scope, record gaps and residual risks in the PR, and revisit relevant stages as evidence changes.

| Stage | Review criteria |
| --- | --- |
| Context | Problem and intended stakeholder outcomes are clear; boundary, external systems, relevant lifecycle stakeholders, assumptions, and exclusions are identified; needs, supplied stakeholder obligations, derived system obligations, and solution choices are distinguished. |
| Use Cases | Actor goals, triggers, conditions, and observable outcomes are clear; significant nominal and degraded paths are selected; their needs, requirements, and validation questions are traceable. |
| Capabilities | Required outcomes and applicable measures are clear; realizing use cases and obligations are identified; coverage gaps and conflicting outcomes are visible. |
| Functions | Required responsibilities, inputs, outputs, and conditions are explicit; significant scenario paths are coherent; relevant requirements and unresolved allocations are visible. |
| Logical Architecture | When used, responsibility boundaries and collaboration contracts are justified; functions and exchanges map coherently to logical elements; open choices are explicit. |
| Physical Architecture | Selected implementation and allocations are identified; critical scenario paths and interface contracts are reviewed; consequential alternatives, assumptions, constraints, and decision rationale are recorded. |
| Verification | Critical obligations have methods, conditions, and acceptance criteria; stakeholder validation outcomes are planned; planned coverage, evaluated results, evidence provenance, and residual gaps are distinguished. |

For a merged stage, apply its relevant criteria to the target content and review the `StageDisposition` rationale. For a non-applicable stage, review the reason it adds no value to this scope. Tailoring does not remove the need to account for critical responsibilities or evidence.

Across stages, review canonical requirements in `05_requirements`, analysis assumptions and uncertainty, evidence applicability to the baseline, and views needed by reviewers. Check model syntax and semantics separately: a successful parse does not establish engineering readiness. These criteria are manual review guidance, not implemented automated diagnostics.

See [tailoring](tailoring.md), [roles and reviews](roles-and-reviews.md), and the [workflow](workflow.md).
