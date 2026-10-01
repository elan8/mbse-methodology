# Use cases and scenarios

A use case describes an actor-facing goal. A scenario describes one path through an interaction that realizes that goal. Internal functions express responsibilities; not every function needs its own use case.

Identify the system subject and actor from the context. State the motivation, initiating trigger, relevant preconditions, and successful outcome. Model the nominal path, then select alternate or degraded paths that affect architecture, requirements, or verification. The [guard-stop use case](../examples/guard-stop/model/20_usecases/UseCases.sysml) contains guard-opening and signal-loss scenarios under one goal.

Use native `use case`, `actor`, `subject`, and `objective`. Represent scenario steps with `action` usages, successions for temporal order, and typed flows for transferred items. Reuse function definitions across scenarios and allocated responsibilities. A flow alone does not establish sequencing. Do not replace typed payloads with descriptive string labels.

## Conditions and degraded behavior

State what must be true before the interaction and what successful completion guarantees. Prose clarifies intent; an evaluable constraint must refer to model properties or observations. A constraint containing only a doc does not establish a checked condition.

When a capability is impaired, identify the changed outcome, remaining guarantees, responsible elements, and verification consequences. Use modes or states when the system persists in a degraded regime. Derive requirements or explicitly record accepted risks; avoid enumerating every error code without an engineering purpose.

Keep canonical requirements in `05_requirements` and reference them from the use case and its verification. State which paths are covered by the increment and which remain follow-up work.

## Review and views

Review the actor goal, boundary, observable outcome, typed exchanges, and relevant failure conditions. Use `ScenarioViewpoint` and `ScenarioView` from the method Viewpoints package when exposing a scenario for stakeholders. `MissionAndContextViewpoint` and `MissionAndContextView` support review of participants and the system boundary.

Follow the [worked example](../examples/guard-stop/README.md) to see the behavior connected to requirements, allocations, and verification.
