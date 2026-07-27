# Recipe: Capture stakeholder concerns

## Engineering question

Which stakeholder concerns and risks must the design address, and who cares about them?

## Expected input

- Purpose and context
- Stakeholder interviews, complaints, regulations, or prior incident notes

## Recommended steps

1. Introduce stakeholder roles as parts (or reuse context actors).
2. Capture each major concern as a SysML `concern` with `subject` and `stakeholder`.
3. Link concerns to user needs via `frame` on requirements, or document the relationship in `doc` + derivation later.
4. Annotate severity or method concern with `@Risk` / `@EngineeringConcern` when helpful.
5. Keep the concern set small; prefer depth on the few that drive architecture.

## SysML v2 concepts used

- `concern`
- `stakeholder`
- `requirement` with `frame concern …` (when appropriate)
- `Elan8Method` metadata
- `Elan8RequirementMetadata`

## Minimum required output

- At least three named concerns with stakeholders
- Trace from each concern to at least one user need or decision to defer

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| Few SysML `concern`s framed by key needs | Concern set reviewed with stakeholders; framed requirements |
| Skip severity metadata | `@Risk` on drivers that force architecture |

## Quality checks

- Concerns name a subject
- Stakeholders are identifiable roles, not anonymous

## Example

```sysml
package StakeholderConcerns {
    import Elan8RequirementMetadata::*;
    import Elan8Method::*;

    part def Homeowner;
    part homeowner : Homeowner;

    concern unattendedSafety {
        doc /* The robot must not create hazards when operating without supervision. */
        subject;
        stakeholder :>> homeowner;
    }

    requirement operateSafely {
        @RequirementRole { role = user; }
        @RequirementIdentity { requirementId = "USR-SAFE-001"; }
        @EngineeringConcern { concern = purpose; }
        frame concern unattendedSafety;
        doc /* The product shall be safe for unattended operation in a typical home. */
    }
}
```

## Common mistakes

- Listing dozens of concerns with no prioritization
- Concerns without stakeholders
- Treating concerns as detailed system requirements too early
