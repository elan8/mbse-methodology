# Four practical views

Use these defaults when they help. There is no required view checklist. Behavior, verification, budgets and reports can use additional standard SysML views or project tooling as needed.

| View type | Show | Expose |
|---|---|---|
| `ContextView` | System boundary and external participant usages, ports and connections | Context package members |
| `SpecificationView` | Boundary contract, behavior, properties, requirements and constraints | Contract definition and named requirement/behavior content |
| `ArchitectureView` | Architecture with child contract usages, ports and topology | Chosen architecture definition |
| `IntegrationView` | Selected configuration with effective child designs, ports and topology | Selected integration usage |

## Reusable definitions and filters

The domain library provides these types in `Elan8::SystemsEngineering`. They specialize the standard `GeneralView`; their filters are inherited by each usage. These are the implemented definitions:

```sysml
view def ContextView :> StandardViewDefinitions::GeneralView {
    doc /* Expose the context package: system and external participant usages,
         * their ports and connections. Referenced participants stay external. */
    filter @SysML::PartUsage or @SysML::PortUsage or @SysML::ConnectionUsage
        or @SysML::BindingConnectorAsUsage or @SysML::FlowUsage;
    filter not @SysML::ViewUsage;
}

view def SpecificationView :> StandardViewDefinitions::GeneralView {
    doc /* Expose a specification package: boundary definition, features,
         * requirements and constraints. Expressions remain in the model. */
    filter @SysML::Definition or @SysML::Usage;
    filter not @SysML::ViewUsage;
}

view def ArchitectureView :> StandardViewDefinitions::GeneralView {
    doc /* Expose an architecture definition: constituent contract usages,
         * ports and topology. Behavior can use a separate standard view. */
    filter @SysML::PartDefinition or @SysML::PartUsage
        or @SysML::PortUsage or @SysML::ConnectionUsage
        or @SysML::BindingConnectorAsUsage or @SysML::FlowUsage;
    filter not @SysML::ViewUsage;
}

view def IntegrationView :> StandardViewDefinitions::GeneralView {
    doc /* Expose a selected integration usage: effective constituent designs,
         * ports and topology. This view is not a compatibility assessment. */
    filter @SysML::PartUsage or @SysML::PortUsage or @SysML::ConnectionUsage
        or @SysML::BindingConnectorAsUsage or @SysML::FlowUsage;
    filter not @SysML::ViewUsage;
}
```

The specification filter retains definitions and usages because a contract can contain different kinds of boundary information. The structural filters deliberately omit behavior/analysis details. Bindings and flows remain eligible alongside connections: these relationships have different meanings. The second filter excludes view usages, including the context view itself.

Each `filter` is a condition that must hold; alternatives within one condition use `or`. Further filters narrow inherited selection. To broaden a filter, change the definition or create another specialization of `GeneralView`; adding a second filter does not form a union.

## Copyable view usages

The [starter](../templates/project-template/README.md) already contains these selections. Replace `Product` and the selected configuration name for your system.

Context, in `00_context/Context.sysml`:

```sysml
view context : Elan8::SystemsEngineering::ContextView {
    expose ProjectContext::**;
}
```

Use `ref part` for external participants and the referenced system of interest. Add the relevant ports/exchanges to the context model; a view cannot invent missing interfaces.

System views, inside `Product::Views`:

```sysml
private import Elan8::SystemsEngineering::*;

view specification : SpecificationView {
    expose Product::ProductSpecification;
    expose Product::Requirements::**;
}
view architecture : ArchitectureView {
    expose Product::ProductArchitecture;
}
view integration : IntegrationView {
    expose Product::candidate;
}
```

With direct system ownership, select the contract and its authoritative requirements explicitly. Avoid `expose Product::**` in a specification view: that would also select architectures and integrations. If a project chooses optional role packages, package-wide selections remain useful.

`expose X;` selects a named root. `X::*` selects direct members; `X::**` recursively selects members. Structure renderers expand the selected root's effective features to a chosen depth. The architecture definition shows contract-typed children; the integration usage shows selected designs in context. Do not expose every alternative when displaying one configuration.

To narrow a view to parts only:

```sysml
view partsOnly : IntegrationView {
    expose Product::candidate;
    filter @SysML::PartUsage;
    filter not @SysML::ConnectionUsage;
}
```

This excludes ports and connection elements; it is an optional variation, not a fifth default. To create a different recipe directly:

```sysml
view def PartsView :> StandardViewDefinitions::GeneralView {
    filter @SysML::PartUsage;
    filter not @SysML::ConnectionUsage;
    filter not @SysML::ViewUsage;
}
```

## Check the result

Inspect the exposed roots, selected kinds, inherited children and connection endpoints before judging layout. Start at one decomposition level and increase depth only when useful. In Spec42:

```powershell
spec42 diagram ./model --view Product::Views::integration --format json
spec42 diagram ./model --view Product::Views::integration --depth 1 -o integration.svg
```

Use the same library arguments as validation; see [tooling](library-and-tooling.md). A general view is not a coverage/evidence matrix or a compatibility proof. Document content selections in `80_documents` are separate publishing inputs.

Language reference: SysML v2.0 Part 1 §7.26.2 specifies view-definition filters and their inheritance; `StandardViewDefinitions::GeneralView` supplies the standard general view type. Released Spec42 0.56.0 emits `view_type_non_standard` warnings and cannot discover derived GeneralView types or prepare Boolean filters. Use the separate rendering source revision in [the lock file](../dependencies.lock.json) for prepared diagrams. These tool limitations do not make specialization invalid; no model rewrite or warning suppression is required.
