# Guard-stop engineering increment

Engineering question: can one controller remove drive enable within 200 ms after guard opening or loss of the guard signal?

This populated example with per-stage tailoring uses the project-template layout. It demonstrates method practice with native SysML v2 constructs, standard ISQ/SI quantities, and Elan8 metadata. All observations are synthetic teaching fixtures, not hardware test evidence or a machine safety assessment.

## Read the engineering chain

| Location | Anchor and purpose |
| --- | --- |
| `00_project` | `GuardStopProject::projectInfo`: project name and scope |
| `10_context` | `specifiedController`, operator, `preventUnexpectedMotion`: problem, stakeholder, and boundary |
| `05_requirements` | `safeAccess` frames the concern; `removeDriveEnable` derives from it, identifies its subject, and sets the inclusive 200 ms limit |
| `20_usecases` | `accessGuardedArea`: actor goal framing the stakeholder concern, trigger, precondition, result; nominal guard-opening and degraded signal-loss scenarios |
| `30_capabilities` | Explicitly merged into Physical for this small controller |
| `40_functions` | `detectStopDemand`, `disableDrive`: two reusable responsibilities |
| `50_logical` | Explicitly merged into Physical; no duplicate logical component tree |
| `60_physical` | Selected `controller`, explicit ports, two allocations, satisfaction claim, and decision rationale |
| `70_analysis` | `responseBudget`: 50 ms detection plus 100 ms output budget; an assumption, not measured proof |
| `80_verification` | `RemovalTimingCheck`: verifies the canonical system requirement and returns `VerificationCases::PassIf` over supplied observations |
| `90_views` | Traceability view exposes existing artifacts |
| `99_library` | Domain types for this example only |

Requirement subjects are typed Controller parameters, not fixed instance bindings. Satisfaction binds the subject to the selected controller; verification identifies the controller being evaluated. The use-case objective frames the same concern as the requirements; the use case is not a Controller and does not itself satisfy a Controller-subject requirement.

Requirements stay in their shared folder. Their subjects and the relationships, rather than folder adjacency, connect them to the other stages. Stakeholder and actor features are bound to the same operator. Scenario steps reuse the function definitions; function usages are allocated to the selected controller.

## Verification meaning

The definition expresses a test method. Its objective references the canonical `removeDriveEnable` requirement. Its verdict checks that the specified input event was applied, the output was disabled, and the observed response time is no greater than the requirement limit.

| Fixture | Event | Observation | Expected verdict |
| --- | --- | --- | --- |
| `nominalObservation` | Guard opened | Disabled at 150 ms | pass |
| `degradedObservation` | Signal lost | Disabled at 180 ms | pass |
| `lateResponseObservation` | Stop demand | Disabled at 201 ms | fail |

These are authored inputs and expected results of the expression. Static validation can resolve the definition without executing the cases. Real evidence must identify the controller configuration, test setup, input event, timing measurement, and observed output state. A report URI or a satisfaction relationship alone establishes none of these facts.

## Validation and limitations

Load `model/` with the repository's method `library/` and standard SysML v2 libraries. No external domain library or sibling repository is required.

Language reference: OMG SysML v2.0. Quantities and verdicts use standard library constructs. Validate parsing, import/type resolution, and the relationships important to the increment. Confirm derivation endpoints, behavior allocations, satisfaction claims, verification objectives, and stakeholder identity bindings. Validate verdict expressions with nominal, degraded, and negative inputs; a static check alone does not execute them.

Some environments may parse valid package-scope bindings without including them in semantic exports. Check the declared relationships in your chosen environment and document any unsupported layer rather than changing the engineering meaning to silence a diagnostic.

This increment covers input-to-drive-enable removal timing. Mechanical stopping distance, restart/reset behavior, fault diagnostics, real test evidence, and a complete safety assessment are follow-up engineering questions.
