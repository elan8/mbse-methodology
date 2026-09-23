# Elan8 Method project template

Copy this folder as the starting point for a new SysML v2 project.

## Layout

```text
model/
  00_project/       project metadata, tailoring, conventions
  10_context/       stakeholders, concerns, operational context, top-level needs
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

Every stage package from `10_context` through `80_verification` carries a
`StageDisposition` metadata usage (`Elan8::Method::Core::StageDisposition`).
The fixed structure is always present; a project tailors *content*, not the
folder layout. If a stage genuinely doesn't apply (for example, `capabilities`
on a straightforward technical module), set `status = notApplicable` (or
`mergedIntoAnotherStage` with a `mergedInto` target) and give a `rationale` —
don't just leave the package empty. This keeps the shape consistent across
projects for review and automated tooling while still letting teams skip a
stage deliberately.

## Spec42 library paths

From a sibling checkout:

```powershell
spec42 --library-path ..\..\..\library `
       --library-path ..\..\..\..\sysml-domain-libraries\domain `
       --library-path ..\..\..\..\sysml-domain-libraries\technical `
       --library-path ..\..\..\..\sysml-domain-libraries\generic `
       check .
```

Adjust relative paths to your workspace. See [library/README.md](../../library/README.md).

## Next steps

1. Edit `00_project/Project.sysml` (name, tailoring profile).
2. Follow recipes: purpose → context → concerns → scenario → requirements.
3. Grow use cases, capabilities, functions, logical/physical architecture, and
   verification as vertical increments. Set `StageDisposition` to
   `notApplicable` or `mergedIntoAnotherStage` (with rationale) for any stage
   your project tailors away.
