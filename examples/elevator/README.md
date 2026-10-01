# Two-elevator office service

Engineering question: how can two elevators provide predictable passenger journeys across six floors, retain reduced service during a single-car outage, and manage selected door-related conditions?

This is the full-stage Elan8 example. It uses native SysML v2.0, standard quantities and verification verdicts, and the repository method library. Every engineering stage is applicable. The requirements, timings and observations are invented teaching data. The model is an architectural teaching baseline, not a certified elevator design or an executed simulation.

## Scope and stakeholders

The system includes a journey-request panel, group dispatch controller, and two car assemblies with local controllers, drives, brakes, doors and sensors. Floors are numbered 0 through 5. The panel accepts an origin and destination; the example uses destination-entry interaction to keep the typed request explicit. Detailed panels and per-floor installations are abstracted.

Passengers need predictable journeys and protected boarding/travel. The building owner needs service continuity; maintainers need controlled isolation and recovery. Building structure, power supply, emergency services and the maintenance organization are external. Installation, accessibility, maintenance and recovery inform review, while detailed shaft mechanics, fire-service behavior, evacuation, power-loss rescue and regulatory compliance remain open follow-ups. “Protected” describes an engineering intent; no safety conclusion follows from the supplied cases.

## Reading path through all seven stages

| Stage / supporting package | Model and engineering purpose |
| --- | --- |
| Project | [Project.sysml](model/00_project/Project.sysml) records the scope. All seven stage packages declare `applicable`. |
| Context | [Context.sysml](model/10_context/Context.sysml) identifies the system, passenger, owner, maintainer and three concerns. |
| Shared requirements | [Needs.sysml](model/05_requirements/Needs.sysml), [StakeholderRequirements.sysml](model/05_requirements/StakeholderRequirements.sysml), and [SystemRequirements.sysml](model/05_requirements/SystemRequirements.sysml) preserve the three roles and explicit derivation. |
| Use Cases | [UseCases.sysml](model/20_usecases/UseCases.sysml) models travel, door obstruction, and maintenance isolation, with typed scenario flows and sequencing. |
| Capabilities | [Capabilities.sysml](model/30_capabilities/Capabilities.sysml) groups passenger transport, protected access, and reduced service, including the realizing use cases. |
| Functions | [Functions.sysml](model/40_functions/Functions.sysml) declares six reusable responsibilities used by scenario steps. |
| Logical Architecture | [Logical.sysml](model/50_logical/Logical.sysml) separates fleet dispatch, local car control, door management and protective supervision; allocates functions and models assignment/status exchanges. |
| Physical Architecture | [Physical.sysml](model/60_physical/Physical.sysml) selects an installed two-car service, maps logical responsibilities to components and records design satisfaction claims. |
| Analysis | [Analysis.sysml](model/70_analysis/Analysis.sysml) calculates a synthetic mean wait and an illustrative obstruction-response budget, with assumptions. |
| Verification | [Verification.sysml](model/80_verification/Verification.sysml) defines five obligation checks, eleven synthetic observation usages and a planned stakeholder validation review. |
| Views | [Views.sysml](model/90_views/Views.sysml) exposes existing mission, scenarios, architecture, traceability and readiness content. |
| Local vocabulary | [Types.sysml](model/99_library/Types.sysml) defines typed requests, assignments, status, commands, ports, components and action signatures. |

Load [Root.sysml](model/Root.sysml) with the complete `model/` tree, the repository `library/`, and matching standard SysML v2 libraries. No external domain library or sibling checkout is needed. The baseline uses OMG SysML v2.0; views expose existing content and do not promise a particular graphical layout.

## Requirements and the traceability argument

