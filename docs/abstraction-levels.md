# Abstraction levels

The method uses four common abstraction levels to orient individual model
elements: Operational, System, Logical, Physical. They are a semantic tag,
not a folder — do not confuse them with the seven fixed [stage
packages](../templates/project-template/README.md) (`10_context` …
`80_verification`) that structure every project.

- **Stage** (`StageDisposition`) is *where a package sits in the fixed
  pipeline* — Context, Use Cases, Capabilities, Functions, Logical
  Architecture, Physical Architecture, Verification. Every project has all
  seven packages; see [engineering-increments.md](engineering-increments.md).
- **Abstraction level** (`AbstractionLevel`) is *how concrete a piece of
  content is* — it can be tagged on any element, in any stage package, when
  that helps orient a reader. It is not mandatory and not sequential.

| Level | Central question | Typical content | Falls mostly in stage(s) |
| --- | --- | --- | --- |
| Operational | What must be achieved in the real world? | Stakeholders, context, operational scenarios, needs | Context, Use Cases |
| System | What must the system do as a black box? | System behavior, external interfaces, system requirements | Use Cases, Capabilities, Functions |
| Logical | Which responsibilities and collaborations are needed? | Logical functions, optional logical components, logical interfaces | Logical Architecture |
| Physical | How is the solution implemented? | Hardware, software, mechanics, people, physical interfaces | Physical Architecture |

Tag elements with `@AbstractionLevel` from `Elan8::Method::Core` when useful.
Do not require every element to carry a level tag, and do not expect a
one-to-one match between level and stage package — a Functions package will
often mix Operational and System-level content, for example.

## Flexible logical vs physical content

The `50_logical` and `60_physical` packages always exist (see the [project
template](../templates/project-template/README.md)), but how much they
contain, and how independent they are from each other, is a project tailoring
choice recorded with `StageDisposition`:

- **Logical** means responsibilities expressed as `action` (and optionally
  `part`) as needed.
- A **parallel logical-part tree is optional**. Many projects allocate
  behavior directly to physical parts — in that case, set
  `@StageDisposition { stage = logicalArchitecture; status =
  mergedIntoAnotherStage; mergedInto = physicalArchitecture; rationale = "…";
  }` on `50_logical/Logical.sysml` rather than leaving it silently empty.
- **Physical** means the selected implementation baseline when technology
  choices matter.
- Small projects may **merge Functions into Logical Architecture**, or
  Logical into Physical, the same way — an explicit `StageDisposition`, not
  an omitted folder.
- Existing product platforms may begin with a **Physical** baseline and work
  upward; mark the earlier stages `notApplicable` with a rationale until they
  are populated retroactively, or `applicable` once they are.
- **Allocation** (`allocate` behavior → parts) is the required bridge between
  behavior and structure — not mandatory layer duplication.

This matches lean SysML v2 practice (for example the robot-vacuum showcase)
while still allowing richer logical architectures when the project needs
them, and it keeps the folder shape identical across every project.

## Tailoring rules

- every stage package exists in every project; whether it is populated,
  merged, or not applicable is recorded with `StageDisposition`, not with a
  missing folder;
- not every element must carry an `@AbstractionLevel` tag;
- abstraction levels may be exercised in parallel within and across stages;
- traceability should capture engineering meaning, not administrative
  completeness;
- duplication between logical and physical content should be minimized —
  prefer `mergedIntoAnotherStage` over parallel, redundant modeling.
