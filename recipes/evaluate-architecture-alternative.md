# Recipe: Evaluate an architecture alternative

## Engineering question

Which option best satisfies the key constraints, and why?

## Expected input

- Decision driver (requirement, cost, risk, schedule)
- Two or more candidate approaches
- Evaluation criteria

## Recommended steps

1. State the decision objective and criteria (performance, risk, cost, feasibility).
2. Model each alternative lightly (variants, separate usages, or documented options) — enough to compare, not full designs.
3. Capture assumptions with `@Assumption`.
4. Run or reference analysis (`analysis` case) when quantitative.
5. Record the selection with `@DecisionRecord` (id, title, rationale, status).
6. Update satisfy/allocate links to the chosen option; mark rejected options deprecated or remove if unused.

## SysML v2 concepts used

- `@DecisionRecord`, `@Assumption`, `@Risk` (`Elan8Method`)
- `analysis` cases; optional `variation`/`variant` when product-line is in scope
- Dependencies such as `selectedImplementation` (see robot-vacuum purchased parts)

## Minimum required output

- Written criteria
- Chosen option with rationale metadata
- Explicit assumptions

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| DecisionRecord + short doc rationale | Analysis case with quantitative criteria |
| Two options described in `doc` | Modelled alternatives with comparable structure |

## Example

```sysml
metadata def /* use Elan8Method::DecisionRecord */;

part def RobotMainMcu :> Microcontroller {
    @DecisionRecord {
        decisionId = "ADR-MCU-001";
        title = "Select STM32U5 class MCU";
        rationale = "Meets timing budget and vendor longevity";
        status = "accepted";
    }
}
```

## Quality checks

- QR-ARCH-05, QR-AN-01, QR-AN-02

## Common mistakes

- Choosing silently in a meeting with no model/Git trace
- Modelling five full architectures when a decision record would suffice