| Need | Canonical obligation | Engineering response | Evaluation |
| --- | --- | --- | --- |
| NEED-001 predictable travel | CUST-001 mean wait <=30 s under the defined two-car profile | Fleet dispatch, local journey execution, DEC-001; waitingEstimate | WaitingCheck; stakeholderJourneyReview remains planned |
| NEED-001 predictable travel | SYS-001 valid request registration <=1 s | RegisterCall → dispatchManager → service.group | RegistrationCheck |
| NEED-002 protected boarding/travel | CUST-002 inhibit movement without confirmed closed/locked doors | InhibitMovement → protectiveSupervision → both local controllers | ProtectionCheck with unlocked-door condition |
| NEED-002 protected boarding/travel | SYS-002 obstruction reopening initiated <=0.5 s | ManageDoors → doorManagement → both local controllers; obstructionBudget | ObstructionCheck |
| NEED-003 service continuity | SYS-003 exclude unavailable car from subsequent assignments | ExcludeUnavailableCar → dispatchManager → service.group | OutageCheck with car B unavailable |

EB-01 revision A is a fictional customer brief embedded in the stakeholder-requirement documentation. CUST-001 is precise and directly used by analysis and verification; it is not copied into SystemRequirements. SYS-001 is a contributing engineering target, not a sufficient derivation of CUST-001. Derivation, allocation and satisfaction represent different claims. Physical satisfaction declarations do not establish a passing result or complete need coverage.

## Three engineering increments

1. **Passenger journey:** frame NEED-001, register a request, assign a car, execute pickup/transport, and open doors at arrival. Connect SYS-001 and CUST-001 to the responsibilities, components and checks.
2. **Coordinated service:** include both cars, assignment/status exchanges, dispatch alternatives and the waiting-time question. The baseline defines dispatch responsibility and contracts; a scheduling algorithm and traffic simulation are future refinements.
3. **Degraded operation:** trace door obstruction and single-car isolation to SYS-002/SYS-003, door/protection responsibilities, response budget, and negative verification controls. Reduced service preserves transport capability without asserting the unchanged two-car waiting target.

These are a reading and development sequence for the final baseline, not separate stored historical models or claims that execution has occurred.

## Scenario continuity and interface contracts

A valid request carries origin and destination through RegisterCall and AssignCar; the resulting assignment carries car identity and destination to ExecuteJourney; arrival status reaches ManageDoors. Explicit successions establish order separately from flows. Scenario usages reuse action definitions; allocations map canonical function usages to logical responsibilities.

The dispatch interface sends a typed assignment and returns typed availability/floor status. Conjugated local ports reverse directions. The installed service connects panel to group controller and group to each car controller, with explicit flows in both dispatch directions. Local controllers connect to drive and door-actuator command ports. Logical-to-physical allocations keep responsibility distinct from implementation selection.

Door/protection collaboration, brake wiring, sensor signal contracts, pickup/boarding detail, retry state machines and emergency behavior remain incomplete. The component list is not proof of complete wiring. Check that the unavailable-car condition is reflected in dispatch observations; check door inhibition separately from reopening latency.

## Architecture decision and alternatives

DEC-001 selects central fleet dispatch with local car control. RISK-001 records dependence on the group controller; assigning protective supervision to local controllers does not establish independent protection.

| Criterion | Central dispatch + local control (selected) | Fully distributed dispatch | One controller for all functions |
| --- | --- | --- | --- |
| Fleet information | One assignment view; explicit status links | Requires consistency and coordination protocol | One view, less separation of responsibilities |
| Local door/motion control | Local responsibilities retained | Local responsibilities retained | Coupled to the common implementation |
| Integration effort | Two dispatch links plus local command links | Additional coordination contracts | Simpler topology but broader common controller scope |
| Failure concerns | Group outage; local common-cause risks unresolved | Coordination loss and split decisions require analysis | Broad common-controller dependency |
| Waiting/energy evidence | Only synthetic waiting fixtures | Not evaluated | Not evaluated |

The selection is a qualitative teaching decision, not measured superiority. Non-negotiable obligations still apply to any candidate. A traffic simulation, fault analysis and cost/energy estimates may change the choice; energy and accessibility currently have no quantitative baseline.

## Analysis and observation profile

For CUST-001, both cars are available and six valid requests are made. Requests have one passenger each, no obstruction, and no other traffic. Initial car positions are A at floor 0 and B at floor 5. The following is an invented observation dataset, not the output of a dispatch algorithm.

