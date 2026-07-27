# Elan8 Method

A lightweight, SysML v2-native methodology for continuous model-based systems engineering.

> Practical SysML v2 methodology for continuous model-based engineering. It connects stakeholder needs, system behavior, architecture, analysis, and verification in a machine-readable and reviewable engineering workflow.

---

## Why this methodology exists

SysML v2 is a powerful systems modeling language, but it does not prescribe a single way of working.

The Elan8 Method combines proven systems engineering practices with a modern Digital Engineering workflow based on SysML v2, text-based modeling, version control, automated quality checks, continuous analysis and verification, generated views, and human-reviewed AI assistance.

It supports Spec42, Babel42, and other Elan8 tooling, but remains usable independently of any single tool.

It is designed as a:

> **lightweight, modular, SysML v2-native MBSE methodology for continuous Digital Engineering.**

The central question is not “Which diagrams must we create?” but:

> Which engineering questions must we answer, which decisions must we make, and what evidence do we need?

---

## Newcomer quick start

1. Skim the [SysML v2 primer](docs/sysml-v2-primer.md) (definition/usage, satisfy/allocate/verify, views).
2. Read [principles](docs/principles.md) and [six concerns](docs/concerns.md) (short).
3. Copy [templates/project-template](templates/project-template/) as a starting repository layout.
4. Walk recipes 1–3: [purpose](recipes/define-system-purpose.md), [context](recipes/define-system-context.md), [concerns](recipes/capture-stakeholder-concerns.md).
5. Continue with [scenario](recipes/model-operational-scenario.md) and [derive requirements](recipes/derive-system-requirements.md).
6. Follow the cliff-safe-stop tour in sibling `sysml-robot-vacuum-cleaner` ([ELAN8_METHOD_TOUR.md](../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md)).

See also: [glossary](docs/glossary.md), [method mapping](docs/method-mapping.md), [roles and reviews](docs/roles-and-reviews.md).

---

## Repository map

```text
mbse-methodology/
  README.md                 # this page
  docs/                     # principles, concerns, levels, tailoring, quality, migration
  recipes/                  # task-oriented modeling guides
  library/                  # Elan8 SysML v2 method libraries
  templates/project-template/
  examples/                 # SE pattern fixtures
  scripts/                  # Spec42 validate helper
```

| Area | Start here |
| --- | --- |
| SysML v2 primer | [docs/sysml-v2-primer.md](docs/sysml-v2-primer.md) |
| Principles | [docs/principles.md](docs/principles.md) |
| Six concerns | [docs/concerns.md](docs/concerns.md) |
| Glossary | [docs/glossary.md](docs/glossary.md) |
| Method mapping | [docs/method-mapping.md](docs/method-mapping.md) |
| Abstraction levels | [docs/abstraction-levels.md](docs/abstraction-levels.md) |
| Tailoring | [docs/tailoring.md](docs/tailoring.md) |
| Roles and reviews | [docs/roles-and-reviews.md](docs/roles-and-reviews.md) |
| Quality rules | [docs/quality-rules.md](docs/quality-rules.md) |
| Spec42 quality contract | [docs/spec42-quality-contract.md](docs/spec42-quality-contract.md) |
| Library migration | [docs/library-migration.md](docs/library-migration.md) |
| SysML libraries | [library/README.md](library/README.md) |
| KPAR release | Tag `v*` → GitHub Actions packs `library/` as `elan8-method-libraries-*.kpar` |
| Recipes | [recipes/](recipes/) |
| Project template | [templates/project-template/](templates/project-template/) |
| Examples | [examples/](examples/) |

---

## Core goals

1. Connect stakeholder needs to architecture and verification.
2. Create consistent and reusable SysML v2 models.
3. Work incrementally instead of building disconnected model layers.
4. Expose assumptions, risks, and decisions.
5. Automate model quality checks.
6. Make engineering changes reviewable and traceable.
7. Generate useful views for different stakeholders.
8. Integrate modeling with simulation, testing, software, and domain engineering.
9. Use AI without losing human accountability.
10. Tailor MBSE effort to project size and risk.

---

## What this repository contains

- Eight principles and six continuous engineering concerns
- Soft abstraction-level guidance (operational / system / logical / physical)
- SysML method libraries (`Elan8Requirement*`, `Elan8Method`, `Elan8Viewpoints`)
- Project template with numbered concern folders
- Full modeling recipes (product-variant recipe remains a short stub)
- Quality-rule checklist plus a contracted Spec42 diagnostic contract (not yet implemented in Spec42)
- SE pattern examples and a pointer to the robot-vacuum showcase

Domain and technical vocabulary lives in sibling `sysml-domain-libraries`, not here.

---

## SysML libraries

Canonical packages (import these in new models):

- `Elan8RequirementManagement`
- `Elan8RequirementMetadata`
- `Elan8Method`
- `Elan8Viewpoints`

See [library-migration.md](docs/library-migration.md) for the move out of domain libraries.

Sibling checkout for Spec42:

```powershell
spec42 --library-path .\library `
       --library-path ..\sysml-domain-libraries\domain `
       --library-path ..\sysml-domain-libraries\technical `
       --library-path ..\sysml-domain-libraries\generic `
       check .\templates\project-template
```

Or run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-spec42.ps1
```

---

## Lessons from existing methodologies

Retained and adapted ideas from SYSMOD (recipes, examples), OOSEM (scenario-driven increments), and Arcadia (need vs solution, viewpoints)—with less diagram-centrism, less tool lock-in, and one semantic network rather than duplicated layer models. Practice is defined by recipes and libraries; see [method-mapping.md](docs/method-mapping.md).

---

## Tool support (intent)

- **Spec42:** templates, snippets, live checks, semantic diff, CI; contracted quality diagnostics documented but not all implemented yet.
- **Babel42:** dashboards, stakeholder views, coverage, decision logs, release readiness.

Method libraries are resolved via `--library-path` (or sibling checkout). Spec42 embeds domain libraries separately; Elan8 Method packages are not required for every SysML model—only when imported.

---

## Definition of success

A small team can start a SysML v2 project without inventing its own structure, model one end-to-end concern with recipes, review architecture and verification coverage, and evolve the model under version control with automated checks where available.
