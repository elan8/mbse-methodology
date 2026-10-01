# SysML v2 primer for Elan8 Method

A short orientation for people new to SysML v2 who will use the Elan8 Method. This is not a full language reference.

## 1. The model is the text

In SysML v2 the textual notation is the source of truth. Diagrams and tables are **views** over the same model. Prefer editing `.sysml` files; generate views for stakeholders.

## 2. Definition vs usage

Almost every construct comes in two forms:

| Form | Example | Meaning |
| --- | --- | --- |
| Definition | `part def CleaningRobot { … }` | Reusable type / kind |
| Usage | `part robot : CleaningRobot;` | Occurrence / role in a context |

The same pattern applies to `action`, `requirement`, `port`, `item`, `view`, and more. Learn it once; it applies everywhere.

```sysml
part def Sensor;
part def Robot {
    part cliffSensor : Sensor;   // usage typed by Sensor
}
```

## 3. Requirements are evaluable

A requirement is a constraint on a **subject**, not a text box.

```sysml
requirement <'SYS-SAFE-010'> stopOnCliff {
    subject robot : CleaningRobot;
    attribute maxReactionTime : ISQ::TimeValue;
    require constraint { robot.cliffReactionTime <= maxReactionTime }
}
```

The native short name (`SYS-SAFE-010` above) is the requirement identifier. Elan8 optionally adds role metadata (see `Elan8Method::Metadata`):

```sysml
@RequirementRole { role = RequirementRoleKind::safety; }
```

Use OMG `@StatusInfo` for work status. See [requirements guidance](requirements.md).

## 4. Traceability relationships

| Relationship | Intent |
| --- | --- |
| `#derivation connection` | Need → derived system requirement |
| `satisfy … by …` | Requirement held by a model element (often behavior or structure) |
| `allocate … to …` | Behavior / function → realizing part |
| `verify` (in a verification case objective) | Requirement checked by a verification case |

Keep these as semantic model links, not path strings in attributes.

## 5. Behavior and structure

- **Functions** → prefer `action def` / `action` usages.
- **Structure** → `part def` / `part`, with `port` / `interface` / `connection` / `flow` for boundaries.
- Bridge them with **`allocate`**. A separate logical-part tree is optional (see [abstraction-levels](abstraction-levels.md)).

## 6. Views vs model content

```sysml
viewpoint MissionAndContextViewpoint { frame missionAndContext; }

view contextOverview : Views::View {
    satisfy MissionAndContextViewpoint;
    expose context;
}
```

Views **expose** existing elements; they must not duplicate handoff tables or restate the architecture. Elan8 provides five standard viewpoints in `Elan8Method::Viewpoints`.

## 7. Packages and libraries

- Organize by **engineering concern** folders (`10_context`, `20_usecases`, …), but packages own semantics.
- Import **method** packages from `mbse-methodology/library`.
- Keep **domain/technical** vocabulary in the project-local library or explicitly selected external libraries.

## 8. Where to go next

1. [principles](principles.md) and [concerns](concerns.md)
2. Project [template](../templates/project-template/)
3. [Workflow](workflow.md) and [modeling guidance](README.md)
4. Explore the [guard-stop example](../examples/guard-stop/README.md).
