# Validation notes

Checked on 21 October 2026 with Spec42 0.56.0, the installed 2026-04 standard-library distribution (Kernel 1.0.0 / SysML 2.0.0), and the sibling domain-library source. Managed domain/method archives were disabled. Language reference: SysML v2.0 Part 1, formal/2026-03-02.

From the methodology root:

```powershell
./scripts/validate_models.ps1 `
  -Spec42 C:/Git/elan8/spec42/target/debug/spec42.exe `
  -StdlibPath C:/Users/jeroe/AppData/Local/Elan8/spec42/data/standard-library/versions/2026-04/kpar
```

Supply local paths as needed. `-DomainLibraryPath` defaults to the sibling library's `model/` root. The shared definitions are working-tree additions, not a published release.

## Language checks

| Workspace | Documents | Errors | Warnings |
|---|---:|---:|---:|
| Shared domain library | 36 | 0 | 0 |
| Starter | 7 | 0 | 4 |
| Elevator example | 9 | 0 | 4 |

The four consumer warnings are `view_type_non_standard`, one per Elan8 view type. SysML §7.26.2 permits specialized view definitions and inherited filters. Spec42 discovers them as general views and applies their filters; its warning classifier still flags their custom names.

## Prepared default views

| Example view | Nodes | Edges | Checked content |
|---|---:|---:|---|
| `ElevatorContext::context` | 2 | 0 | Referenced user/system; no view selecting itself |
| `Elevator::Views::specification` | 11 | 11 | Boundary definition, properties, behavior and requirement |
| `Elevator::Views::architecture` | 6 | 5 | Architecture definition, two contract-typed children, two ports and connection |
| `Elevator::Views::integration` | 6 | 5 | Selected usage, two design-typed children, two ports and connection |

The integration's panel is typed by `FastPanelArchitecture`. The structural filters exclude attribute/expression nodes. These counts describe the prepared projection, not physical product counts. Rendered layout has not been visually checked.

Earlier semantic checks confirmed the actual contract/architecture specialization chain, child redefinitions, resolved connection endpoints, satisfaction claim and verification objective. Local KPAR packaging was checked; the temporary archive was removed and no release published.

The timing arithmetic uses synthetic values: 40 + 120 = 160 ms. No physical test, verification execution or operational validation was performed. Explanatory timing/evidence tables are manually authored, not generated coverage reports.
