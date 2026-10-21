# Roles and reviews

Review each increment with people who can assess its question, affected design and evidence. One person may cover several responsibilities on a small project; no fixed set of review meetings is required.

| Responsibility | Review focus |
| --- | --- |
| Stakeholder / product representative | Needs, source obligations, operating context and useful outcomes |
| Systems / domain engineer | Scenarios, requirements, architecture, interfaces and decision rationale |
| Verification / evidence reviewer | Evaluation methods, acceptance criteria, provenance and gaps |
| Model maintainer | Model conventions, library dependencies and relevant automated checks |

Use the single [increment review checklist](increment-review.md). The PR states the question, changes, answer, evidence and remaining gaps. Git review records acceptance; CODEOWNERS can identify package reviewers. Do not duplicate ownership or approval workflows in SysML metadata.

Review stakeholder outcomes separately from requirement conformance. A merged PR or a successful model check does not prove product fitness. Humans remain accountable for requirements, assumptions, decisions and claims, including AI-assisted drafts.
