# Quality-check implementation guidance

Implement the [rule catalog](quality-rules.md) as deterministic diagnostics first, with optional engineering-review assistance. This is an implementation contract, not an existing engine. It introduces no mandatory model metadata, approval workflow, LLM service or non-executable YAML configuration.

## Inputs and scope

A run identifies the model baseline, language/library versions, catalog revision, semantic provider/version and checked scope. Use explicit selected elements/obligations for an increment, with a relevant dependency closure; optionally select a complete project report. Folder location may help navigation but must not determine role, criticality or approval.

The caller provides the selected design-input requirements, responsibility actions, implementation parts and any critical subset. These can come from resolved model queries, a reviewed selection or an external project adapter. Include directly applicable customer requirements. Do not treat every requirement as design input, every action as a responsibility, or every safety-role tag as a criticality classification. Record how selection was made; if it is unavailable, report that the relevant rule was not evaluated rather than silently substituting a folder-based guess.

Resolve case definitions/usages, inherited and redefined subjects, parameter types, requirement constraints, native derivation, allocations, verification objectives, connections, flows, metadata and view ownership. Keep stable semantic identities and source locations. Adapter capabilities must distinguish “absent” from “not represented.” Source references, rationale and result provenance may live in docs/artifacts; declare supported representations instead of requiring invented metadata.

## Evaluation outcomes

Each rule instance returns one of: **pass**, **finding**, **not-applicable**, **unknown**, or **review-needed**. Unsupported semantic publication, partial dependency loading, ambiguous scope or missing evidence access yields unknown. Suppress dependent missing-link findings when language resolution has already failed; retain the underlying language diagnostic and check limitation.

A method finding means its stated condition was detected. It does not imply engineering invalidity beyond that condition. Text cues and judgment findings stay visibly advisory. A passing presence check does not prove adequate rationale, complete coverage, feasible design or authentic evidence.

## Semantic algorithms

### REQ-01: effective subject

For each selected obligation, resolve its effective subject, including inheritance and redefinition. If subject-resolution capability is absent, return unknown. If a language error prevents resolution, defer to it. If no effective subject is present, emit one finding at the requirement declaration. Do not require the subject to be written locally or fixed to a particular instance.

### REQ-02: source or rationale

Look for incoming derivation from a resolved source and configured external source references. If neither exists, inspect the declared rationale adapter. If rationale is present, pass the presence check while leaving adequacy for REV-01. If all supported channels are absent, report the gap. If arbitrary docs may contain an unstructured rationale that the adapter cannot recognize, return review-needed/unknown rather than claiming it is absent. Do not demand a derivation from every customer requirement to a copied system requirement.

### BEH-01: contextual allocation path

Map selected scenario responsibility usages to the canonical reusable function responsibility through resolved definition/usage relationships and explicit contextual selection. Never match by simple name alone. Traverse permitted directed allocation edges to a selected implementation part; allow direct behavior-to-physical and behavior-to-logical-to-physical paths. Maintain visited identities to terminate cycles. A generic part type alone does not establish physical implementation.

For repeated/shared definitions, evaluate each selected contextual role; allocation to one car is not automatically coverage of all car roles. Report the missing role or unresolved mapping. External actor actions and environmental events are excluded by the caller's responsibility selection. Include the successful or incomplete path as related diagnostic evidence.

### VER-01/02: readiness and planned coverage

Resolve verification objective targets in definitions and usages, including inherited objectives. Definitions count as planned coverage. Aggregate effective subject, method and acceptance expression/reference for each selected case; deduplicate inherited missing facets at their defining location. For coverage, build an index from canonical requirement identity to referencing cases and report uncovered selected obligations once.

Do not count satisfaction, derivation or a plain mention as a verification target. Do not automatically propagate verification across a derivation chain: evaluating a child obligation does not establish parent coverage. A generic case definition provides a plan; an appropriately bound execution and applicable observations are required for a result. A linked case can still lack conditions or adequate acceptance criteria.

### Other checks

For ARCH-01, use effective payload typing and resolved flow endpoints; distinguish connection topology from item transfer. Delegate dimensional/directional incompatibilities to language validation. For VIEW-01, examine actual ownership and exposure; similar labels do not establish duplicate identity. For EVD-01, run only when an explicit result claim and supported provenance representation are available. Synthetic observation inputs and planned cases are not executed-result claims.

