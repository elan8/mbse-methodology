# Library and tooling

The domain-library source exports `Elan8::SystemsEngineering`:

- `SystemSpecification`, `SystemArchitecture`, `SystemIntegration`: abstract modeling roles.
- `ContextView`, `SpecificationView`, `ArchitectureView`, `IntegrationView`: filtered specializations of `StandardViewDefinitions::GeneralView`.

These are Elan8 library definitions. Requirements, behavior, ports, allocation and verification use native SysML v2 constructs. See the [view recipes](views.md) for the actual definitions and usage examples.

The starter and example use the shared definitions without local copies. The additions are in the domain-library working tree, not a published release. Pin the source revision/local changes or a released artifact containing them.

## Validate

From the methodology root:

```powershell
./scripts/validate_models.ps1 -Spec42 /path/to/spec42.exe
```

The script defaults to the sibling `sysml-domain-libraries/model` dependency. Use `-DomainLibraryPath` for another source or extracted library root, and `-StdlibPath` when standard-library discovery needs an explicit path. Managed domain/method archives are disabled to prevent duplicate definitions.

Check language validity, then inspect the important semantic relationships and prepared views. Layout and engineering correctness need their own inspection. The script does not execute verification cases or enforce a project workflow.

Document definitions in `80_documents` need a separate pinned document library/generator before CRS/SRS/SDS generation. Content-selection views are not complete document templates.

See the [validation notes](../examples/elevator/validation.md) for the checked environment and limitations.
