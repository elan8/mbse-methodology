# Sources, baseline and terminology

## Baseline

The intended language baseline is OMG SysML v2.0, Part 1, document `formal/2026-03-02` (March 2026), with matching KerML and standard libraries. See the [OMG SysML specification page](https://www.omg.org/spec/SysML/2.0) and [official release artifacts](https://github.com/Systems-Modeling/SysML-v2-Release). Pin the exact tool/library artifact revisions in each project; naming a language version alone does not pin a workspace.

Friedenthal and Muxen's [A SysML V2 Modeling Pattern for Recursive System Decomposition](https://www.incose.org/wp-content/uploads/2026/10/A_SysML_V2_Modeling_Pattern_for_Recursive_System_Decompostion_Presentation.pdf), particularly slides 7–12, is the conceptual starting point for role separation and contextual reconciliation. It is informative methodology material, not the normative language definition. Elan8 adds modeling conventions, folder organization and four implementation-oriented view recipes; development workflow remains a project choice.

The archive `BAK/` contains the previous methodology. It is not normative for this restart. Existing global function/logical/physical folder schemes in other projects are migration inputs, not constraints on the new system-owned layout.

## Vocabulary

| Term | Elan8 meaning |
|---|---|
| System | Subject with a meaningful engineering boundary, including a subsystem |
| Contract | Observable obligations, assumptions and interfaces agreed at that boundary |
| Specification / black box | Contract representation independent of constituent implementation |
| Architecture / grey box | Proposed realization through constituent contracts and responsibilities |
| Integration / white box | Configuration selecting and reconciling constituent designs |
| Integration activity | Work assembling/evaluating designs; distinct from an integration definition |
| Definition | Reusable classifier such as a system design |
| Usage | Contextual occurrence/role typed by a definition |
| Contextual obligation | Requirement imposed on a usage by its consuming system |
| Baseline | Identified model configuration, revisions, dependencies and reviewed disposition |
| Satisfaction | Claim that a subject meets an obligation |
| Verification | Evidence-based assessment against specified requirements |
| Validation | Assessment of fitness for stakeholder use |
| Viewpoint | Stakeholder concerns and rules for a view |
| View | Projection answering a question about authoritative model content |
| Leaf | Deliberate stopping point for decomposition, with acceptance responsibility retained |

Box role, logical/physical abstraction, maturity and lifecycle stage are separate dimensions. An architecture may be logical or physical. An integration may be preliminary or released. None of these names implies verified compliance.
