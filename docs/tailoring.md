# Tailoring

The method must be tailorable. Record the chosen profile in `00_project` using `ProjectInfo` from `Elan8Method` (or an equivalent project note).

## Small project

Recommended minimum:

- system context;
- key scenarios;
- top-level requirements;
- simple architecture;
- critical interfaces;
- essential verification cases;
- decisions and assumptions;
- automated baseline checks.

Possible simplifications:

- combine System and Logical levels;
- limited viewpoint set;
- lightweight lifecycle metadata;
- no formal trade study unless needed.

## Medium project

Recommended additions:

- explicit logical and physical architecture where useful;
- interface contracts;
- structured analysis cases;
- risk and assumption tracking;
- verification coverage dashboards;
- baseline and release workflow;
- model ownership by subsystem.

## Large or regulated project

Recommended additions:

- formal lifecycle states;
- review and approval workflows;
- configuration and variant management;
- evidence provenance;
- explicit compliance viewpoints;
- controlled libraries;
- formal verification planning;
- release baselines;
- audit-ready change history.

Tailoring decisions should be recorded in the model or repository. Prefer Git for process enforcement; put engineering meaning in SysML.
