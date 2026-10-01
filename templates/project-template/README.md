# Elan8 Method project template

Copy this folder as the starting point for a new SysML v2 project.

## Layout

```text
model/
  00_project/       project metadata, tailoring, conventions
  05_requirements/  stakeholder needs and canonical requirements at all levels
  10_context/       stakeholders, concerns, operational context
  20_usecases/      actor-facing use cases, operational scenarios
  30_capabilities/  mission-level capabilities realized by use cases
  40_functions/     system-level functional decomposition (black-box)
  50_logical/       logical responsibilities, collaborations, interfaces
  60_physical/      selected implementation baseline, physical allocations
  70_analysis/      analysis cases, assumptions, trade studies
  80_verification/  verification cases and coverage
  90_views/         stakeholder views
  99_library/       project-local reusable definitions
  Root.sysml        workspace import hub
```

The seven stage packages (`10_context` through `60_physical`, plus
`80_verification`) each carry a
`StageDisposition` metadata usage (`Elan8Method::MethodCore::StageDisposition`).
The fixed structure is always present; a project tailors *content*, not the
folder layout. If a stage genuinely doesn't apply (for example, `capabilities`
on a straightforward technical module), set `status = notApplicable` (or
`mergedIntoAnotherStage` with a `mergedInto` target) and give a `rationale` —
don't just leave the package empty. This keeps the shape consistent across
projects for review and automated tooling while still letting teams skip a
stage deliberately.

Requirements (`05_requirements`), analysis (`70_analysis`), views (`90_views`), project information, and local libraries support the stages; they are not additional engineering stages and do not carry `StageDisposition`.

## Requirements within the stages

Keep all canonical requirements in `05_requirements`. The template starts with `StakeholderNeeds.sysml` and `SystemRequirements.sysml`. Add `FunctionalRequirements.sysml`, `InterfaceRequirements.sysml`, and `ComponentRequirements.sysml` there when needed, and import their packages in `Root.sysml`. Stage packages reference requirements instead of copying them; requirement subjects identify the constrained elements wherever those elements live.

The number sets browsing order; Requirements is a supporting package, not an eighth stage. Tailoring stages does not move requirements out of this shared home. See [requirements guidance](../../docs/requirements.md).

## Library resolution

Load this model together with the repository's `library/` directory and standard SysML v2 libraries. When copying the template elsewhere, retain an explicit reference to the method-library source or a versioned archive through your modeling environment's configuration. No domain library or sibling checkout is required.

See [library/README.md](../../library/README.md).

## Next steps

1. Edit `00_project/Project.sysml` (name and notes), then choose a disposition for each stage.
2. Follow the [workflow guidance](../../docs/workflow.md) and [guard-stop walkthrough](../../examples/guard-stop/README.md).
3. Grow use cases, capabilities, functions, logical/physical architecture, and
   verification as vertical increments. Set `StageDisposition` to
   `notApplicable` or `mergedIntoAnotherStage` (with rationale) for any stage
   your project tailors away.
