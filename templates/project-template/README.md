# Elan8 Method project template

Copy this folder as the starting point for a new SysML v2 project.

## Layout

```text
model/
  00_project/       project metadata, tailoring, conventions
  05_requirements/  stakeholder needs and canonical requirements at all levels
  10_context/       stakeholders, concerns, operational context
  20_usecases/      actor-facing use cases, operational scenarios
  40_functions/     system-level functional decomposition (black-box)
  50_logical/       logical responsibilities, collaborations, interfaces
  60_physical/      selected implementation baseline, physical allocations
  70_analysis/      analysis cases, assumptions, trade studies
  80_verification/  verification, validation, evidence, and coverage
  90_views/         stakeholder views
  99_library/       project-local reusable definitions
  Root.sysml        workspace import hub
```

The six model areas are navigation locations, not sequential steps. Use each separately, merge useful content into another area, or omit content when it adds no value. Explain intentional merges or omissions in package documentation or project notes; no tailoring metadata is required. The folders can remain as placeholders without duplicating model content.

Requirements, analysis, views, project information and local vocabulary support the areas that need them. See [model areas](../../docs/model-areas.md) and [tailoring](../../docs/tailoring.md).

## Requirements within the model areas

Keep all canonical requirements in `05_requirements`. The template starts with `StakeholderNeeds.sysml` and `SystemRequirements.sysml`, and includes an optional `StakeholderRequirements.sysml` placeholder for supplied or agreed obligations. If it is not needed, remove that file and its import from `Root.sysml`. Add `FunctionalRequirements.sysml`, `InterfaceRequirements.sysml`, and `ComponentRequirements.sysml` there when needed, and import their packages in `Root.sysml`. Model-area packages reference requirements instead of copying them; requirement subjects identify the constrained elements wherever those elements live.

The number sets browsing order; Requirements is a supporting package, not an additional model area. Tailoring areas does not move requirements out of this shared home. See [requirements guidance](../../docs/requirements.md).

## Library resolution

Load this model together with the repository's `library/` directory and standard SysML v2 libraries. When copying the template elsewhere, retain an explicit reference to the method-library source or a versioned archive through your modeling environment's configuration. No domain library or sibling checkout is required.

See [library/README.md](../../library/README.md).

## Work on an increment

1. State an engineering question, scope and useful-answer criteria in a PR or working note.
2. Develop the connected model in the areas needed for the answer; update `00_project/Project.sysml` with the project name and relevant notes.
3. Evaluate the answer and review the change using the [increment checklist](../../docs/increment-review.md).

Follow the [working steps](../../docs/workflow.md) and [elevator example](../../examples/elevator/README.md#practical-increment-one-car-unavailable). Keep verification and stakeholder validation alongside each other in `80_verification`, referencing canonical needs and requirements. Review evidence applicability when the baseline changes.

## Supplied and derived requirements

Preserve customer/stakeholder obligations, their source references and revisions, and relevant contractual status in `StakeholderRequirements.sysml`. Derive engineering obligations into `SystemRequirements.sysml` when interpretation or decomposition is needed. If a supplied requirement already constrains the system adequately, reference it directly without copying it into the system file. Verify obligations at their applicable boundary and validate stakeholder outcomes separately. See [requirements roles and source handling](../../docs/requirements.md#needs-stakeholder-requirements-and-system-requirements).
