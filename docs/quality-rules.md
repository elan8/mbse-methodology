# Elan8 quality rule catalog

This is the canonical catalog for methodology checks and engineering review prompts. It supports [engineering increments](engineering-increments.md); it is not another completion framework. Scope checks to the question, selected obligations and relevant model closure.

**Implementation status:** all Elan8 rules below are proposed/manual. This repository implements no runtime methodology-diagnostic engine. Existing CI checks language/model validity and library usage, not these rules. Language errors remain the responsibility of the configured SysML/KerML validator; avoid reissuing them under Elan8 identifiers.

## What can be automated?

| Mode | Meaning | LLM needed? |
| --- | --- | --- |
| S — semantic | Deterministic graph/AST checks using resolved identities, relationships and effective features | No |
| T — text cue | Deterministic wording/pattern hints, with bounded false positives | No |
| H — hybrid | Check the presence of structural/documented evidence; interpret its adequacy separately | Optional assistance, human judgment remains |
| J — judgment | Interpret engineering meaning using sources, context and evidence | Human review; an LLM may assist |

A semantic graph is not an engineering oracle. A trace exists mechanically; whether it is justified is a review question. All methodology defaults are warnings or information so incomplete work remains usable. Projects may explicitly gate a reviewed scope in CI; assistant suggestions must never become automatic conformance failures.

## Catalog

Stable identifiers use `elan8.` followed by the lower-case catalog ID with hyphens replaced by dots, for example `elan8.req.01`. Every entry is proposed, revision 1. Unknown or unsupported information is reported as a check limitation, not a missing-element failure. See [implementation guidance](quality-diagnostic-contract.md).

### REQ-01 — Explicit obligation subject

**Rationale:** A requirement must identify what it constrains. An effective subject connects the obligation to the relevant system, component, interface or other entity, giving satisfaction, analysis and verification a consistent boundary. The subject may be inherited; it need not be repeated locally or fixed to an implementation instance.

**Consequence of the gap:** Designers may assign the obligation to different entities, analyses may use the wrong boundary, and verification may measure a component when the obligation concerns the complete system.

| Field | Contract |
| --- | --- |
| Mode / default severity | S / warning |
| Applicability | Selected design-input requirement usages, including directly applicable supplied obligations. |
| Detectable condition or review question | No effective subject after inheritance/redefinition is resolved. |
| Primary location | Requirement declaration. |
| Suggested correction | Declare the constrained subject and its type. |
| Exceptions and limits | Stakeholder needs, abstract definitions awaiting contextualization, and unresolved types are not missing-subject failures. |

**Example:** “Register a request within 1 s” must identify whether it constrains the panel, group controller or complete elevator service. A controller meeting its processing-time limit does not establish that the passenger sees acknowledgment within the same limit. Elevator SYS-001 identifies an ElevatorService subject; a doc-only obligation without an effective subject leaves that boundary unspecified. A checker can detect the missing subject; review must establish whether the chosen subject and measurement boundary are appropriate.

### REQ-02 — Requirement justification

**Rationale:** Source relationships and rationale explain why an obligation exists and how it contributes to stakeholder intent or an engineering decision. They make assumptions, scope changes and impact analysis reviewable; their presence does not prove the interpretation is justified.

**Consequence of the gap:** Unnecessary targets or unjustified design constraints can accumulate, and reviewers cannot reliably assess the effects of a changed need or source obligation.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / warning |
| Applicability | Selected system obligations. |
| Detectable condition or review question | No incoming resolved derivation or configured source reference, and no recognized rationale evidence. |
| Primary location | Requirement declaration. |
| Suggested correction | Link the source or provide a documented engineering rationale. |
| Exceptions and limits | Documentation free text cannot be reliably recognized without a project convention; return unknown and request review. A link proves presence, not necessity. |

**Example:** Elevator SYS-003 derives from NEED-003; a new engineering target without a source or rationale is a candidate gap.

### REQ-03 — Operational acceptance expression

