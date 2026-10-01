# Elan8 Method

[![License](https://img.shields.io/github/license/elan8/mbse-methodology)](LICENSE)

A lightweight, SysML v2-native methodology: **start with an engineering question, build the smallest connected model that answers it, and review the answer with its evidence and limitations.**

## Start with one useful question

For example: **“Can passenger service continue when one elevator is unavailable?”**

In the [two-elevator example](examples/elevator/README.md#practical-increment-one-car-unavailable), follow the continuity need and outage requirement through the isolation scenario, dispatch responsibility, availability interface and outage checks. Record what reduced service guarantees and what evidence is still missing. The question determines the work; filling folders is not the objective.

## Everyday working method

1. **State the question:** decision or uncertainty, scope, stakeholders, conditions and useful-answer criteria.
2. **Develop the connected model:** only the needs, requirements, scenarios, functions, architecture and analysis needed for that question.
3. **Evaluate and review:** check the model, assess evidence and stakeholder outcomes, record the answer and gaps, and review the change through Git.

This reviewable change is an [engineering increment](docs/engineering-increments.md), usually one pull request. Use the [working guidance](docs/workflow.md) and one [increment review checklist](docs/increment-review.md). Repeat as questions and evidence evolve.

## Six model areas for navigation

| Area | Question |
| --- | --- |
| Context | Why is the system needed, for whom, and within what boundary? |
| Use Cases | How do people and external systems interact with it? |
| Functions | What responsibilities must it perform? |
| Logical Architecture | How should responsibilities collaborate, when a separate logical structure helps? |
| Physical Architecture | What implements them? |
| Verification | How will we evaluate obligations and intended outcomes? |

These are [model areas](docs/model-areas.md), not sequential phases. Use separately, merge, or omit content with a short explanation when needed. Keep canonical needs and requirements together in `05_requirements`; analysis, views and local vocabulary support the areas that need them. Folder numbers provide browsing order. See [tailoring](docs/tailoring.md).

## Get started

1. Read the [elevator walkthrough](examples/elevator/README.md) and its practical increment.
2. Copy the [project template](templates/project-template/README.md).
3. State your first question and edit the relevant model content.
4. Validate relevant language and semantic relationships, then review with the increment checklist.

For notation, start with the [SysML v2 primer](docs/sysml-v2-primer.md). Read [requirements](docs/requirements.md), [behavior](docs/behavior.md), [architecture](docs/architecture.md) and [verification](docs/verification.md) when the question needs them.

## Keep the engineering meaning explicit

Distinguish stakeholder needs, supplied customer obligations and derived system requirements. Preserve source obligations and use adequate supplied requirements directly without duplication. Native short names identify requirements.

Derivation, allocation, satisfaction and verification express different relationships. Satisfaction is a design claim; a verification case is planned coverage; observations, evaluated verdicts and applicable evidence support a result. Validate intended stakeholder outcomes separately from requirement conformance.

Use native SysML v2 constructs. Views expose canonical model content. Consequential decisions, assumptions and risks belong in the model; increment identity, ownership and acceptance belong in Git/PR. Humans remain accountable for AI-assisted work.

## Repository and supporting guidance

- [docs/](docs/README.md): working steps, model areas, modeling guidance and supporting principles.
- [library/](library/README.md): small `Elan8Method` vocabulary for decisions, assumptions, risks, optional requirement roles, evidence references and viewpoints.
- [templates/project-template/](templates/project-template/README.md): reusable model layout.
- [examples/](examples/README.md): elevator model and focused SE pattern fixtures.
- `scripts/`: repository model and library maintenance checks.

Use the method library alongside matching standard SysML v2 libraries; examples require no external domain library or sibling repository. The method is tool-independent. Automated checks are useful where implemented, but successful parsing does not establish evidence validity or product fitness. See [quality rules](docs/quality-rules.md), [diagnostic expectations](docs/quality-diagnostic-contract.md) and [library migration](docs/library-migration.md).

For background, read [principles](docs/principles.md), [evidence and claims](docs/evidence-and-claims.md), [roles and reviews](docs/roles-and-reviews.md), [method comparisons](docs/method-mapping.md) and the [glossary](docs/glossary.md).

## License

MIT. See [LICENSE](LICENSE).
