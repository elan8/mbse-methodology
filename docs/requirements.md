# Requirements across the method

Requirements connect stakeholder intent to the behavior and architecture that must meet it, and to the evidence used to judge the result. They evolve within engineering increments across all six model areas. They are not a separate sequential activity.

## Where requirements live

All canonical requirements live in `model/05_requirements`. This supporting folder keeps obligations canonical; its number sets browsing order rather than process sequence.

| File | Content | Areas that develop or reference it |
| --- | --- | --- |
| `StakeholderNeeds.sysml` | Stakeholder needs and desired outcomes | Context, Use Cases |
| `StakeholderRequirements.sysml` (when needed) | Customer/stakeholder-supplied or agreed obligations, including contractual constraints | Context, Use Cases, Verification |
| `SystemRequirements.sysml` | System-boundary obligations and constraints | Context, Use Cases, Verification |
| `FunctionalRequirements.sysml` (when needed) | Required behavior and functional performance | Functions, Logical, Physical, Verification |
| `InterfaceRequirements.sysml` (when needed) | External, logical, and physical interface contracts | Context, Logical, Physical, Verification |
| `ComponentRequirements.sysml` (when needed) | Obligations allocated or derived for implementation elements | Physical, Verification |

The template includes needs and system requirements plus an optional stakeholder-requirements placeholder. Remove the optional file and its `Root.sysml` import if there are no separate supplied or agreed obligations. Add functional, interface, and component files when needed and import their packages in `Root.sysml`. Keep one canonical requirement usage for each obligation. Its subject references the constrained system, function, interface, or component in the relevant model-area package. Scenarios clarify requirements, architecture records satisfaction claims, and verification cases reference the same canonical requirements. Folder ownership does not change subject ownership.

Tailoring or merging areas leaves requirements in this shared home and preserves their traceability to the applicable subjects. Split requirements further within this folder only when it improves review; avoid duplicate usages for the same obligation.

Requirements are not limited to functional behavior: safety, security, performance, interfaces, regulatory constraints, and other qualities can apply at any appropriate level. `RequirementRole` describes the engineering role, not folder ownership; a safety requirement may constrain the whole system or one component.

## Needs, stakeholder requirements, and system requirements

These are engineering roles, not a ranking of precision or mandatory steps in a chain.

| Role | Meaning | Elevator illustration |
| --- | --- | --- |
| Stakeholder need | Desired outcome in the stakeholder's operating or lifecycle context | The operator needs safe access for maintenance. |
| Customer/stakeholder requirement | An obligation supplied or agreed by a stakeholder; it may be contractual | The machine shall prevent hazardous motion while the access guard is open. |
| System requirement | An engineering obligation on the system of interest, with explicit subject, conditions, and acceptance criteria | The controller shall remove drive enable within 200 ms after guard opening. |

Customer requirements are stakeholder requirements from a particular source. They may already be precise, or prescribe technology, interfaces, or regulatory constraints. Do not assume they are informal needs or silently replace them with an engineering interpretation. The examples above illustrate distinct scopes; the controller timing obligation alone does not establish compliance with the machine-level obligation.

Use native requirement definitions/usages and short names. File placement and documentation distinguish these roles; no custom requirement class is required. Existing optional `RequirementRole` metadata does not encode contractual status or source ownership: `user` alone cannot distinguish a need from a stakeholder requirement. Do not infer those meanings from that tag.

### Handling supplied obligations

1. Preserve the supplied wording and identifier, source document/revision or reference, and applicable contractual status where relevant. Use documentation or a source artifact reference; keep contractual interpretation and agreement records in the project's controlled documents and review process.
2. Analyze ambiguity, conflicts, feasibility, applicability, and system boundary with the relevant stakeholder. Record clarifications, dispositions, and agreed changes rather than editing the original meaning without explanation.
3. Derive system obligations explicitly where interpretation or decomposition is required. Record derivation, assumptions, and rationale. The relationships may be many-to-many: one stakeholder obligation may require several system obligations, and one system obligation may address several sources.
4. If a supplied requirement already constrains the system adequately, use that canonical requirement directly from its stakeholder-requirements home. Reference it from architecture and verification; do not create a second usage merely to populate `SystemRequirements.sysml` or connect it to itself through derivation.
5. Review coverage in both directions. Every applicable stakeholder obligation has an engineering response or explicit unresolved gap; excluded or superseded obligations have a reviewed disposition. Every system obligation has a source or justified rationale, including obligations derived from analysis or design decisions.

