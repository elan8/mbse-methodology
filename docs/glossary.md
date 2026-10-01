# Glossary

Terms as used in the Elan8 Method. Where SysML v2 already defines a word, that meaning wins for model elements.

| Term | Elan8 / SysML meaning | Not to be confused with |
| --- | --- | --- |
| **SysML `concern`** | First-class model element stating a stakeholder interest, often framed by a viewpoint. | A mandatory classification of engineering work. |
| **Engineering increment** | A reviewable, vertical model change (typically one PR) that addresses one engineering question and connects relevant engineering content through need → scenario → requirement → architecture → analysis → verification → decision. Scoped in Git/PR and clear naming — **not** SysML process metadata. | An agile sprint (timebox). An increment may span one or more sprints. “Golden thread” may appear as an example scenario name (e.g. `PassengerJourney`), not as the method term. |
| **Logical** | Responsibilities expressed mainly as actions (and optionally parts) before or apart from technology choice. | SysML v1 BDD / “logical architecture package” as a mandatory duplicate tree. |
| **Physical** | Selected implementation baseline (hardware, software, people, mechanics). | “Only CAD” — firmware and software parts count as physical realization. |
| **Operational / system / logical / physical levels** | Orientation layers; not mandatory waterfall phases. | A required sequence of model areas. |
| **Stakeholder need** | Desired outcome in the stakeholder's operating or lifecycle context. | A specified system obligation. |
| **Customer/stakeholder requirement** | Obligation supplied or agreed by a stakeholder, possibly contractual; preserve its source and scope. | Necessarily an informal or imprecise statement. |
| **System requirement** | Engineering obligation on the system of interest, with explicit subject, conditions, and acceptance criteria. | A duplicate of every customer requirement. |
| **Stakeholder validation** | Evaluation of whether the system achieves stakeholder needs in intended use. | Verification of specified requirements alone. |
| **Subject** | The model element a requirement or case constrains or evaluates. | A document section title. |
| **Satisfy** | Asserts that an element fulfills a requirement’s subject constraints. | Informal “we think this is fine.” |
| **Allocate** | Maps behavior (or other source) to a realizing part. | Copy-paste of the same function into a second architecture layer. |
| **Verify** | Links a verification case objective to a requirement. | Having a test plan document alone. |
| **Evidence URI** | Reference (`VerificationEvidence.evidenceUri`) to external proof. | Storing full test datasets inside the SysML model. |
| **View / viewpoint** | Projection of the model for stakeholders; viewpoint states framed concerns. | A separate “diagram file” that is itself the source of truth. |
| **Definition / usage** | Type vs occurrence in SysML v2. | UML class vs instance only — usages are broader (roles, configurations). |
| **Area tailoring** | Use content separately, merge it, or omit it with a short explanation in package or project notes. | Mandatory completion or disposition tags. |
| **Domain library** | Vocabulary for things in the system, supplied locally or through selected domain libraries. | Method libraries (`mbse-methodology`). |
| **Method library** | How Elan8 expects models to be authored and assured (`Elan8Method` packages). | Product physics or protocol vocabularies. |
