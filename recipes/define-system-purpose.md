# Recipe: Define the system purpose

## Engineering question

Why does the system exist, and what outcomes must it achieve?

## Expected input

- Problem statement or opportunity brief
- Known stakeholders (even if incomplete)
- Initial scope hypothesis (in/out of scope)

## Recommended steps

1. State the system of interest in one sentence.
2. List primary stakeholders and their success criteria.
3. Capture top-level needs as `requirement` usages with `@RequirementRole { role = user; }`.
4. Record open risks or drivers with `@Risk` / `@Assumption` if already known.
5. Tag the purpose package or key elements with `@EngineeringConcern { concern = purpose; }`.

## SysML v2 concepts used

- `requirement` usages
- `Elan8RequirementMetadata` (`@RequirementRole`, `@RequirementIdentity`)
- `Elan8Method` (`@EngineeringConcern`, optional `@Assumption` / `@Risk`)
- `doc` comments for narrative purpose

## Minimum required output

- One purpose statement (`doc` on a package or concern)
- At least one stakeholder-facing need requirement
- Explicit in/out of scope notes in `00_project` or purpose package

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| One sentence purpose + few user needs | Stakeholder map, MoEs, explicit out-of-scope list |
| Optional risk tags | Structured risks/assumptions for drivers |

## Quality checks

- QR-REQ-02: approved needs have an owner path
- Purpose statement is reviewable without reading the whole model

## Example

```sysml
package Purpose {
    import Elan8RequirementMetadata::*;
    import Elan8Method::*;
    import ModelingMetadata::*;

    doc /* Purpose: enable unattended floor cleaning in a home without damaging furniture or people. */

    requirement cleanFloorsUnattended {
        @RequirementRole { role = user; }
        @RequirementIdentity { requirementId = "USR-PURPOSE-001"; }
        @EngineeringConcern { concern = purpose; }
        @StatusInfo { status = inProgress; }
        doc /* The household shall obtain clean floors with minimal operator intervention. */
    }
}
```

## Common mistakes

- Writing a long vision document with no model elements
- Mixing implementation choices into the purpose statement
- Skipping stakeholder needs and jumping to physical parts