A derivation relationship records the engineering interpretation; it is not proof that satisfying the derived requirements fulfills the source obligation. Review completeness and the assumptions connecting their subjects and acceptance criteria.

### Verification and stakeholder validation

Verify both stakeholder requirements and system requirements against their stated criteria at the appropriate boundary. A contractual machine-level requirement may need machine-level evidence even when component requirements pass. Validate the resulting system against stakeholder needs and intended use. Requirement source does not determine whether verification is needed.

Keep plans and evidence in `80_verification`, referencing the canonical obligations and needs. See [verification and validation](verification.md#stakeholder-validation).

## The traceability chain

For a passenger-journey increment:

1. The shared requirements folder captures predictable travel needs, the supplied waiting-time target, and derived registration obligations.
2. Use Cases describes request registration, dispatch, travel, and door operation; selected degraded paths inform additional obligations.
3. Functions identifies responsibilities that contribute to those obligations.
4. Logical and Physical allocate responsibilities and realization, and record satisfaction claims.
5. Analysis evaluates assumptions, waiting estimates, and response budgets.
6. Verification evaluates canonical obligations and plans stakeholder validation, retaining evidence and baseline limitations.

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

Use Git review and merge for acceptance of an engineering increment. Product lifecycle metadata may be used with project-defined meaning; it does not replace review or evidence. The [rule catalog](quality-rules.md) separates deterministic semantic checks, wording cues, hybrid checks and engineering judgment; its implementation status is explicit.

Read [verification guidance](verification.md) and the [elevator walkthrough](../examples/elevator/README.md). Use [engineering increments](engineering-increments.md) to keep the chain coherent as requirements change.

## Requirement identifiers

Use the native SysML short name for the identifier, for example `requirement <'SYS-001'> removeDriveEnable`. The full name describes the obligation; the short name supports specification tables, reviews, and external references. Keep names and short names distinguishable within their namespace. For cross-project references, include the qualified namespace and applicable baseline: a short name is not a globally unique identifier. Do not duplicate it in identity metadata.

## Derivation and acceptance criteria

Separate stakeholder needs from system obligations. Identify the stakeholder and frame the relevant concern; give system requirements an explicit subject. Derive testable obligations from needs, scenarios, operating conditions, and design limits. Record a native derivation connection or explicit rationale rather than relying on folder placement.

For quantitative obligations, define the measured property, quantity type, unit, limit, and whether the boundary is inclusive. Use ISQ/SI types, identify assumptions, and specify the conditions under which acceptance is evaluated. The [elevator requirements](../examples/elevator/model/05_requirements/SystemRequirements.sysml) derive registration, obstruction-response, and outage obligations from canonical stakeholder needs, with inclusive timing limits. Plan verification when deriving a critical obligation.

## Subjects and satisfaction

A satisfying element must conform to the requirement subject's type. Keep a reusable requirement subject typed but unbound when different design or verification contexts must supply their own subject. A fixed binding value on that subject cannot be overridden by a satisfaction claim. Use fixed instance bindings only when the requirement deliberately constrains that exact instance.

A use case whose subject is an elevator service is not itself an elevator service. Frame the motivating concern in the use-case objective instead of claiming that the use case satisfies a requirement with an ElevatorService subject. The [elevator example](../examples/elevator/README.md) illustrates the distinction.

## Requirement quality and review

Use the [INCOSE-referenced rule catalog](quality-rules.md#relationship-to-incose-guidance) to review both individual obligations and the requirement set. Check source fidelity, appropriate scope, clear conditions and practical evaluation; then review set-level gaps and stakeholder outcomes. A typed subject, populated constraint or source link is useful structural evidence, not proof that the obligation is necessary, complete or feasible.

Review the human-language statement together with its formal constraint, subject, units, assumptions and referenced conditions. Avoid applying prose-writing rules mechanically to SysML expressions or splitting one bounded obligation merely because it contains a conjunction. Optional LLM assistance can suggest clarification; accountable engineering review determines adequacy. See [implementation guidance](quality-diagnostic-contract.md#text-cues-and-optional-llm-assisted-review).
