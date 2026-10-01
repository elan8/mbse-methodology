# Workflow loop

Default working loop for each [engineering increment](engineering-increments.md).

Concerns remain continuous and non-linear. This loop is a **repeatable path through an increment**, not a project waterfall.

```text
Frame → Explore → Architect → Evaluate → Verify → Evolve
```

```mermaid
flowchart LR
  Frame --> Explore --> Architect --> Evaluate --> Verify --> Evolve
  Evolve -.-> Frame
```

## Frame

Clarify:

- the engineering question;
- system scope;
- stakeholders;
- concerns;
- constraints;
- success criteria.

Separate the existing problem, desired stakeholder outcome, and candidate solution. Identify the system boundary, stakeholders, external interactions, assumptions, and exclusions. Capture stakeholder concerns and frame them with the needs they motivate; avoid treating a stakeholder wish as an implementation choice.

## Explore

Develop:

- scenarios;
- use cases;
- behavior;
- operational context;
- exceptional and degraded situations;
- candidate requirements.

See [behavior](behavior.md) and [requirements](requirements.md) for actor goals, scenario paths, and measurable obligations.

## Architect

Define:

- responsibilities;
- logical structure;
- interfaces;
- physical realization;
- allocations;
- variants (when needed).

See [architecture](architecture.md) for responsibilities, interface contracts, allocations, and layer tailoring.

## Evaluate

Assess:

- assumptions;
- alternatives;
- risks;
- calculations / simulation results;
- trade-offs;
- decision rationale (`@DecisionRecord` — no approval `status` in the model; merge records acceptance).

See [architecture decisions](architecture.md#alternatives-and-decisions) for criteria, comparison, and rationale.

See also [evidence-and-claims.md](evidence-and-claims.md).

## Verify

Define and collect:

- verification cases;
- acceptance criteria;
- coverage of the increment’s question;
- evidence URIs;
- compliance or test results (as references, not bulk data in SysML).

See [verification](verification.md) for case definitions, observations, verdicts, evidence, and coverage.

## Evolve

Manage:

- PR review and merge;
- model follow-ups;
- baselines / tags;
- ownership (CODEOWNERS);
- residual risks and next increment question.

See [roles-and-reviews.md](roles-and-reviews.md) and [engineering-increments.md](engineering-increments.md).

## Lifecycle scope and feedback

During Frame, consider installation, operation, maintenance, recovery, upgrades, and disposal. Select the lifecycle activities relevant to the question and identify their stakeholders, enabling systems, needs, and interfaces. Record exclusions and conflicting needs. Describe the problem and desired outcome before committing to a solution; distinguish externally imposed design constraints from choices the team can reconsider.

During Verify, assess both requirement conformance and stakeholder outcomes using [verification and validation guidance](verification.md#stakeholder-validation). During Evolve, trace changed needs, requirements, observations, and assumptions to affected scenarios, decisions, allocations, analyses, and cases. Earlier evidence remains evidence for its recorded baseline; its applicability to a changed baseline requires review.

Use [stage readiness](stage-readiness.md) within increment reviews. These criteria guide the current scope and do not require completion of all stages in order. See the [change-impact walkthrough](../examples/guard-stop/README.md#change-impact-walkthrough).
