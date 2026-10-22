# Library and tooling

The shared package `Elan8::SystemsEngineering` provides independent BB/GB/WB roles and four filtered GeneralView specializations. [View recipes](views.md) and [structural rules](tooling-rules.md) define their use. Native SysML handles requirements, behavior, ports, allocations and verification.

## Tested dependency tuple

The [lock file](../dependencies.lock.json) records methodology **0.5.0**, Spec42 **0.56.0**, standard-library distribution **2026-04**, and a frozen **domain-library 0.5.0 release candidate**. The candidate is bundled in `libraries/`; it has not been published. Archive/source SHA-256 digests identify the exact tested content.

Default setup verifies the CLI version, standard-library source digest, domain archive checksum and extracted source digest. A mutable sibling checkout is no longer required. `-DomainLibraryPath` explicitly opts into a development override.

```powershell
./scripts/validate_models.ps1 -Spec42 /path/to/spec42.exe -StdlibPath /path/to/stdlib/kpar
```

This checks the starter, interaction example and language-valid diagnostic fixtures. The existing custom-view-name warnings in Spec42 0.56.0 remain documented in the [validation notes](../examples/elevator/validation.md).

For diagram preparation and the view-dependent executable tests, use the separate
`diagramRenderer.sourceCommit` in the lock file. Build that Spec42 source revision
with `cargo build -p server --bin spec42`. The development build also reports
0.56.0, but includes inherited-view discovery and Boolean filters missing from
the released binary. Language validation above uses the released tool. No library
archive or standard-library content changes for this namespace simplification.

## Structural checker

Prepare the frozen library once and export the subject workspace:

```powershell
$domain = ./scripts/prepare_dependencies.ps1 -Spec42 /path/to/spec42.exe -StdlibPath /path/to/stdlib/kpar
spec42 --disable-kpar-library domain --disable-kpar-library method `
  --stdlib-path /path/to/stdlib/kpar --library-path $domain `
  model-export ./examples/elevator/model --format json > model.json
python ./scripts/check_structure.py model.json --complete-selection
```

The executable must be the same pinned version. The checker accepts a complete native export; it does not parse source text. Exit code 1 means structural errors; 2 means unusable input. Reports distinguish unresolved dependencies and unassessed capabilities.

Run executable expectations (Python 3.10+):

```powershell
python ./scripts/test_structure.py --spec42 /path/to/spec42.exe `
  --stdlib-path /path/to/stdlib/kpar --domain-library-path $domain
```

The intentionally invalid method examples should produce expected findings, not a clean checker verdict. Language validity, structural checks, contextual constraint analysis and verification are separate claims.

Methodology 0.5.0 keeps direct ownership and permits ordinary typed leaf parts
without system-role adapters. Structural catalog 0.4.0 distinguishes those leaves
from developed subsystem contracts; untyped parts, bare markers and unmarked
composites remain invalid. Tests cover direct/grouped ownership, ordinary leaf
inheritance and refinement, nested selection, hidden composition and view scope.

## New projects and documents

`scripts/new_project.ps1 -Path /new/project` copies the starter, frozen dependency, lock and validation helpers. Validate the new project with `-ModelPath ./model`. Existing target directories are never overwritten.

Document selections in `80_documents` need a separate document-library/generator binding before CRS/SRS/SDS generation. That optional publishing capability is outside the frozen method-role dependency.