**Rationale:** Acceptance criteria define how fulfillment will be judged. An evaluable constraint or referenced inspection/demonstration criterion connects intent to an observable decision, without requiring every obligation to be a numerical formula.

**Consequence of the gap:** Different reviewers can apply different meanings of success, and a linked verification case may have no defensible basis for its verdict.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / information |
| Applicability | Selected obligations intended for evaluable constraints. |
| Detectable condition or review question | No effective nonempty required constraint expression or referenced acceptance criterion is represented. |
| Primary location | Requirement or required constraint. |
| Suggested correction | Express the measurable property, condition and limit, or reference an inspection/demonstration criterion. |
| Exceptions and limits | Prose-based contractual obligations and inspection criteria can be valid; classify as review-needed rather than invalid. Nonempty expressions can still be inadequate. |

**Example:** Elevator SYS-002 has an inclusive time constraint; an empty doc-only constraint does not establish evaluated acceptance.

### REQ-04 — Quantitative criterion clarity

**Rationale:** A quantitative limit needs a defined property, quantity semantics, comparison boundary and applicable conditions so calculations and observations can be compared consistently. Context determines whether the number describes the intended obligation.

**Consequence of the gap:** Results may be compared using different units, event boundaries or operating conditions; a numerical pass can then support the wrong claim.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / warning |
| Applicability | Explicitly quantitative obligations and evaluation criteria. |
| Detectable condition or review question | Recognized quantity expression lacks resolvable quantity semantics, comparison boundary or applicable condition evidence. |
| Primary location | Relevant property/comparison. |
| Suggested correction | Identify the quantity, compatible unit, boundary and operating conditions. |
| Exceptions and limits | Unit/type incompatibility belongs to the language validator. Dimensionless quantities need no physical unit; inherited units count. Prose recognition is advisory. |

**Example:** CUST-001 provides a time limit and documented two-car profile; a bare “wait <=30” without defined quantity/context needs review.

### BEH-01 — Scenario responsibility path

**Rationale:** Scenario responsibilities need an accountable realizing element. A contextual allocation path connects required behavior to a selected design while supporting either direct physical allocation or useful logical decomposition.

**Consequence of the gap:** Required steps can remain unimplemented, responsibilities can be duplicated or assumed by different components, and change impact cannot be followed reliably.

| Field | Contract |
| --- | --- |
| Mode / default severity | S / warning |
| Applicability | Action usages selected as responsibilities in reviewed scenarios. |
| Detectable condition or review question | No allocation from the usage or its reusable definition-level responsibility reaches a selected implementation part through permitted allocation links. |
| Primary location | Scenario action or canonical responsibility. |
| Suggested correction | Allocate directly or complete the logical-to-physical path. |
| Exceptions and limits | Do not treat every action as an internal responsibility: external actor actions and environmental events are excluded. Shared definitions require contextual mapping; similar names do not establish identity. |

**Example:** Elevator ExcludeUnavailableCar maps to its canonical function, dispatchManager and service.group; an isolated responsibility has a gap.

### ARCH-01 — Typed exchange endpoints

**Rationale:** Typed exchange features identify what crosses an interface and support compatibility checks between collaborating elements. They make transfer semantics distinct from topology or descriptive edge labels.

**Consequence of the gap:** Participants can disagree about payload meaning or structure, and apparently connected components may lack a usable interaction contract.

| Field | Contract |
| --- | --- |
| Mode / default severity | S / warning |
| Applicability | Selected flows and declared public exchange payloads. |
| Detectable condition or review question | Payload lacks an effective type, or a resolved flow endpoint has no typed transferred feature. |
| Primary location | Payload or flow declaration. |
| Suggested correction | Type the exchange and connect the intended directional endpoints. |
| Exceptions and limits | Not every port transfers an item; scalar quantity signals are valid. Compatibility errors and unresolved references belong to the language validator. Unsupported projection is unknown. |

**Example:** Elevator assignment and status items are typed; a descriptive string used only as an edge label does not model transfer.

### ARCH-02 — Decision rationale presence

