# Quality rules

Candidate rules for the Elan8 Method. Distinguish **errors**, **warnings**, **recommendations**, and project-specific exceptions.

Until Spec42 implements a rule, treat it as a **manual / checklist** item. Do not add non-executable YAML rule catalogs. Contracted diagnostics: [spec42-quality-contract.md](spec42-quality-contract.md).

| ID | Area | Rule | Severity | Status |
| --- | --- | --- | --- | --- |
| QR-REQ-01 | Requirements | Every approved requirement has a subject | error | **contracted** → `elan8.req.missing_subject` |
| QR-REQ-02 | Requirements | Every approved requirement has an owner (model label and/or CODEOWNERS) | warning | checklist |
| QR-REQ-03 | Requirements | Every critical requirement has a verification case | error | **contracted** → `elan8.req.missing_verification` |
| QR-REQ-04 | Requirements | Measurable requirements define quantities, units, and acceptance criteria | error | checklist |
| QR-REQ-05 | Requirements | Derived requirements trace to their source or rationale (`#derivation` or documented rationale) | warning | checklist |
| QR-BEH-01 | Behavior | Externally visible scenarios identify relevant actors | warning | checklist |
| QR-BEH-02 | Behavior | Important exception paths are modeled explicitly | recommendation | checklist |
| QR-BEH-03 | Behavior | Action inputs and outputs use defined item types | warning | checklist |
| QR-BEH-04 | Behavior | State transitions have meaningful triggers or conditions | warning | checklist |
| QR-ARCH-01 | Architecture | External interactions pass through explicit ports or interfaces | warning | checklist |
| QR-ARCH-02 | Architecture | Public interfaces use reusable item definitions | warning | checklist |
| QR-ARCH-03 | Architecture | Logical responsibilities allocate to physical realization where applicable | warning | checklist |
| QR-ARCH-04 | Architecture | Unconnected public ports are reported | warning | checklist |
| QR-ARCH-05 | Architecture | Architecture decisions include rationale (`@DecisionRecord` or equivalent) | warning | checklist |
| QR-AN-01 | Analysis | Analysis cases define objectives | error | checklist |
| QR-AN-02 | Analysis | Assumptions are explicit (`@Assumption` or documented) | warning | checklist |
| QR-VER-01 | Verification | Verification cases define a method | warning | checklist |
| QR-VER-02 | Verification | Verification cases define pass criteria | warning | checklist |
| QR-VER-03 | Verification | Requirement coverage gaps are reported | warning | **contracted** → `elan8.ver.coverage_gap` |
| QR-EVO-01 | Evolution | Released elements have an owner and lifecycle status | warning | checklist |
| QR-EVO-02 | Evolution | Orphaned elements are reported | recommendation | checklist |
| QR-EVO-03 | Evolution | Invalid references fail CI | error | Spec42 / CI |

## Tooling intent

Spec42 should enforce the contracted subset as diagnostics. Babel42 should surface coverage and gaps for review. Until then, recipes and reviews use this table as a shared checklist.
