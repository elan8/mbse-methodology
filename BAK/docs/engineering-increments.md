# Engineering increments

An engineering increment is a reviewable model change that answers one engineering question or reduces a specific uncertainty. It is the everyday unit of work, usually one Git pull request.

Follow three steps: [state the question, develop the connected model, evaluate and review](workflow.md). Touch only the [model areas](model-areas.md) needed for the answer. An increment need not traverse every area or produce a complete product model.

## What belongs where

| Information | Home |
| --- | --- |
| Needs, requirements, scenarios, architecture, analysis, engineering decisions and assumptions | SysML model |
| Question, increment scope, review, ownership and acceptance | Git branch / PR / CODEOWNERS |
| Raw observations, logs and reports | Controlled external artifacts, referenced from relevant model cases |

Keep canonical requirements in `05_requirements`, with explicit source/derivation or rationale, subjects and acceptance conditions. Follow the question through scenarios, responsibility allocations, selected design and evidence. Use views to expose that content without copying it.

## Practical example

“Can passenger service continue with one car unavailable?” touches the elevator's continuity need, outage requirement, isolation scenario, dispatch responsibility, availability interface, selected controllers and outage checks. It does not require changing every timing target or creating another architecture layer. Follow the [file-by-file elevator increment](../examples/elevator/README.md#practical-increment-one-car-unavailable).

## Pull request

A useful PR description states:

1. The question and why it matters, including boundary and conditions.
2. The model changes and the answer or decision they support.
3. The checks and evidence, distinguishing predictions and plans from results.
4. Remaining assumptions, risks, gaps and the next question.

Use the single [increment review checklist](increment-review.md). Draft PRs can retain exploratory work; do not encode temporary approval or work-in-progress status as method metadata. A reviewed negative result can be a completed increment.

## Baselines and change

Record accepted baselines through Git history and tags/releases as appropriate. Evidence must identify the configuration and procedure it supports. When a requirement, assumption or implementation changes, trace affected model content and review evidence applicability before reusing it. See [evidence and claims](evidence-and-claims.md) and [roles and reviews](roles-and-reviews.md).
