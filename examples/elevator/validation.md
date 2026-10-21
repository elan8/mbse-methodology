# Validation notes

The tested tuple is methodology 0.3.0, Spec42 0.56.0, standard-library distribution 2026-04 (Kernel 1.0.0 / SysML 2.0.0), and a frozen domain-library 0.5.0 candidate. Exact archive/source hashes are in `../../dependencies.lock.json`. The library candidate is not published.

Run from the methodology root:

```powershell
./scripts/validate_models.ps1 -Spec42 /path/to/spec42.exe -StdlibPath /path/to/stdlib/kpar
```

Default setup verifies versions/content and consumes the frozen KPAR. An explicit `-DomainLibraryPath` bypasses the frozen domain artifact for development; the standard-library/tool checks remain.

## Checked results

- Starter: 7 model documents, zero errors and four known custom-view-name warnings.
- Connected elevator example: 9 model documents, zero errors and the same four warnings.
- Tooling fixture: 1 model document, zero errors/warnings.
- Shared library: 36 model documents, zero errors/warnings.
- Reference checker: no structural definition findings for the elevator, including complete-selection mode.
- Executable rule tests: eight test methods pass against the frozen artifact, exercising 21 named cases in default, completeness and optional-style modes plus input/export, view-filter and interaction-semantics regressions.
- Standalone scaffold: copied model, frozen artifact, lock and validation helpers successfully validate without the source checkout.

Spec42 0.56.0 warns `view_type_non_standard` on the four Elan8 view names despite discovering/preparing their GeneralView specializations. No warning suppression is applied.

## Semantic inspection and limits

The native export resolves the BB-local satisfaction assertion to the authoritative timing requirement and records its owning specification. Implicit-self binding is defined by SysML §7.21.4; the export does not materialize a separate authored `satisfyTarget` edge for that implicit target. The assertion is inherited through the actual project specialization chain.

The GB action redefines the BB behavior. Three allocations connect forward/present to the panel and register to the controller. Port/action bindings, boundary delegation, request/response flows and ordered subactions are modeled explicitly. The WB retains inherited identities while selecting the fast panel and controller.

View counts and source identities change as the connected example develops; inspect semantic contents rather than treating historical counts as acceptance criteria. Prepared projections are checked for resolved endpoints and selected types. Rendered diagram layout is not certified by these checks.

Current prepared defaults: context 7 nodes / 4 edges; specification 61 / 63; architecture 23 / 22; integration 23 / 22, with zero unresolved node typings. Integration selects FastPanelArchitecture and ControllerArchitecture. The semantic model contains three allocations, sixteen bindings, six flows and two successions. These are model/projection counts, not test results or physical component counts.

The checker assesses structural definitions and nested selections. Root usage-local overrides, contextual constraint evaluation, behavior/port compatibility and evidence are not assessed by that checker. Its coverage report states these limits.

The 160 ms result is synthetic arithmetic under explicit assumptions. No physical timing test, verification execution or operational validation has been performed.
