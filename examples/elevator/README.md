# Elevator call acknowledgement — recursive timing slice

This example asks: **which panel design fits a 50 ms contextual panel allocation within a 200 ms system response limit?** All numbers are synthetic. The subject is call acknowledgement, not elevator movement, passenger safety or a full product specification.

Load only `model/` in this directory. Entry/navigation is `model/Root.sysml`; the assessed usage is `Elevator::Integration::releaseA`. The example uses the numbered model folders and imports `Elan8::SystemsEngineering` from the shared domain library. All three systems are siblings under `60_systems`; composition is defined by part usages.

## Engineering inputs

- Scenario: a user submits a valid call; the panel processes it and the controller registers it under nominal unloaded operation.
- Source obligation `ACK-NEED-01`: provide timely acknowledgement; this teaching scenario proposes a 200 ms limit as `ELEV-SYS-001`.
- Timing assumption: two serial contributions, with zero communication/queuing overhead for this narrow calculation. Real system acceptance would have to justify these exclusions or budget them explicitly.

## Selection and timing

| Parent role | Reusable contract | Parent-local obligation | Candidate latency | Disposition |
|---|---|---|---|---|
| panel | PanelSpecification: ≤80 ms | ≤50 ms | StandardPanelArchitecture: 60 ms | Rejected for this context despite meeting the reusable contract |
| panel | PanelSpecification: ≤80 ms | ≤50 ms | FastPanelArchitecture: 40 ms | Selected for ReleaseA; numerical timing allocation met |
| controller | ControllerSpecification: ≤150 ms | ≤150 ms | ControllerArchitecture: 120 ms | Selected; numerical timing allocation met |

Allocated limits: 50 + 150 = 200 ms, with no reserved allocation margin. Selected contributions: 40 + 120 = 160 ms; residual system margin is 40 ms under the stated abstraction. The rejected combination totals 180 ms and meets the top-level limit, yet still violates the agreed local panel obligation. Both levels must be checked.

The model preserves `panel` through redefinition and inherits its parent-local 50 ms limit in the integration. The selected latency is 40 ms; the table above explicitly reconciles it with that limit. The reusable panel has a default 80 ms limit and a constraint preventing relaxation beyond 80 ms. The standard panel alternative remains available independently. Leaf architectures have no child selections and no separate integration definitions in this tailored slice.

## Requirements and evidence

| Obligation | Subject/design claim | Planned case | Execution evidence | Status |
|---|---|---|---|---|
| ELEV-SYS-001 | Elevator specification; satisfaction claim by releaseA | releaseAAnalysis / AcknowledgementAnalysis | None | Planned; not verified |
| ACK-NEED-01 | Stakeholder obligation; source of the proposed system criterion | Operational validation outside this slice | None | Preliminary; acceptance outstanding |
| Local panel allocation | ElevatorArchitecture.panel, 50 ms | Contextual comparison during selection review | Synthetic arithmetic above only | Numerical illustration, product evidence outstanding |

The verification case identifies its objective and configured subject. Language checking does not execute that case or establish a pass verdict. Child timing assertions are model constraints, not measured supplier guarantees.

## Explore the model

1. Locate the actual specification → architecture → integration specialization chain.
2. Confirm child usages in architecture are contract-typed, and integration redefines their inherited identities.
3. Explain why the standard panel cannot be selected, even though its combined system timing passes.
4. Inspect the `CallPort` item direction, conjugated receiver and connection. This internal request topology is not a complete boundary interaction model.
5. Check the requirement subject, satisfaction claim and verification objective. Identify missing operational validation and execution evidence.

The [four view recipes](../../docs/views.md) are implemented: `ElevatorContext::context`, `Elevator::Views::specification`, `Elevator::Views::architecture` and `Elevator::Views::integration`. Shared GeneralView specializations supply the filters. The integration exposes `releaseA`, rather than the entire integration package. The tables above are explanatory notes, not generated reports. Context/scenario/requirement areas identify the slice and its source; they remain preliminary. This slice intentionally omits complete acknowledgement event behavior, responsibility allocations, formal child requirements, broader interface compatibility and product evidence. It illustrates the recursive mechanism and is not a complete or verified elevator design.

Run from the methodology root:

```powershell
./scripts/validate_models.ps1 -Spec42 /absolute/path/to/spec42.exe
```

See [validation record](validation.md) for the actual local result and its limits.
