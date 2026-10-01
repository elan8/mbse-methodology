# Tailoring per stage

Choose which stages add engineering value and how much detail each needs. There is no project-wide profile or size classification. A project can need detailed verification and physical interfaces while deliberately merging its logical architecture into its physical baseline.

## Stage choices

Record one `StageDisposition` on each of the seven stage packages:

| Status | Meaning | Required explanation |
| --- | --- | --- |
| `applicable` | This stage has a distinct engineering purpose in the project | State its scope and choose content depth to match the current question |
| `notApplicable` | This stage does not apply to this project's scope | Give the reason; an empty draft stage is not automatically inapplicable |
| `mergedIntoAnotherStage` | Another stage carries the relevant content | Identify `mergedInto` and explain why separate content would duplicate it |

The template retains the seven package locations for navigation. Users choose whether each stage is used separately, omitted in content, or represented within another stage. Folder presence does not require a separate model layer or a populated duplicate architecture.

Requirements remain together in `05_requirements`; their subjects reference the applicable system, behavior, or architecture elements. Supporting analysis, views, and local vocabulary are developed only as needed. `ProjectInfo` contains the project name and notes; it does not select a tailoring preset.

## Choose depth independently

For each stage, ask what decision it supports, what risk would remain without it, and what minimum model content and evidence answer the current engineering question.

Start with the engineering question and the worked example and add interfaces, quantitative analysis, degraded scenarios, configuration management, or richer views when the question requires them. Assurance and regulatory obligations may require additional evidence and review regardless of which architecture stages are merged.

Do not infer low criticality from a small model or an omitted layer. Stage tailoring does not waive verification of critical requirements, invalidate subjects, or remove needed responsibility and interface relationships.

## Example

The [guard-stop example](../examples/guard-stop/README.md) uses Context, Use Cases, Functions, Physical, and Verification. Capabilities and Logical Architecture are explicitly merged into Physical with separate rationales. The project has no global profile.

Record engineering tailoring in the model; keep review, ownership, and acceptance of increments in Git and repository workflows.
