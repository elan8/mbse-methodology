# Verification and evidence

Verification establishes how an obligation will be evaluated. A satisfaction relationship is a design claim; a linked verification case is planned coverage. Neither alone demonstrates that the requirement is met.

For each critical requirement, identify the method (test, analysis, inspection, or demonstration), subject, applicable conditions, and acceptance criteria. Use a native verification case with an objective that `verify`s the canonical requirement. Plan coverage within the engineering increment; one case may verify several related obligations, and one obligation may need multiple conditions or cases.

## Definition, observation, verdict, and evidence

A verification definition describes the method and acceptance expression. A case usage identifies the subject and supplies observations for a configuration and condition. Its verdict is the evaluated outcome; evidence establishes where the observations came from. A static model check does not execute a physical test or establish that a verdict is true.

The [guard-stop verification](../examples/guard-stop/model/80_verification/Verification.sysml) references the canonical requirement and its response-time limit. It uses standard `VerificationCases::PassIf` over supplied observations. Nominal and degraded synthetic inputs have expected passing verdicts; a late response is a negative control. These fixtures are teaching data, not hardware evidence.

When validating a verdict expression, consider the exact acceptance boundary, just-over-limit values, incorrect output, and missing or invalid conditions. State when a result should be inconclusive or erroneous rather than forcing every situation into pass/fail.

## Evidence provenance

Evidence should identify the configuration/baseline, procedure, applied condition, measurement method, units, observed result, and provenance. Keep raw logs and datasets outside the model. Optionally own a `VerificationEvidence` record in the relevant case and use its URI to reference the external artifact. A report link without relevant observations and baseline information is insufficient.

Analysis may support a verification case when its assumptions and inputs are justified. A budget calculation supports a prediction; it is not automatically a measurement. See [evidence and claims](evidence-and-claims.md).

## Coverage and review

Use `VerificationReadinessViewpoint` and `VerificationReadinessView` to expose missing cases, methods, criteria, or evidence. Review critical requirement coverage and residual gaps against the [quality rules](quality-rules.md) and [diagnostic contract](quality-diagnostic-contract.md). Distinguish proposed checks, implemented checks, and manual review.

Keep the subject and requirement canonical so changes to a limit or baseline can be traced to affected cases. Record residual risks and follow-up questions in the engineering increment.
