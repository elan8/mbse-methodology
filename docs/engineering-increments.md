# Engineering increments

An **engineering increment** is the primary unit of progress in the Elan8 Method.

It is a **workflow object** (almost always one pull request), not SysML process metadata.

## Definition

> An engineering increment is a reviewable model change that addresses one relevant engineering question and connects the necessary concerns, behavior, architecture, evidence, and verification to create independent engineering value.

An increment does not need every concern. It must make clear:

- which engineering question is being addressed;
- why the change matters;
- which assumptions and constraints apply;
- which architecture or behavior elements are affected;
- what evidence supports the result;
- how the outcome will be verified or reviewed.

## What belongs where

| Concern | Lives in |
| --- | --- |
| Product meaning (requirements, scenarios, architecture, analysis, verification, decisions, assumptions, risks) | SysML model |
| Increment identity, objective, approval, ownership | Git branch / PR / CODEOWNERS |
| Temporary WIP notes | Draft PR description (not permanent `@…` tags) |

**Do not** annotate many model elements with process tags such as a former `@EngineeringIncrement`. That duplicates Git history and clutters the model. Prefer a clearly named product spine (for example `CliffSafeStopGoldenThread`) plus a PR that states the question and definition of done.

## How to select an increment

Prefer increments that:

- answer one concrete engineering question;
- reduce a real risk or unlock a design decision;
- can be reviewed without understanding the entire model;
- leave the Spec42 check green (or document intentional gaps).

Avoid increments that only rearrange folders, rename without intent, or span unrelated concerns “because we were editing those files anyway.”

## Entry criteria

Before opening the PR (or as its first commit):

- one-sentence engineering question;
- impacted concerns listed;
- known assumptions / constraints called out;
- success criterion for the increment (what “good enough” means).

## Typical scope

Minimal (small profile):

- stakeholder need or concern update;
- one operational scenario (or a focused extension);
- derived system requirement(s) with subject / constraint where measurable;
- allocate / satisfy links as needed;
- verification intent for critical requirements;
- `@DecisionRecord` / `@Assumption` / `@Risk` only when they affect the decision.

Medium: add analysis case, degraded path, interface contracts, or physical realization for the same question.

## Expected model content

Use the numbered folders as a checklist, not a waterfall:

| Folder | Often touched in an increment |
| --- | --- |
| `10_purpose/` | Need, context, requirements |
| `20_behavior/` | Scenario / actions / states |
| `30_architecture/` | Parts, ports, allocate |
| `40_analysis/` | Claims support (see [evidence-and-claims](evidence-and-claims.md)) |
| `50_verification/` | Verification cases / evidence refs |
| `60_views/` | Expose the increment’s spine |
| `00_project/` | Only if tailoring (`ProjectInfo`) changes |

## Working loop (per increment)

Concerns stay non-linear. For each increment, use this default loop:

```text
Frame → Explore → Architect → Evaluate → Verify → Evolve
```

| Step | Focus |
| --- | --- |
| **Frame** | Question, scope, stakeholders, constraints, success criteria |
| **Explore** | Scenarios, behavior, candidate requirements |
| **Architect** | Responsibilities, interfaces, allocations |
| **Evaluate** | Assumptions, alternatives, analysis, `@DecisionRecord` |
| **Verify** | Verification cases, evidence URIs, coverage of the question |
| **Evolve** | PR review, merge, baseline impact, follow-up risks |

Detail for each step: [workflow.md](workflow.md).

## Pull request as the increment container

Suggested PR body:

```markdown
## Engineering question
…

## Why it matters
…

## Concerns touched
purpose / behavior / architecture / evidence / verification / evolution

## Assumptions & risks
…

## Evidence & verification
…

## Definition of done
- [ ] Question answered in the model
- [ ] Critical links (derive / satisfy / allocate / verify) present
- [ ] Spec42 check green (or gaps listed)
- [ ] Reviewer can follow the spine without tribal knowledge
```

## Definition of done

An engineering increment is complete when:

- the engineering question is explicit (PR + model `doc` where useful);
- impacted concerns and model elements are identifiable;
- relevant architecture or behavior changes are modeled;
- important assumptions are documented;
- evidence or rationale is available ([evidence-and-claims](evidence-and-claims.md));
- verification intent is defined for critical claims;
- automated checks pass;
- the change has been reviewed and merged.

## Incomplete or exploratory work

Use draft PRs or clearly labeled WIP branches. Do not leave permanent “in progress” process metadata on released model elements. Prefer OMG `StatusInfo` only for product lifecycle states your project defines—not as a substitute for Git.

## Baselines and releases

Increments accumulate into baselines via Git tags/releases and, when needed, `RequirementBaseline` / evidence records in the model. The increment itself is not a baseline; the merge history is.

## Showcase

Sibling [`sysml-robot-vacuum-cleaner`](../../sysml-robot-vacuum-cleaner): cliff-safe-stop increment — see [ELAN8_METHOD_TOUR.md](../../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md).

## Related

- [principles.md](principles.md) — Build vertical increments
- [concerns.md](concerns.md) — Six continuous concerns
- [roles-and-reviews.md](roles-and-reviews.md) — PR reviews
- [evidence-and-claims.md](evidence-and-claims.md) — Claim → Evidence → Confidence → Decision
- [workflow.md](workflow.md) — Frame → … → Evolve detail
