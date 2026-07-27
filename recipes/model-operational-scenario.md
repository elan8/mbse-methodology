# Recipe: Model an operational scenario

## Engineering question

What end-to-end scenario must succeed, and which participants, actions, and flows are involved?

## Expected input

- Context and key stakeholder concerns
- One concrete scenario narrative (happy path or critical safety path)

## Recommended steps

1. Write the scenario objective in one sentence.
2. Model the scenario as an `action def` (and a usage) with participants bound or referenced.
3. Decompose into a small number of steps (`action` usages) with `first … then …` and `flow` where items move.
4. Identify exceptional branches only when they change architecture or verification (see [model-degraded-behavior](model-degraded-behavior.md)).
5. Tag with `@EngineeringConcern { concern = behavior; }`.
6. Name increment scenarios clearly; keep work-scope (which PR/increment) in Git, not in model metadata.
7. Expose the scenario in a view that satisfies `ScenarioViewpoint`.

## SysML v2 concepts used

- `action def` / `action`
- `flow`, succession (`first` / `then`)
- `item` types for exchanged payloads
- `use case` (optional wrapper)
- `Elan8Viewpoints::ScenarioViewpoint`
- `Elan8Method::EngineeringConcern`

## Minimum required output

- One named scenario action with at least three steps
- Clear start condition and success outcome in `doc`
- Participants identifiable from context

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| One engineering-increment scenario | Multiple scenarios + use-case wrappers |
| Happy path only | Degraded path (see degraded-behavior recipe) |

Cross-link: robot-vacuum `cliffSafeStopGoldenThread`.

## Quality checks

- QR-BEH-01: external actors identified when visible
- QR-BEH-03: flows use defined item types when items are exchanged

## Example

```sysml
package Scenarios {
    import Elan8Method::*;
    import Elan8Viewpoints::*;

    item def CliffObservation;
    item def StopCommand;
    item def StatusReport;

    action def CliffSafeStopScenario {
        @EngineeringConcern { concern = behavior; }
        doc /* When a cliff is sensed, the robot stops and reports status. */

        action senseCliff { out observation : CliffObservation; }
        action supervise { in observation : CliffObservation; out command : StopCommand; }
        action stopMotion { in command : StopCommand; }
        action reportStatus { out report : StatusReport; }

        flow senseCliff.observation to supervise.observation;
        flow supervise.command to stopMotion.command;
        first senseCliff then supervise;
        first supervise then stopMotion;
        first stopMotion then reportStatus;
    }

    action cliffSafeStop : CliffSafeStopScenario;

    view cliffScenarioView : ScenarioView {
        expose cliffSafeStop;
    }
}
```

## Common mistakes

- Modeling every UI click instead of engineering-relevant steps
- Scenarios disconnected from later requirements and verification
- Using string labels instead of typed items/flows
