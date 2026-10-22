# Elevator call acknowledgement — one complete interaction

This example follows one valid request from the user to registration and back as an acknowledgement. It demonstrates BB/GB/WB structure, inherited requirements, boundary delegation, behavior realization and contextual timing. All timing values are synthetic; movement and safety control are outside its scope.

Load this directory's `model/` with the frozen dependency from the methodology lock. The selected usage is `Elevator::releaseA`. All three systems are siblings under `60_systems`.

Contract, architecture and integration definitions are directly owned by their
system packages. The leaf panel and controller need architectures but no empty
integration definitions. Verification and Views remain useful grouping packages.

## Follow the interaction

1. The referenced user sends `CallRequest` through a conjugated `CallServicePort`. The elevator's boundary port accepts it and returns a `CallAcknowledgement`.
2. In the BB, `AcknowledgeCall` binds its input/output to that port and constrains acknowledgement `callId` to match the request.
3. The GB binds its boundary port to the panel's operator port, connects the panel's registration port to the controller, and models request/response flows on that connection.
4. `RoutedAcknowledgement` specializes the boundary action with forward → register → present actions. These occurrences are bound to child-performed actions and explicitly allocated to the panel/controller.
5. The WB redefines the panel/controller usages with their selected designs, preserving the interfaces and inherited behavior/requirements.

The shared `CallServicePort`, request/acknowledgement items and reusable child actions are in `50_library`.

## Contract binding

`AcknowledgementRequirement` owns the timing criterion. The named usage `ELEV-SYS-001` provides its stable identity. Crucially, `ElevatorSpecification` contains `satisfy acknowledgement;`: its satisfying subject is implicit self under SysML §7.21.4.

That assertion is inherited by each architecture/integration. Package proximity alone would not bind the requirement. The verification objective references the authoritative requirement, and `releaseAAnalysis` identifies the selected subject. It is a planned case with no execution verdict.

## Timing selection

| Constituent | Independent limit | Parent-local limit | Design contribution | Selection |
|---|---:|---:|---:|---|
| Panel, standard design | 80 ms | 50 ms | 60 ms | Rejected here |
| Panel, fast design | 80 ms | 50 ms | 40 ms | Selected |
| Controller | 150 ms | 150 ms | 120 ms | Selected |

The serial total is 40 + 120 = **160 ms**, against a **200 ms** system limit. The panel contribution includes forwarding and presentation together. No queue, communication overhead or concurrency is modeled. The selected residual margin is 40 ms; allocated limits themselves reserve no extra margin.

The rejected 60 ms panel would yield a passing 180 ms system total but violate its local 50 ms allocation. Both contract levels matter.

## Views and checks

The four defaults are `ElevatorContext::context`, `Elevator::Views::specification`, `Elevator::Views::architecture` and `Elevator::Views::integration`. Structural views omit detailed action/data expressions; the behavior remains authoritative in the model. A standard ActionFlowView can expose `RoutedAcknowledgement` when needed, without adding another mandatory view.

From the methodology root, use [validation and checker commands](../../docs/library-and-tooling.md). The reference structural checker reports no definition-structure findings for this example, including complete-selection mode.

This is a connected modeling example, not a physical elevator design or an executed simulation. Native language checks, structural diagnostics and prepared view inspection do not establish measured timing or operational validation. See [validation notes](validation.md).
