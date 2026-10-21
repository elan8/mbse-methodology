# Core principles

The Elan8 Method is guided by eight principles. They apply at every project size.

## 1. Model decisions, not documents

The model exists to support engineering decisions.

Documents, diagrams, dashboards, and tables are generated or curated views on the model.

## 2. Start with questions

Every modeling activity begins with an engineering question, concern, risk, or decision.

Examples:

- What must the system achieve?
- Which interfaces are critical?
- What happens when a sensor fails?
- Which architecture option best satisfies the key constraints?
- How will this requirement be verified?

## 3. Build vertical increments

Do not model all requirements first, then all behavior, then all architecture.

Work in traceable engineering increments that connect:

- stakeholder concern;
- scenario;
- requirement;
- architecture;
- analysis;
- verification;
- decision.

Scope each increment in Git/PR (and clear naming), not via process metadata on model elements.

## 4. Model only what creates value

Model detail is justified when it supports:

- communication;
- analysis;
- verification;
- reuse;
- impact assessment;
- automation;
- decision-making.

## 5. Prefer semantics over notation

The meaning of model elements and relationships is more important than diagram layout.

A diagram is one rendering of a model, not the model itself.

## 6. Automate model quality

Quality rules should be checked continuously where possible.

Examples:

- approved requirements have verification cases;
- public interfaces use defined item types;
- units are explicit;
- orphaned elements are reported;
- design decisions include rationale;
- physical elements trace to logical responsibilities.

## 7. Treat models as evolving engineering assets

Models should have:

- ownership;
- lifecycle status;
- version history;
- review workflows;
- releases and baselines;
- automated checks;
- change impact information.

Prefer Git and the hosting platform for review, ownership enforcement, and release tags. Put engineering meaning (roles, assumptions, decisions, evidence URIs) in the SysML model.

## 8. Keep humans accountable

AI may assist with generation, review, and analysis.

Critical requirements, assumptions, decisions, and verification claims must remain attributable to human owners and reviewers.
