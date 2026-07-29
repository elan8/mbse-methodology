# Recipe: Define requirement verification

## Engineering question

How will we demonstrate that a critical requirement is met?

## Expected input

- System/safety requirements with subjects and constraints
- Available test/analysis methods

## Recommended steps

1. For each critical requirement, choose a method (test, analysis, inspection, demonstration).
2. Create a `verification` case with `subject` and `objective { verify <requirement>; }`.
3. State pass criteria in `doc` or constraints; link analysis when quantitative.
4. Optionally add `VerificationEvidence` with an `evidenceUri` pointing outside the model.
5. Do not treat “verification case exists” as “passed” without a verdict/evidence process.

## SysML v2 concepts used

- `verification` case, `verify`
- `Elan8::Method::Requirements::VerificationEvidence`
- Analysis cases feeding verification (robot-vacuum cliff thread)

## Minimum required output

- One verification case per critical requirement in the increment
- Clear pass criteria

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| Verification cases + doc pass criteria | Evidence URIs, baselines, coverage view |
| Analysis optional | Analysis cases bound into verification objectives |

## Example

```sysml
verification verifyCliffSafeStop {
    subject robot : CleaningRobot;
    objective {
        verify stopOnCliff;
    }
    doc /* Pass: stop within maxSafeStopReactionTime under cliff fixture tests. */
}
```

See also: robot-vacuum `verifyCliffSafeStop` + `SafetyReactionAnalysis`.

## Quality checks

- QR-REQ-03, QR-VER-01, QR-VER-02, QR-VER-03
- Contract: [spec42-quality-contract](../docs/spec42-quality-contract.md)

## Common mistakes

- Verification cases that never `verify` a requirement
- Storing large test logs inside the model instead of URIs
