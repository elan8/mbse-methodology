# Roles and reviews

Lightweight accountability for Elan8 Method projects. Process enforcement stays in Git (PR, CODEOWNERS, CI); the model records engineering meaning.

## Suggested roles

| Role | Focus |
| --- | --- |
| Product / stakeholder lead | Purpose, needs, success criteria |
| Systems engineer | Context, scenarios, requirements, allocation, overall coherence |
| Domain / architecture owner | Logical/physical structure, interfaces, decisions |
| Verification lead | Verification cases, coverage, evidence URIs |
| Model owner | Package conventions, library imports, CI green |

One person may hold several roles on a small project.

## Review moments (by concern)

| When | Review question | Typical approver |
| --- | --- | --- |
| Purpose increment | Is the boundary and need clear enough to design? | Product + systems |
| Scenario + requirements | Are requirements testable and derived from needs? | Systems + verification |
| Architecture / interface | Are responsibilities and boundaries stable enough? | Architecture owner + systems |
| Verification readiness | Can we demonstrate critical requirements? | Verification + systems |
| Release baseline | Does CI pass; are assumptions still valid? | Model owner + leads |

## Pull request as the review mechanism

- Every engineering increment lands as a PR with model diffs (and Spec42 check).
- PR description states: concern(s), increment objective, decisions, residual risks.
- Use CODEOWNERS for package-path ownership; do not encode owners in SysML metadata.
- Do not duplicate full approval workflows inside SysML; keep process approval in Git/PR.

## AI-assisted changes

AI may draft model text. Humans remain accountable for requirements, assumptions, decisions, and verification claims before merge.
