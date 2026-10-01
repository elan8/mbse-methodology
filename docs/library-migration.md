# Method library migration

## Current namespace

Load all files from `library/` together. The single `Elan8Method` facade exposes Metadata, MethodCore, Verification, and Viewpoints. Leaf packages have distinct names so they do not shadow the standard library.

Older model imports under `Elan8::Method::...` or `Method::...` must migrate to the corresponding `Elan8Method::...` namespaces. Repeated same-named package declarations do not reopen or merge a namespace.

## Removed Requirements package

Native SysML supplies requirements and their relationships. Use `Elan8Method::Metadata` for optional requirement roles; use native short names for identifiers. Names, identifiers, and URIs use `ScalarValues::String`.

Verification evidence moved to `Elan8Method::Verification::VerificationEvidence`. Keep evidence associated with its verification case; a URI alone does not establish a passing result.

## Consumer imports

```sysml
private import Elan8Method::Metadata::*;
private import Elan8Method::MethodCore::*;
private import Elan8Method::Verification::*;
private import Elan8Method::Viewpoints::*;
```

Import only the packages needed by a model. Update model imports and library versions together. Avoid loading an older archive alongside the current sources. External domain libraries are optional and must be configured explicitly.

## Identity and lightweight working method

Requirement identifiers use native SysML short names; remove duplicated identity metadata. The old project-wide profile is removed. The separate engineering-concern taxonomy and `EngineeringConcern`/`EngineeringConcernKind` are removed; retain native SysML stakeholder `concern` elements where they express engineering meaning.

`StageDisposition`, `EngineeringStageKind` and `StageStatusKind` are removed. Replace useful merge/omission rationales with short package documentation or project notes, and remove obsolete imports and tags. Areas are navigation locations; increments are the working unit. No replacement concern or area-status metadata is introduced.

## Six model areas

Capabilities is no longer a separate area. Move useful outcomes, conditions, measures and scenario references from `30_capabilities` into `10_context`, update views and imports, and remove redundant groupings. Existing folder numbers remain stable. The six model areas are Context, Use Cases, Functions, Logical Architecture, Physical Architecture and Verification.

The old concerns document is removed and the per-stage readiness table is replaced by [increment review](increment-review.md). Follow the three [working steps](workflow.md).
