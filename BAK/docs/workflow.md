# Working on an engineering increment

Start with an engineering question, build the smallest connected model that answers it, and review the answer with its evidence and limitations. Repeat as questions and evidence evolve.

## 1. State the question

Write the decision or uncertainty, why it matters, the system boundary, relevant stakeholders, and what would count as a useful answer. Identify operating conditions, assumptions and exclusions. Distinguish stakeholder needs, supplied obligations and engineering interpretations. Consider relevant installation, operation, maintenance and recovery activities without modeling every lifecycle activity.

## 2. Develop the connected model

Change only the needs, requirements, scenarios, functions, architecture and analysis needed for the question. Follow significant nominal and degraded paths through responsibilities and interfaces. Use canonical requirements and native relationships; record consequential alternatives, assumptions and decisions. Select views that let reviewers follow the reasoning.

The [model areas](model-areas.md) organize this content. They are not sequential steps. A question may touch several areas; a separate logical architecture is useful only when it clarifies responsibilities or a design choice.

## 3. Evaluate and review

Check syntax, resolution and relevant semantic relationships. Compare predictions or observations with acceptance criteria, assess stakeholder outcomes, and distinguish planned checks from executed results. Record the answer, baseline, evidence limitations, residual risks and next question. Review through Git using the [increment checklist](increment-review.md).

When a need, requirement, assumption or observation changes, revisit affected scenarios, decisions, allocations, analyses and cases. Review whether earlier evidence applies to the changed baseline. See the [elevator increment](../examples/elevator/README.md#practical-increment-one-car-unavailable) and [change-impact walkthrough](../examples/elevator/README.md#change-impact-walkthrough).
