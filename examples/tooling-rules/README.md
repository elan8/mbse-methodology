# Executable tooling rule examples

The model is language-valid SysML containing intentional method violations. `expected.json` specifies the findings checked by `scripts/test_structure.py` against a live semantic export.

The 21 named cases cover ordinary/reference parts in BB, missing actual contracts, design-typed GB children, bare marker typing, inherited selections, extra WB composition, optional and zero-multiplicity children, recursive selected designs, nested grey/partial-white selections and complete nested integration. Multiple actual bases are accepted by default and optionally receive a style warning.

`ValidBB` includes a port/attribute and `ValidGB` a connection; these must not be mistaken for constituents. The native `partsOnly` view exercises the connection-exclusion regression.

Run the commands in [tooling](../../docs/library-and-tooling.md). Eight test methods cover all cases in default, complete-selection and optional-style modes, reject truncated/language-error exports, inspect the prepared parts-only view, and check the connected example's contract binding, behavior realization and complete structural selection.

The reference checker currently assesses structural definitions. Root usage-local overrides, contextual constraint evaluation and evidence remain unassessed and are reported as such. Narrative additional cases in the JSON identify work for a richer adapter; they are not claimed as executed coverage.
