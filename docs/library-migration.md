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

## Identity and tailoring simplification

Requirement identifiers now use native SysML short names. Move previous identity values to the requirement declaration's short name and remove the identity annotation. The project-wide tailoring enum and ProjectInfo profile attribute are removed; record applicability and merging independently on each stage using StageDisposition.
