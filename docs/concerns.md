# Six engineering concerns

The Elan8 Method is organized around six continuous engineering concerns.

These are **not** sequential lifecycle phases. They are perspectives that evolve together. An engineering increment typically touches several concerns in one coherent PR.

Annotate elements with `@EngineeringConcern` from `Elan8::Method::Core` when that helps navigation or views; do not require every element to carry a concern tag.

---

## Purpose

**Central question:** Why does the system exist?

Typical questions:

- Which stakeholder needs are relevant?
- What outcome must be achieved?
- What belongs inside and outside the system boundary?
- Which concerns and risks drive the design?
- How will success be measured?

Typical model content:

- stakeholders;
- concerns;
- system context;
- actors and external systems;
- top-level requirements;
- use cases;
- measures of effectiveness;
- scope and responsibility boundaries.

Expected outputs:

- system purpose;
- stakeholder map;
- system context;
- success criteria;
- top-level concerns;
- initial scope.

---

## Behavior

**Central question:** What must happen?

Typical questions:

- Which operational scenarios must be supported?
- Which functions or capabilities are required?
- Which items, energy, or information flow through the system?
- Which modes and states exist?
- What happens in exceptional or degraded conditions?

Typical model content:

- use cases;
- actions;
- action decomposition;
- states and transitions;
- successions;
- flows and messages;
- items;
- scenario-specific usages.

Expected outputs:

- key scenarios;
- system behavior;
- functional decomposition;
- state and mode models;
- exceptional behavior;
- interaction flows.

**Modeling note:** Prefer `action def` / `action` for functions. Do not invent a separate capability metamodel unless a project clearly needs one.

---

## Architecture

**Central question:** How are responsibilities organized and realized?

Typical questions:

- Which responsibilities must be allocated?
- Which logical building blocks are needed?
- Which interfaces must be stable?
- Which architecture alternatives exist?
- Which physical technologies realize the logical design?

Typical model content:

- part definitions and usages;
- ports;
- interfaces;
- connections;
- allocations;
- flows;
- logical architecture;
- physical architecture;
- variants and configurations.

Expected outputs:

- logical architecture (optional depth);
- interface architecture;
- physical architecture;
- allocation model;
- architecture alternatives;
- architecture decisions.

**Modeling note:** A parallel logical-part tree is optional. Allocation from behavior to parts is the required bridge. See [abstraction-levels.md](abstraction-levels.md).

---

## Evidence

**Central question:** Why do we believe the design will work?

Typical questions:

- Which assumptions underlie the design?
- Which properties must be calculated or simulated?
- Which alternatives were evaluated?
- Which risks remain?
- Which evidence supports the selected solution?

Typical model content:

- analysis cases;
- calculations;
- constraints;
- trade studies;
- measures of performance;
- risks;
- assumptions;
- rationale;
- decision metadata (`@DecisionRecord`, `@Assumption`, `@Risk`).

Expected outputs:

- executable or repeatable analyses;
- trade-off results;
- verified constraints;
- explicit assumptions;
- risk assessments;
- decision records.

---

## Verification

**Central question:** How will we demonstrate that the system is acceptable?

Typical questions:

- How will each critical requirement be verified?
- Which verification method is appropriate?
- At which level will verification occur?
- Which observations and pass criteria are required?
- Which coverage gaps remain?

Typical model content:

- verification cases;
- verification methods;
- requirement relationships;
- pass criteria;
- test configurations;
- evidence references (`VerificationEvidence`);
- verification results.

Expected outputs:

- verification strategy;
- requirement-to-verification traceability;
- verification cases;
- coverage metrics;
- verification gaps;
- readiness information.

---

## Evolution

**Central question:** How does the model remain trustworthy as the system evolves?

Typical questions:

- Who owns each model area?
- What changed and why?
- Which checks must pass?
- Which downstream artifacts are affected?
- Which elements are ready for release?
- Which assumptions have become invalid?

Typical mechanisms:

- Git commits and branches;
- pull requests;
- semantic model diff;
- model validation;
- ownership metadata (optional) and CODEOWNERS;
- lifecycle status (`StatusInfo`);
- issues and rationale;
- baselines and releases;
- impact analysis.

Expected outputs:

- reviewable changes;
- model quality reports;
- impact assessments;
- approved baselines;
- release evidence;
- generated artifacts.
