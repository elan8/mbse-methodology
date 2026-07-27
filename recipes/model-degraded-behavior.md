# Recipe: Model degraded behavior

## Engineering question

What happens when a capability is lost or impaired?

## Expected input

- Nominal scenario and related requirements
- Failure / hazard drivers worth architecture or verification attention

## Recommended steps

1. Select exception paths that change design or verification (ignore cosmetic UI faults).
2. Extend the scenario with alternate successions or a dedicated degraded `action def`.
3. Model modes/states (`state def`) when the system stays in a degraded regime.
4. Derive or refine safety/performance requirements for the degraded path.
5. Allocate new responsibilities; add verification for the exception.

## SysML v2 concepts used

- `action`, `state`, `accept` / transitions, `first`/`then`
- Safety overlays from domain libraries when applicable

## Minimum required output

- One modelled degraded/exception path for the increment
- Linked requirement or explicit risk acceptance

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| One critical exception in the increment scenario | State machine for operating modes + multiple hazards |
| Doc-level handling for rare cases | Full fail-safe allocation and verification |

## Example

```sysml
action def CliffSafeStopScenario {
    action senseCliff;
    action supervise;
    action stopMotion;
    action reportStatus;
    first senseCliff then supervise;
    first supervise then stopMotion;
    first stopMotion then reportStatus;
    doc /* Degraded outcome: motion inhibited; mission aborted; user notified. */
}
```

## Quality checks

- QR-BEH-02, QR-REQ-03 for safety-related degraded paths

## Common mistakes

- Modelling every error code
- Degraded behavior with no requirement or verification impact
