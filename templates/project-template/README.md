# New Elan8 project

Create a complete standalone project with the methodology's `scripts/new_project.ps1 -Path /new/project`. This copies the template, frozen dependency, lock and validation helpers. Copying this directory alone copies only the model template.

Rename the `Product` package and all its qualified references across `model/` (including Root, Context and Documents), starting at `60_systems/Product/system.sysml`. Load the complete model tree and the frozen Elan8 dependency. The numbered folders organize content; choose your own development sequence.

Keep each system's contract, design, integration, behavior, analysis, verification and views together. Add developed subsystems as siblings under `60_systems`. Put stakeholder obligations in `20_requirements` and project-owned shared definitions in `50_library`.

Requirements alongside a BB need an explicit BB-local `satisfy` assertion to become inherited obligations. The methodology's requirement-binding recipe and interaction example demonstrate this. The system template contains a reminder instead of inventing product obligations.

Four default view types are supplied by the dependency. Add other views as needed. Document selections need a separate generator binding. Setup notes and record forms are optional.

From a scaffolded project root:

```powershell
./scripts/validate_models.ps1 -ModelPath ./model -Spec42 /path/to/spec42.exe -StdlibPath /path/to/stdlib/kpar
```

Validation verifies the frozen tool/library tuple. An explicit domain-library source override is a development choice. `Product::Integration::candidate` remains incomplete until you supply a contract and design; language validity alone does not complete it. Keep generated outputs outside `model/`.
