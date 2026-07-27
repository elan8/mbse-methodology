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
requirement stopOnCliff {
    subject robot : CleaningRobot;
    attribute maxReactionTime : ISQ::TimeValue;
    require constraint { robot.cliffReactionTime <= maxReactionTime }
}
```

Elan8 adds role and identity metadata (see `Elan8RequirementMetadata`):

```sysml
@RequirementRole { role = safety; }
@RequirementIdentity { requirementId = "SYS-SAFE-010"; }
```

Use OMG `@StatusInfo` for work status. Recipe: [derive-system-requirements](../recipes/derive-system-requirements.md).

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

view contextOverview : GeneralView {
    satisfy MissionAndContextViewpoint;
    expose context;
}
```

Views **expose** existing elements; they must not duplicate handoff tables or restate the architecture. Elan8 provides five standard viewpoints in `Elan8Viewpoints`.

## 7. Packages and libraries

- Organize by **engineering concern** folders (`10_purpose`, `20_behavior`, …), but packages own semantics.
- Import **method** packages from `mbse-methodology/library`.
- Import **domain/technical** vocabulary from `sysml-domain-libraries`.

## 8. Where to go next

1. [principles](principles.md) and [concerns](concerns.md)
2. Project [template](../templates/project-template/)
3. Recipes starting with [define-system-purpose](../recipes/define-system-purpose.md)
4. Optional: robot-vacuum [Elan8 method tour](../../sysml-robot-vacuum-cleaner/docs/ELAN8_METHOD_TOUR.md) (sibling repo)