**Rationale:** Consequential choices need an explanation of the criteria and assumptions supporting them so later changes can be assessed without reconstructing meeting history. A populated rationale is only the starting point for that review.

**Consequence of the gap:** An architecture can appear arbitrary; reviewers cannot judge trade-offs or know when new evidence should reopen a decision.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / information |
| Applicability | Explicit consequential decision records. |
| Detectable condition or review question | Decision record has no populated rationale or referenced rationale artifact. |
| Primary location | Decision record. |
| Suggested correction | State the choice, criteria, assumptions and why it is preferred. |
| Exceptions and limits | Do not require a decision annotation on every element. Presence is mechanically checkable; persuasiveness and alternatives require review. |

**Example:** DEC-001 has qualitative rationale; an empty rationale field is a presence gap.

### VER-01 — Verification readiness

**Rationale:** A verification plan needs an obligation, evaluated subject, method and criterion to define what will be evaluated and how. Effective information can come from reusable definitions; structural readiness is not proof that the evaluation is adequate.

**Consequence of the gap:** A case can look complete while evaluating the wrong entity, lacking an executable or reviewable procedure, or offering no justified acceptance decision.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / warning |
| Applicability | Selected verification definitions/usages intended to evaluate obligations. |
| Detectable condition or review question | One or more effective obligation targets, evaluation subject, method or acceptance criterion are absent. Report separate missing facets. |
| Primary location | Case or missing facet context. |
| Suggested correction | Link the canonical obligation, identify subject/method and define or reference the evaluation criterion. |
| Exceptions and limits | Inherit methods and criteria from definitions. Planned validation reviews can remain incomplete when explicitly recorded as gaps. An evaluator expression alone does not prove verifiability. |

**Example:** RegistrationCheck supplies the structural facets; stakeholderJourneyReview intentionally lacks agreed criteria and a completed result.

### VER-02 — Planned obligation coverage

**Rationale:** Planned coverage makes unaddressed obligations visible early enough to arrange the necessary evaluation. It connects canonical requirements to cases without confusing a plan with completed evidence.

**Consequence of the gap:** Critical obligations can reach a review or release without an evaluation plan, while satisfaction links or coverage of derived obligations create a false impression of coverage.

| Field | Contract |
| --- | --- |
| Mode / default severity | S / warning |
| Applicability | Explicit selected obligation set, including project-selected critical obligations. |
| Detectable condition or review question | No resolved verification objective targets an obligation, directly or through a supported referenced case definition. |
| Primary location | Uncovered requirement, with a grouped coverage report. |
| Suggested correction | Add a case or record a scoped verification gap. |
| Exceptions and limits | Do not infer criticality from a safety role, approval from StatusInfo, or scope from folder placement. Case definitions count as planned coverage, not executed results. Partial imports mean unknown coverage. |

**Example:** Five elevator obligations have planned targets; the missing-verification SE fixture supplies an intentional gap.

### EVD-01 — Result provenance

**Rationale:** A result is meaningful only for an identified configuration, procedure and set of conditions. Provenance connects observations to the claim and supports review of whether evidence can be reused after a change.

**Consequence of the gap:** An old, unrelated or synthetic observation can be mistaken for applicable executed evidence, and a report link can be presented as proof without establishing what was evaluated.

| Field | Contract |
| --- | --- |
| Mode / default severity | H / warning |
| Applicability | Explicit result claims under review, distinguished from plans and synthetic fixtures. |
| Detectable condition or review question | Required baseline, conditions, procedure, observation source or evidence reference fields are absent under the project result contract. |
| Primary location | Result claim or evidence record. |
| Suggested correction | Supply applicable provenance or downgrade the claim to planned/unsubstantiated. |
| Exceptions and limits | The current VerificationEvidence type only stores name/URI. Other fields need a declared artifact adapter or review; do not invent mandatory metadata. A URI does not prove authentic or applicable evidence. |

**Example:** Elevator fixtures are explicitly synthetic and make no executed-result claim; a claimed test pass with only a report link needs provenance review.

