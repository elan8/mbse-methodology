# Glossary

Terms as used in the Elan8 Method. Where SysML v2 already defines a word, that meaning wins for model elements.

| Term | Elan8 / SysML meaning | Not to be confused with |
| --- | --- | --- |
| **Engineering concern** | One of six continuous method perspectives (purpose, behavior, architecture, evidence, verification, evolution). Tagged with `@EngineeringConcern`. | A SysML `concern` element (stakeholder concern framed by viewpoints). Both may appear in one project. |
| **SysML `concern`** | First-class model element stating a stakeholder interest, often framed by a viewpoint. | Elan8 engineering concern metadata. |
| **Engineering increment** | A reviewable, vertical model change (typically one PR) that addresses one engineering question and connects the needed concerns through need → scenario → requirement → architecture → analysis → verification → decision. Scoped in Git/PR and clear naming — **not** SysML process metadata. | An agile sprint (timebox). An increment may span one or more sprints. “Golden thread” may appear as an example scenario name (e.g. `CliffSafeStopGoldenThread`), not as the method term. |
| **Logical** | Responsibilities expressed mainly as actions (and optionally parts) before or apart from technology choice. | SysML v1 BDD / “logical architecture package” as a mandatory duplicate tree. |
| **Physical** | Selected implementation baseline (hardware, software, people, mechanics). | “Only CAD” — firmware and software parts count as physical realization. |
| **Operational / system / logical / physical levels** | Orientation layers; not mandatory waterfall phases. | Arcadia OA/SA/LA/PA as fixed sequential gateways (similar ideas, softer rules here). |
| **Subject** | The model element a requirement or case constrains or evaluates. | A document section title. |
| **Satisfy** | Asserts that an element fulfills a requirement’s subject constraints. | Informal “we think this is fine.” |
| **Allocate** | Maps behavior (or other source) to a realizing part. | Copy-paste of the same function into a second architecture layer. |
| **Verify** | Links a verification case objective to a requirement. | Having a test plan document alone. |
| **Evidence URI** | Reference (`VerificationEvidence.evidenceUri`) to external proof. | Storing full test datasets inside the SysML model. |
| **View / viewpoint** | Projection of the model for stakeholders; viewpoint states framed concerns. | A separate “diagram file” that is itself the source of truth. |
| **Definition / usage** | Type vs occurrence in SysML v2. | UML class vs instance only — usages are broader (roles, configurations). |
| **Tailoring profile** | `small` / `medium` / `regulated` recorded in `ProjectInfo`. | Skipping all modeling for “agile.” |
| **Domain library** | Vocabulary for things in the system (`sysml-domain-libraries`). | Method libraries (`mbse-methodology`). |
| **Method library** | How Elan8 expects models to be authored and assured (`Elan8*` packages). | Product physics or protocol vocabularies. |
