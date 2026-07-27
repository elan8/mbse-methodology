# Elan8 Method project template

Copy this folder as the starting point for a new SysML v2 project.

## Layout

```text
model/
  00_project/     project metadata, tailoring, conventions
  10_purpose/     stakeholders, concerns, context, top-level needs
  20_behavior/    scenarios, actions, states
  30_architecture/ logical/physical structure, interfaces, allocations
  40_analysis/    analysis cases, assumptions, trade studies
  50_verification/ verification cases and coverage
  60_views/       stakeholder views
  90_library/     project-local reusable definitions
  Root.sysml      workspace import hub
```

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
3. Grow architecture, analysis, and verification as vertical increments.