### VIEW-01 — Canonical view references

**Rationale:** Views should present canonical engineering content so stakeholders review the same obligations and design. Checking ownership can expose copied content, while allowing legitimate view-local presentation semantics.

**Consequence of the gap:** Copies can diverge, changes may update one representation only, and reviewers may draw conclusions from obsolete or disconnected content.

| Field | Contract |
| --- | --- |
| Mode / default severity | S / information |
| Applicability | Selected views and their engineering content. |
| Detectable condition or review question | View owns new requirement/behavior/architecture content instead of exposing a canonical selected element. |
| Primary location | Owned engineering element in the view. |
| Suggested correction | Expose/reference the canonical element or explain view-local semantics. |
| Exceptions and limits | View-local rendering and presentation content can be legitimate. Semantic ownership must be available; do not infer duplication from equal names. |

**Example:** Elevator views expose existing packages; a copied obligation with new identity needs review.

### TXT-01 — Requirement wording cues

**Rationale:** Wording cues give inexpensive early prompts about statements that may need clarification. They complement formal modeling and engineering review; individual words and patterns do not establish ambiguity or invalidity.

**Consequence of the gap:** Vague conditions or outcomes may survive unnoticed and cause inconsistent interpretations. Treating cues as hard failures can also reject well-defined terminology or faithfully preserved source wording.

| Field | Contract |
| --- | --- |
| Mode / default severity | T / information |
| Applicability | Human-language requirement statements with identified statement spans. |
| Detectable condition or review question | Configured terms or patterns such as undefined “quickly”, TBD or ambiguous pronoun references are detected. |
| Primary location | Exact text span. |
| Suggested correction | Clarify the measurable outcome or refer to a defined term/criterion. |
| Exceptions and limits | Do not scan all docs as if they were obligations. “And” does not prove multiple requirements; “shall” is not required inside a formal constraint. Defined terms and quoted source wording require review. |

**Example:** “Register quickly” is a cue; “register within 1 s for a valid request” with a modeled criterion resolves that cue.

### REV-01 — Need and source fidelity

**Rationale:** A well-formed obligation can still misrepresent its source or impose unnecessary detail. Reviewing the transformation checks whether the modeled commitment is needed and appropriate to its subject and scope.

**Consequence of the gap:** The team can build and verify an accurately modeled obligation that does not address the actual need, or incur avoidable cost through unjustified constraints.

| Field | Contract |
| --- | --- |
| Mode / default severity | J / information |
| Applicability | Requirement/source pairs selected for engineering review. |
| Detectable condition or review question | Reviewer or optional assistant identifies an unsupported interpretation, unnecessary obligation or unjustified detail. |
| Primary location | Requirement plus related source. |
| Suggested correction | Explain the transformation or agree a corrected interpretation with the stakeholder. |
| Exceptions and limits | Missing context yields a question, not a finding that a requirement is wrong. A source link alone cannot settle this. |

**Example:** Review whether SYS-001 contributes to predictable travel; it alone cannot establish CUST-001.

### REV-02 — Single understandable obligation

**Rationale:** A coherent obligation must be understandable to its intended audience and sufficiently specified for evaluation. Review distinguishes one bounded commitment from several independent obligations without relying on grammar alone.

**Consequence of the gap:** Different interpretations can drive incompatible designs or verdicts, and a combined obligation can hide partial fulfillment or unclear responsibility.

| Field | Contract |
| --- | --- |
| Mode / default severity | J / information |
| Applicability | Individual statements/expressions and relevant glossary/context. |
| Detectable condition or review question | Review identifies independent obligations, multiple plausible meanings or insufficient evaluation conditions. |
| Primary location | Relevant statement/expression and related context. |
| Suggested correction | Clarify terms/conditions or split independently evaluable obligations where useful. |
| Exceptions and limits | Conjunctions and multiple constraint expressions can express one coherent obligation; no mechanical split rule. |

**Example:** A bounds constraint using >= and <= may be one obligation; unrelated registration and maintenance obligations may need separation.

