# Method mapping (orientation)

Elan8 Method concerns, activities, and fixed stages compared to familiar MBSE
approaches. This is **orientation**, not a claim of one-to-one equivalence.

## Fixed stages vs familiar phases

Every project has the same seven stage packages (`10_context` …
`80_verification`, see [engineering-increments.md](engineering-increments.md)
and the [project template](../templates/project-template/README.md)). This
table is the closer, structural comparison for teams coming from a
phase-based methodology:

| Elan8 stage | Typical activities | SYSMOD (approx.) | OOSEM (approx.) | Arcadia (approx.) | INCOSE process flavor |
| --- | --- | --- | --- | --- | --- |
| Context | Problem, boundary, stakeholders, concerns | System idea, stakeholder needs | Stakeholder needs, context | Operational Analysis (need) | Stakeholder needs definition |
| Use Cases | Actor goals, nominal/degraded scenarios | Use cases / processes | Scenario analysis | Operational Analysis (scenarios) | Use case / scenario definition |
| Capabilities | Mission outcomes and derived obligations | — (implicit in use cases) | Capability needs | Operational capabilities | Business/mission analysis |
| Functions | Requirement derivation and functional analysis | Logical behavior | Functional analysis | System Functional Analysis | Functional analysis & allocation |
| Logical Architecture | Responsibilities and interface contracts | System architecture | Logical architecture | Logical Architecture (LA) | Architecture definition |
| Physical Architecture | Implementation selection and allocation | System architecture | Physical architecture | Physical Architecture (PA) | Architecture definition |
| Verification | Verification definition and evidence | Requirements & test | Verification planning | Integration & IVV hooks | Verification & validation |

Elan8 does not have a dedicated Arcadia-style "System Analysis" (SA) stage;
its scope splits across Capabilities and Functions. Conversely, Arcadia has
no first-class Capabilities layer between Operational Analysis and System
Analysis the way Elan8 does — treat both as approximate, not exact.

## Continuous concerns vs familiar activities

Independently of the fixed stages, the [six continuous
concerns](concerns.md) are a cross-cutting lens usable on any element in any
stage. This table compares concerns, not stages:

| Elan8 concern | Typical activities | SYSMOD (approx.) | OOSEM (approx.) | Arcadia (approx.) | INCOSE process flavor |
| --- | --- | --- | --- | --- | --- |
| Purpose | purpose, context, concerns | System idea, stakeholder needs | Stakeholder needs, context | Operational Analysis (need) | Stakeholder needs definition |
| Behavior | scenario, degraded behavior | Use cases / processes | Scenario analysis, logical behavior | System / Logical functions | System requirements & functional analysis |
| Architecture | logical architecture, interface, decision | System architecture | Logical → physical architecture | Logical / Physical Architecture | Architecture definition |
| Evidence | evaluate alternative | Trade-off / analysis | Analysis / trade studies | Early validation | Analysis & decision management |
| Verification | derive requirements, verification | Requirements & test | Verification planning | Integration & IVV hooks | Verification & validation |
| Evolution | (Git + quality rules) | Configuration / baselines | Iterative development | Model maintenance | Configuration & information management |

## Deliberate differences

- Elan8 fixes the **stage structure** (seven packages, always present) so
  projects look alike and tooling can rely on a known shape, but tailors
  **content** per project: a stage can be `notApplicable` or
  `mergedIntoAnotherStage` (with a required rationale) via `StageDisposition`
  — see [abstraction-levels.md](abstraction-levels.md). This is stricter than
  the old "levels are optional" guidance, and looser than a mandatory
  waterfall: skipping is explicit and reviewable, not silent.
- Work is still organized as **continuous concerns** and **vertical
  engineering increments** (scoped in Git/PR, not SysML process metadata).
  Concerns and stages are independent axes — an increment typically touches
  several concerns across one or two stages in a single coherent PR, not a
  full pass through all seven stages.
- Logical architecture as a **parallel part tree is optional**; allocation
  from actions to parts is required. Merge Logical into Physical (or
  Functions into Logical) with `StageDisposition` when a separate logical
  model would just duplicate the physical one.
- Textual SysML v2 + Git are first-class; diagrams are views.
- Method metadata stays light; process enforcement prefers PRs, CODEOWNERS,
  and CI.

## If you already use Arcadia or OOSEM

The fixed stage structure now maps closely onto OA/SA/LA/PA-style phases (see
the table above), so keep your team's mental model and expect the folder
names to line up more directly than before. Map Elan8 activities onto the
activities you already run, use `StageDisposition` to merge stages your
process doesn't distinguish (for example, no separate Capabilities layer),
and adopt the project template when starting new SysML v2 work.
