# Use cases and scenarios

A use case describes an actor-facing goal. A scenario describes one path through an interaction that realizes that goal. Internal functions express responsibilities; not every function needs its own use case.

Identify the system subject and actor from the context. State the motivation, initiating trigger, relevant preconditions, and successful outcome. Model the nominal path, then select alternate or degraded paths that affect architecture, requirements, or verification. The [elevator use cases](../examples/elevator/model/20_usecases/UseCases.sysml) connect passenger travel, door-obstruction recovery, and maintenance isolation to their respective concerns.

Use native `use case`, `actor`, `subject`, and `objective`. Represent scenario steps with `action` usages, successions for temporal order, and typed flows for transferred items. Reuse function definitions across scenarios and allocated responsibilities. A flow alone does not establish sequencing. Do not replace typed payloads with descriptive string labels.

## Conditions and degraded behavior

State what must be true before the interaction and what successful completion guarantees. Prose clarifies intent; an evaluable constraint must refer to model properties or observations. A constraint containing only a doc does not establish a checked condition.

When a capability is impaired, identify the changed outcome, remaining guarantees, responsible elements, and verification consequences. Use modes or states when the system persists in a degraded regime. Derive requirements or explicitly record accepted risks; avoid enumerating every error code without an engineering purpose.

Keep canonical requirements in `05_requirements` and reference them from the use case and its verification. State which paths are covered by the increment and which remain follow-up work.

## Review and views

Review the actor goal, boundary, observable outcome, typed exchanges, and relevant failure conditions. Use `ScenarioViewpoint` and `ScenarioView` from the method Viewpoints package when exposing a scenario for stakeholders. `MissionAndContextViewpoint` and `MissionAndContextView` support review of participants and the system boundary.

Follow the [worked example](../examples/elevator/README.md) to see the behavior connected to requirements, allocations, and verification.

## Scenario continuity through the architecture

For each scenario significant to the increment, follow the path from initiating event to observable outcome. Identify participating functions, their allocated elements, transferred items, interface conditions, and relevant time or resource budgets. Review nominal and selected degraded paths with the same boundary and baseline.

Check that every required step has a responsible element, each cross-boundary exchange has compatible types and directions, and sequencing and conditions are explicit where they matter. An allocation alone does not demonstrate a complete interaction path. Record missing exchanges or external responsibilities as open scope rather than implying they are modeled.

Reuse the existing functions, ports, requirements, and cases in a scenario view or review table. The table is a navigation aid, not another authoritative model. See the [elevator continuity review](../examples/elevator/README.md#scenario-continuity-and-interface-contracts).

## Optional capability reasoning in Context

A capability describes an operational ability and its conditions, rather than an actor interaction or an internal function. It is useful when several use cases or cooperating systems jointly provide a measurable outcome. Capture this reasoning in `10_context`, referencing canonical needs, requirements, and realizing scenarios; no separate Capabilities area, folder, or library type is required.

For the elevator, “retain passenger transport with one car unavailable” connects isolation, dispatch, passenger journeys and reduced-service expectations. State the availability condition, outcome measure or unresolved criterion, and relevant scenarios. Avoid adding capability names that merely repeat use-case titles. See the [elevator context outcomes](../examples/elevator/README.md#optional-capability-reasoning-in-context).
