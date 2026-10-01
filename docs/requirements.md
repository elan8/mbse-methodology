# Requirements across the method

Requirements connect stakeholder intent to the behavior and architecture that must meet it, and to the evidence used to judge the result. They evolve within engineering increments across all seven stages. They are not a separate sequential stage.

## Where requirements live

All canonical requirements live in `model/05_requirements`. This supporting folder is not an eighth stage and carries no `StageDisposition`; its number sets browsing order rather than process sequence.

| File | Content | Stages that develop or reference it |
| --- | --- | --- |
| `StakeholderNeeds.sysml` | Stakeholder needs and desired outcomes | Context, Use Cases, Capabilities |
| `SystemRequirements.sysml` | System-boundary obligations and constraints | Context, Use Cases, Capabilities, Verification |
| `FunctionalRequirements.sysml` (when needed) | Required behavior and functional performance | Functions, Logical, Physical, Verification |
| `InterfaceRequirements.sysml` (when needed) | External, logical, and physical interface contracts | Context, Logical, Physical, Verification |
| `ComponentRequirements.sysml` (when needed) | Obligations allocated or derived for implementation elements | Physical, Verification |

The template starts with the first two files; add the others when needed and import their packages in `Root.sysml`. Keep one canonical requirement usage for each obligation. Its subject references the constrained system, function, interface, or component in the relevant stage package. Scenarios clarify requirements, architecture records satisfaction claims, and verification cases reference the same canonical requirements. Folder ownership does not change subject ownership.

Tailoring or merging stages leaves requirements in this shared home and preserves their traceability to the applicable subjects. Split requirements further within this folder only when it improves review; avoid duplicate usages for the same obligation.

Requirements are not limited to functional behavior: safety, security, performance, interfaces, regulatory constraints, and other qualities can apply at any appropriate level. `RequirementRole` describes the engineering role, not folder ownership; a safety requirement may constrain the whole system or one component.

## The traceability chain

For a cliff-safe-stop increment:

1. The shared requirements folder captures the stakeholder need for safe unattended operation and a measurable system obligation to stop after cliff detection.
2. Use Cases describes detecting a stair edge, stopping, and reporting status; it exposes nominal and failure conditions that inform the requirements.
3. Functional decomposition informs detection and stopping obligations derived in the shared requirements folder from the system requirement.
4. Logical and Physical identify responsible elements and record satisfaction claims and behavior allocations.
5. Analysis evaluates assumptions and reaction-time budgets.
6. Verification defines cases, acceptance criteria, and evidence references for the system and relevant derived requirements.

Use explicit derivation relationships between source and derived requirements. `satisfy` records a design claim; `allocate` assigns responsibility; a verification case's `verify` objective identifies the obligation evaluated. These relationships serve different purposes. A satisfaction claim or a linked verification case alone does not demonstrate a passing result: review the actual evidence and its applicable baseline.

## Modeling and review

Use native SysML v2 `requirement` definitions/usages. The method library adds optional role and stable identity metadata; verification evidence vocabulary lives separately in `Elan8Method::Verification`. It does not replace native requirements with custom requirement classes.

For each requirement in an increment, review:

- the source need, derivation, or explicit rationale;
- its subject and boundary, including applicable assumptions;
- testable acceptance criteria, with quantities and units where measurable;
- responsible design elements and relevant satisfaction/allocation links;
- verification method, acceptance criteria, coverage, and evidence for critical obligations;
- stable identity where needed, ownership, and the baseline being reviewed.

Use Git review and merge for acceptance of an engineering increment. Product lifecycle metadata may be used with project-defined meaning; it does not replace review or evidence. The [quality rules](quality-rules.md) distinguish automated checks from manual checklists and diagnostics that are only contracted.

Start with [derive system requirements](../recipes/derive-system-requirements.md), then [define requirement verification](../recipes/define-requirement-verification.md). Use [engineering increments](engineering-increments.md) to keep the chain coherent as requirements change.
