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

## Stakeholder validation gap

The operator needs safe access, while this increment only specifies removal of drive enable within 200 ms. Those are different claims: the timing result does not establish that motion has stopped before access. A stakeholder validation plan must consider machine stopping behavior, access time, restart prevention, and relevant operating and maintenance conditions with the operator and responsible domain specialists.

Keep that plan and future evidence in `80_verification`, referencing `safeAccess` and its scenarios. Agree an observable safe-access outcome before assessing it. This example provides no machine-level outcome criterion, executed validation, or safety conclusion; those are explicit follow-up questions rather than satisfied claims. Installation, maintenance, and recovery may introduce further stakeholders and needs.

## Scenario continuity review

| Scenario path | Existing model anchors | Review result / open boundary |
| --- | --- | --- |
| Guard opening | `accessGuardedArea` → `DetectStopDemand` → `RemoveDriveEnable`; `detectStopDemand` and `disableDrive` allocated to `controller` | Responsibilities are represented; review scenario usages against the allocated function definitions. |
| Guard signal lost | Degraded path in `accessGuardedArea`, same function definitions and controller | The input condition changes; required output removal remains. Recovery and reset behavior are outside scope. |
| Controller input to output | `GuardInput.signal : GuardSignal` and `DriveOutput.command : DriveEnable`; `responseBudget` | Public payloads and directions are typed. Internal transfer detail and external sensor/drive wiring are not modeled. |
| Timing evaluation | `removeDriveEnable`, `RemovalTimingCheck`, nominal/degraded/late fixtures | Planned checks use the requirement limit. Synthetic observations do not establish a realized end-to-end response. |
| Output removal to stakeholder outcome | `safeAccess` and `preventUnexpectedMotion` | Mechanical stopping and prevention of unexpected restart remain gaps in validation. |

This table guides review of the canonical model. It does not introduce new flows, connections, or verification results. Inspect the relevant paths and exchanges before expanding a claim beyond the controller boundary.

## Architecture comparison

`DEC-001` selects one controller for detection and output inhibition. The following comparison explains its teaching scope; it is qualitative judgment, not measured candidate performance.

| Criterion | One controller | Separate detection and inhibition elements |
| --- | --- | --- |
| Measurable response boundary | One input-to-output boundary | Requires accounting for an inter-element exchange |
| Allocation and interfaces | Two responsibilities on one element | Requires additional allocation and interface contracts |
| Timing feasibility | Illustrative 50 ms + 100 ms budget predicts 150 ms | Not analyzed; exchange latency and processing budgets are unknown |
| Fault independence | Not demonstrated | Separation alone does not establish independence; analysis is needed |
| Example scope | Sufficient to teach the scoped timing chain | Adds detail without evidence needed by this teaching question |

The mandatory timing obligation is 200 ms for either candidate. The selected candidate is retained for the scoped example because it provides a simple response boundary; this is not proof that it is the appropriate machine safety architecture. Hardware measurements and fault analysis could change a real project's selection. The separate candidate is described here, not instantiated in the model.

## Change-impact walkthrough

Suppose a stakeholder review proposes reducing `SYS-001` from 200 ms to 120 ms. This is a hypothetical next increment; the supplied model retains its 200 ms baseline.

1. Frame the reason for the tighter limit and review whether it improves the intended safe-access outcome. Update the canonical requirement only after resolving the intended scope and conditions; retain its short name.
2. Trace the change to guard-opening and signal-loss scenarios, both allocated responsibilities, `DEC-001`, `responseBudget`, and `RemovalTimingCheck`. The public payload types need not change merely because a time limit changes; investigate whether a revised implementation needs a different interface.
3. Reassess `ASM-001`: the illustrative 150 ms budget would exceed 120 ms by 30 ms. The previous architecture rationale therefore needs review, with feasible budgets or alternative designs supported by evidence.
4. Reassess the supplied observations: 150 ms and 180 ms would no longer meet the limit; 201 ms would still fail. These are expected comparisons, not newly executed cases. Review exact-boundary and invalid-condition cases as part of the revised evaluation.
5. Keep prior evidence tied to its original configuration and procedure. A limit-only change may allow observations to be re-evaluated if their conditions remain applicable; a hardware or procedure change requires a separate applicability assessment and possibly new evidence.
6. Review stakeholder validation separately: meeting 120 ms would still not establish safe access. Record remaining stopping and restart questions, then accept or revise the increment through Git review.

Use the [stage readiness criteria](../../docs/stage-readiness.md) to review this change across Context, Use Cases, Functions, Physical Architecture, and Verification. Apply relevant Capabilities and Logical criteria to their Physical merge target. No separate stage completion or process metadata is required.

## Customer requirement versus controller obligation

An illustrative customer obligation, “The machine shall prevent hazardous motion while the access guard is open,” differs from the operator's safe-access need and the controller's 200 ms obligation. If supplied to a project, preserve it with its source/revision in `05_requirements/StakeholderRequirements.sysml` and derive the applicable system obligations explicitly. This example does not include a supplied customer baseline or instantiate that hypothetical machine requirement.

Its response-time check only addresses the controller obligation. Mechanical stopping, restart prevention, and fault handling may be needed to address the broader machine obligation, with verification at that boundary. Stakeholder validation must additionally assess safe access in intended use. Do not create a duplicate system requirement when a supplied obligation is already directly applicable.
