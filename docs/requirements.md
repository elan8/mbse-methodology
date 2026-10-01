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

Use native SysML v2 `requirement` definitions/usages. The method library adds optional role metadata; requirement identifiers use native short names; verification evidence vocabulary lives separately in `Elan8Method::Verification`. It does not replace native requirements with custom requirement classes.

For each requirement in an increment, review:

- the source need, derivation, or explicit rationale;
- its subject and boundary, including applicable assumptions;
- testable acceptance criteria, with quantities and units where measurable;
- responsible design elements and relevant satisfaction/allocation links;
- verification method, acceptance criteria, coverage, and evidence for critical obligations;
- native short names where needed, ownership, and the baseline being reviewed.

Use Git review and merge for acceptance of an engineering increment. Product lifecycle metadata may be used with project-defined meaning; it does not replace review or evidence. The [quality rules](quality-rules.md) distinguish automated checks from manual checklists and diagnostics that are only contracted.

Read [verification guidance](verification.md) and the [guard-stop walkthrough](../examples/guard-stop/README.md). Use [engineering increments](engineering-increments.md) to keep the chain coherent as requirements change.

## Requirement identifiers

Use the native SysML short name for the identifier, for example `requirement <'SYS-001'> removeDriveEnable`. The full name describes the obligation; the short name supports specification tables, reviews, and external references. Keep names and short names distinguishable within their namespace. For cross-project references, include the qualified namespace and applicable baseline: a short name is not a globally unique identifier. Do not duplicate it in identity metadata.

## Derivation and acceptance criteria

Separate stakeholder needs from system obligations. Identify the stakeholder and frame the relevant concern; give system requirements an explicit subject. Derive testable obligations from needs, scenarios, operating conditions, and design limits. Record a native derivation connection or explicit rationale rather than relying on folder placement.

For quantitative obligations, define the measured property, quantity type, unit, limit, and whether the boundary is inclusive. Use ISQ/SI types, identify assumptions, and specify the conditions under which acceptance is evaluated. The [guard-stop requirements](../examples/guard-stop/model/05_requirements/Requirements.sysml) show one need, a derived system obligation, and an inclusive timing constraint. Plan verification when deriving a critical obligation.

## Subjects and satisfaction

A satisfying element must conform to the requirement subject's type. Keep a reusable requirement subject typed but unbound when different design or verification contexts must supply their own subject. A fixed binding value on that subject cannot be overridden by a satisfaction claim. Use fixed instance bindings only when the requirement deliberately constrains that exact instance.

A use case whose subject is a controller is not itself a controller. Frame the motivating concern in the use-case objective instead of claiming that the use case satisfies a requirement with a Controller subject. The [guard-stop example](../examples/guard-stop/README.md) illustrates the distinction.
