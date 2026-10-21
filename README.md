# Elan8 MBSE methodology

**Version 0.3.0 — in development.** A small set of SysML v2 modeling conventions: system-owned packages, recursive specification–architecture–integration, and useful views.

This revision prepares release 0.3.0, following the previously released 0.2.0 methodology.

Choose your own development workflow. Top-down, bottom-up, requirements-first, architecture exploration and question-driven increments can all use this methodology. There are no prescribed phases, gates, ceremonies or mandatory record forms.

## The core

- **Specification:** define what the system promises at its boundary.
- **Architecture:** specialize that specification and design with constituent subsystem contracts.
- **Integration:** specialize the chosen architecture and select compatible constituent designs through redefinition.
- Keep systems flat under `60_systems`; model relationships express composition.
- Use views to present existing content, rather than creating diagram-specific copies.

## Use it

Copy the [starter](templates/project-template/README.md), follow the [folder conventions](docs/structure.md), and apply the [recursive pattern](docs/recursive-pattern.md). The [four view recipes](docs/views.md) provide reusable GeneralView specializations, exact expose selections and filters.

The [elevator example](examples/elevator/README.md) demonstrates the pattern and views with synthetic timing values.

| Reference | Purpose |
|---|---|
| [Model checks](docs/quality-and-governance.md) | Short checks for meaningful, connected model content |
| [Choosing how to model](docs/workflow.md) | Optional starting points, including increments |
| [Library and tooling](docs/library-and-tooling.md) | Shared definitions, dependencies and validation |
| [Sources and terms](docs/sources-and-terms.md) | Language baseline and vocabulary |

The starter and example import `Elan8::SystemsEngineering` from the domain-library source. That addition has not been published as a release. Document generation needs its own library/generator binding.

The previous methodology remains in `BAK/`; the [original discussion](docs/design-discussion.md) is historical input.
