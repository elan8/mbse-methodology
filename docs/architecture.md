# Responsibilities, interfaces, and decisions

Architecture connects required behavior to the elements responsible for realizing it. Begin with the responsibilities implied by requirements and scenarios. Represent them as actions; group collaborating responsibilities into logical parts only when that clarifies ownership, stable boundaries, or a design choice.

A parallel logical part tree is optional. Allocate behavior directly to physical parts when that answers the engineering question; explain in package documentation where the logical content lives and why a separate structure is unnecessary. Keep unresolved allocations explicit rather than implying a complete realization. See [abstraction levels](abstraction-levels.md), [tailoring](tailoring.md), and the [elevator physical baseline](../examples/elevator/model/60_physical/Physical.sysml).

## Interface contracts

Identify the boundary, participating elements, and transferred information, material, or energy. Use reusable item/quantity definitions for public exchanges, directed port definitions, and interface definitions where a reusable contract is useful. Conjugate a port when its directed features must reverse.

Use connections for topology, flows for transfer, and bindings for identity or equality. These relationships make different claims. An empty port is not a complete interface specification, and a descriptive string is not a substitute for a typed public payload. Capture interaction conditions and performance obligations as canonical interface requirements when needed.

Project-local types belong in `99_library` unless an explicitly selected library already provides them. The [elevator types](../examples/elevator/model/99_library/Types.sysml) define assignment/status and actuator interfaces; brake and sensor wiring remain explicit detailed-design gaps.

## Alternatives and decisions

State the decision objective and comparison criteria before choosing an architecture. Compare candidate approaches only to the depth needed to assess performance, risk, cost, and feasibility. Record assumptions with `Assumption`, risks with `Risk`, and quantitative evaluation in analysis cases or referenced evidence. Avoid fully developing rejected architectures when a short comparison answers the question.

Record consequential choices with `DecisionRecord` on the element embodying the choice: stable decision identifier, title, and rationale. Link supporting analysis and assumptions; update satisfaction and allocation relationships to the selected baseline. Keep specialization (what kind of element it is) distinct from implementation selection (what realizes it). Use native variation/variant constructs when a real product-configuration question requires them, rather than introducing variants speculatively.

Git review and merge record acceptance of the increment. A decision should remain understandable without meeting notes; do not annotate trivial naming choices merely to fill a checklist.

## Review and views

Review explicit responsibility, stable interface contracts, unresolved choices, and rationale for omitted layers. Use `ArchitectureViewpoint` and `ArchitectureView` to expose the decomposition without duplicating model content. Add stakeholder views only when they support a concrete review question.

## Comparing candidates proportionally

For a consequential decision, record the alternatives considered, non-negotiable obligations, comparison criteria, supporting analysis, uncertainty, and why the selected candidate is preferred. Distinguish measured results, predictions, and engineering judgment. Do not assign numerical scores without a defensible basis.

Reject candidates that violate mandatory constraints before comparing preferences. Where evidence is incomplete, record a provisional choice and the evidence that could change it. Revisit the decision when its assumptions, requirements, or operating context change. The [elevator comparison](../examples/elevator/README.md#architecture-decision-and-alternatives) illustrates a scoped teaching decision.