| Request time (s) | Origin → destination | Call-to-pickup-door-open wait (s) |
| --- | --- | --- |
| 0 | 0 → 3 | 12 |
| 10 | 5 → 1 | 18 |
| 20 | 2 → 4 | 24 |
| 30 | 1 → 5 | 20 |
| 40 | 4 → 0 | 16 |
| 50 | 3 → 0 | 30 |

`waitingEstimate` calculates (12+18+24+20+16+30)/6 = **20 s**, against the illustrative 30 s limit. It demonstrates calculation and traceability without establishing service performance. `obstructionBudget` sums detection 0.1 s, control 0.1 s and actuation 0.2 s to **0.4 s**, leaving an illustrative 0.1 s margin. ASM-001 and ASM-002 identify the lack of measured evidence.

## Verification versus validation

| Check | Applied conditions and supplied observations | Expected outcome |
| --- | --- | --- |
| RegistrationCheck | Valid floors/request, service available; 0.4 s / 1.0 s / 1.1 s registration | pass / pass / fail |
| WaitingCheck | Two cars, defined profile; mean 20 s / 31 s | pass / fail |
| ObstructionCheck | Obstruction during closing; reopening initiation 0.4 s / 0.6 s | pass / fail |
| ProtectionCheck | Doors not confirmed closed/locked; movement inhibited true / false | pass / fail |
| OutageCheck | Car B declared unavailable; subsequent assignments exclude B true / false | pass / fail |

`PassIf` defines how supplied observations produce verdicts. The cases do not generate those observations, run hardware tests or execute the dispatch behavior. Invalid or missing evidence needs an inconclusive review disposition; `conditionApplied` is an input claim requiring evidence, not an automatic detector of test validity.

`stakeholderJourneyReview` is a planned validation case referencing NEED-001. Agree representative traffic, successful requested-floor arrival, accessibility conditions and passenger feedback criteria with stakeholders before supplying observations. A passing mean-wait test alone does not establish convenient or accessible journeys. NEED-002 and NEED-003 also require broader validation; protection and outage checks address selected obligations only.

Real evidence must identify configuration, procedure, traffic/door/outage conditions, measurement method, units, raw observations and provenance. No real evidence record or completed validation is supplied.

## Change-impact walkthrough

If the owner proposes CUST-001 <=15 s, preserve the source revision and clarify the profile first. Reassess passengerTransport, travel, DEC-001, dispatch assumptions, waitingEstimate and WaitingCheck. The current synthetic mean of 20 s would exceed the proposed limit by 5 s. SYS-001 need not change automatically: it is only one contributor. Investigate dispatch policy, car performance and doors before selecting a revised architecture. Keep previous evidence tied to its baseline and review applicability before reuse. Validate intended passenger outcomes separately.

If a car becomes unavailable, follow reducedService and isolateCar through ExcludeUnavailableCar and dispatch status to OutageCheck. Reassess throughput and stakeholder expectations; do not apply the two-car waiting profile to the degraded mode unchanged.

## Readiness and limitations

Use [stage readiness](../../docs/stage-readiness.md) to review the scoped claims in each applicable stage. Critical obligations have planned checks and negative controls; selected typed collaboration paths and realization allocations are present. Detailed protective design, full interface coverage, execution evidence, accessible service criteria and lifecycle procedures remain open. All stages contain useful content; none is claimed complete for a real elevator project.

Static checks validate parsing, resolution and represented relationships. They do not evaluate all expressions, establish physical feasibility, or substitute for engineering review. The compact [guard-stop example](../guard-stop/README.md) remains useful for learning a smaller tailored increment.

## Baseline check record

The initial example check covered 15 model documents with zero reported errors or warnings. The semantic export contained four use-case inclusions, fourteen allocations with source/target relationships, five satisfaction targets, and six verification targets (including the planned stakeholder review). Published connector endpoints resolved.

Independent arithmetic and Boolean review of the eleven supplied fixtures matched their documented expected outcomes. This review did not execute SysML verification cases or simulate elevator behavior. Documentation links and repository library-usage checks also passed. These checks establish the represented baseline within the available validator's coverage; they do not establish exhaustive language conformance or physical performance.
