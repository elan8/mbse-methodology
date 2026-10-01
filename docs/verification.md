# Verification and evidence

Verification establishes how an obligation will be evaluated. A satisfaction relationship is a design claim; a linked verification case is planned coverage. Neither alone demonstrates that the requirement is met.

For each critical requirement, identify the method (test, analysis, inspection, or demonstration), subject, applicable conditions, and acceptance criteria. Use a native verification case with an objective that `verify`s the canonical requirement. Plan coverage within the engineering increment; one case may verify several related obligations, and one obligation may need multiple conditions or cases.

## Definition, observation, verdict, and evidence

A verification definition describes the method and acceptance expression. A case usage identifies the subject and supplies observations for a configuration and condition. Its verdict is the evaluated outcome; evidence establishes where the observations came from. A static model check does not execute a physical test or establish that a verdict is true.

The [elevator verification](../examples/elevator/model/80_verification/Verification.sysml) references the canonical requirement and its response-time limit. It uses standard `VerificationCases::PassIf` over supplied observations. Synthetic registration and obstruction observations include passing and late-response negative controls. These fixtures are teaching data, not hardware evidence.

When validating a verdict expression, consider the exact acceptance boundary, just-over-limit values, incorrect output, and missing or invalid conditions. State when a result should be inconclusive or erroneous rather than forcing every situation into pass/fail.

## Evidence provenance

Evidence should identify the configuration/baseline, procedure, applied condition, measurement method, units, observed result, and provenance. Keep raw logs and datasets outside the model. Optionally own a `VerificationEvidence` record in the relevant case and use its URI to reference the external artifact. A report link without relevant observations and baseline information is insufficient.

Analysis may support a verification case when its assumptions and inputs are justified. A budget calculation supports a prediction; it is not automatically a measurement. See [evidence and claims](evidence-and-claims.md).

## Coverage and review

Use `VerificationReadinessViewpoint` and `VerificationReadinessView` to expose missing cases, methods, criteria, or evidence. Review critical requirement coverage and residual gaps against the [quality rules](quality-rules.md) and [diagnostic contract](quality-diagnostic-contract.md). Distinguish proposed checks, implemented checks, and manual review.

Keep the subject and requirement canonical so changes to a limit or baseline can be traced to affected cases. Record residual risks and follow-up questions in the engineering increment.

## Stakeholder validation

Verification asks whether the system meets its specified requirements. Stakeholder validation asks whether it achieves the intended outcome in its operating context. Passing a response-time requirement does not establish that access to a machine is safe.

Plan both questions when framing an increment. For validation, identify the stakeholder need, representative lifecycle scenario, participating people and external systems, outcome measure, conditions, and evidence needed. Review conflicting needs and agree the success criteria with relevant stakeholders. A requirement may be correctly verified while its interpretation of the need remains inadequate.

Keep validation plans, cases, and evidence alongside verification in `80_verification`; use the canonical needs in `05_requirements` and scenarios in `20_usecases`. No additional model area or method-library type is needed. Native cases can express the evaluation; their names and documentation should make the validation purpose clear. Do not claim an executed validation from a planned case or stakeholder review of a model alone.

Report requirement results and stakeholder outcomes separately, with the evaluated baseline, limitations, and unresolved needs. See the [elevator validation gap](../examples/elevator/README.md#verification-versus-validation) and [increment review](increment-review.md).

## Requirements from different sources

Customer/stakeholder requirements and system requirements both need verification against their applicable criteria and subject boundaries. Do not infer machine-level compliance from passing controller checks. Preserve source traceability, review whether derived obligations collectively address the source, and identify evidence gaps. Validation addresses stakeholder needs and intended use separately. See [requirement roles](requirements.md#needs-stakeholder-requirements-and-system-requirements).