### REV-03 — Feasibility and evidence adequacy

**Rationale:** Feasibility and evidence adequacy depend on the design, assumptions, operating conditions and practical constraints. Reviewing that argument prevents a calculable expression or confident assertion from substituting for engineering substantiation.

**Consequence of the gap:** An infeasible target can be accepted, or a passing calculation or synthetic fixture can be used to support a claim beyond the conditions and boundary it establishes.

| Field | Contract |
| --- | --- |
| Mode / default severity | J / information |
| Applicability | Requirement/design/analysis/evidence argument under review. |
| Detectable condition or review question | Review identifies unjustified feasibility assumptions or evidence that does not support the claimed boundary/conditions. |
| Primary location | Claim with related assumption/evidence. |
| Suggested correction | Obtain appropriate analysis or observations, revise the design, or record an unresolved claim. |
| Exceptions and limits | An LLM cannot establish physical feasibility or authenticate a test. Specialized solvers can prove narrower explicitly formalized properties. |

**Example:** A synthetic 20 s waiting mean does not establish implemented dispatch performance.

### REV-04 — Set coherence and stakeholder outcomes

**Rationale:** Individual obligations can be clear while the set omits a stakeholder outcome or contains conflicts. Set review connects requirements to lifecycle scenarios and checks the overall argument, beyond local links and coverage counts.

**Consequence of the gap:** The system can meet every selected obligation yet miss intended use, or satisfy incompatible interpretations in different contexts without resolving the conflict.

| Field | Contract |
| --- | --- |
| Mode / default severity | J / information |
| Applicability | Explicit requirement set, stakeholder needs and relevant lifecycle scenarios. |
| Detectable condition or review question | Review identifies missing outcomes, incompatible obligations, inconsistent terminology or unsupported overall need coverage. |
| Primary location | Set-level report with implicated requirements/scenarios. |
| Suggested correction | Resolve conflicts, add justified obligations or record the remaining outcome gap. |
| Exceptions and limits | Completeness cannot be inferred from coverage percentages. Solver contradictions apply only to the formalized shared conditions and variables. |

**Example:** One-car service has no agreed reduced waiting target; passing its dispatch check does not validate the complete continuity need.

## Relationship to INCOSE guidance

INCOSE's [Guide to Writing Requirements V4 summary sheet](https://www.incose.org/wp-content/uploads/legacy/working-groups/requirements-wg/guidetowritingrequirements/incose_rwg_gtwr_v4_summary_sheet.pdf), INCOSE-TP-2010-006-04 (June 2023), addresses both individual expressions and requirement sets. Elan8 uses it as an engineering-review reference, not as an executable specification or a claim of INCOSE conformance. The mappings below are our interpretation; Elan8 IDs are not INCOSE rule IDs.

| INCOSE characteristic references | Elan8 review support |
| --- | --- |
| C1, C2, C8 | REQ-02 and REV-01: examine why an obligation exists, its abstraction and its fidelity to the source |
| C3, C4, C5 | REQ-03/04, TXT-01 and REV-02: assess clear meaning, sufficient conditions and a coherent obligation |
| C6, C7 | VER-01 and REV-03: examine realizability and the practicality of evaluation |
| C9 | TXT-01 and project conventions: distinguish prose style from formal-language expression |
| C10–C15 | REV-04: review the set against context and stakeholder outcomes |

The [official guide listing](https://portal.incose.org/Web/iCore/Store/StoreLayouts/Item_Detail.aspx?Category=EBOOKS&iProductCode=GUIDEWRITEREQ) provides the full reference. The catalog does not reproduce its writing-rule collection. Good grammar and populated fields are insufficient to establish engineering quality.

## Initial implementation order

Start with REQ-01, BEH-01, and VER-01/02, plus REQ-02 when source/rationale representations are explicit. Add typed-exchange and text-cue support next. Keep provenance checks adapter-dependent and judgment prompts optional. Use the elevator and focused fixtures to validate supported scope before enabling CI gating.