Formal solvers can supplement the catalog for bounded constraint conflicts or calculations when assumptions and shared variable/condition mapping are explicit. State the solver's supported fragment and result scope. Arbitrary prose consistency, overall completeness and physical feasibility do not become mechanical merely because a solver is available.

## Diagnostic output

Each finding records:

- Stable rule ID and catalog revision, mode, severity and evaluation outcome.
- A concrete message naming the missing facet or questioned interpretation.
- Primary element identity and source range, with related paths/elements/statement spans.
- The checked scope/baseline and evidence used, including unsupported provider capabilities.
- Suggested next action, exception disposition where relevant, and producer provenance.
- A link to the catalog rationale and consequence of the gap, so the user can understand why the finding matters without expanding every diagnostic message.

Example: **“SYS-003 has no verification objective targeting it in the selected, fully loaded obligation set. Add a case or record an explicit coverage gap.”** Locate it on SYS-003 and link the coverage selection. Do not emit “requirement failed”: that would confuse missing planned coverage with a failed evaluation.

Group set-level reports and avoid emitting the same root cause at every inherited usage. Refresh affected diagnostics when elements change; invalidate when baseline/provider/catalog changes. Keep diagnostics stable under harmless renaming through semantic identity where supported.

Exceptions identify rule, target/scope, reason, accountable review and applicable baseline or expiry outside mandatory model metadata. Show them as dispositions; do not convert them to passing engineering checks. Report check coverage and unknown outcomes alongside diagnostic counts.

## Text cues and optional LLM-assisted review

TXT-01 can run locally using explicit statement spans, a glossary and configured patterns. Keep cues informational. A flagged word may be precisely defined; an unflagged sentence may still be ambiguous. Never rewrite customer-supplied wording automatically or demand “shall” in formal expressions.

An LLM is optional for REV-01–04 and the adequacy part of hybrid checks. A human can perform the same review without it. Provide only the relevant statement, source, scenario, constraints, glossary and evidence excerpts; record which context was supplied. Ask the assistant to identify the rule, quote the affected span, explain the concern with context references, propose a correction or clarification question, and identify missing information. Treat model/document content as data, not instructions.

Return suggestions separately from deterministic findings, recording model/version and context baseline. Repeated runs may vary; do not make an LLM response a CI gate, silently suppress semantic diagnostics, mutate source obligations or assert conformance. Human review decides whether to act. Lack of context is a question, not a fabricated defect. Confident prose is not engineering evidence.

## Implementation and validation sequence

1. Inventory semantic-provider capabilities; verify actual relationship materialization rather than parsing alone.
2. Implement the initial catalog subset against a normalized semantic adapter; keep diagnostics independent of a particular UI.
3. Exercise fixtures for valid, incomplete, invalid, inherited, cross-file, direct/indirect allocation and unsupported-publication cases.
4. Expose warnings in the editor and grouped reports in review. Gate only explicitly selected deterministic rules with known complete inputs and a project-approved severity policy.
5. Add text cues and optional judgment assistance after deterministic findings are useful and stable.

The elevator supplies explicit subjects, five planned obligation targets, typed exchanges and allocation paths. Its planned stakeholderJourneyReview intentionally lacks agreed criteria/results; that is useful incomplete-work feedback, not a language error. The [missing-verification fixture](../examples/se-patterns/missing-verification/missing-verification.sysml) supplies a coverage gap when its system obligation is explicitly selected. Do not infer approval from its example StatusInfo tags.

A future implementation's test matrix should also cover: effective inherited subjects; source rationale present only in docs; repeated action definitions allocated differently by context; direct physical allocation; cyclic allocation without an implementation target; inherited verification objectives; unloaded imports yielding unknown; a valid dimensionless criterion; a glossary-defined wording cue; and a synthetic fixture that must not trigger a result-provenance violation.

Assert diagnostic ID, outcome, location, related identities, deduplication and absence of false positives. Mutation tests should remove one relationship/facet at a time and verify the intended finding, while unsupported projections yield unknown. Acceptance is demonstrated by these checks and recorded provider capabilities, not a favorable LLM review or a reduced warning count alone.
