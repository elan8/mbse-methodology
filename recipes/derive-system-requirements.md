# Recipe: Derive system requirements

## Engineering question

Which testable system requirements follow from stakeholder needs and scenarios?

## Expected input

- User needs with `@RequirementRole { role = user; }`
- At least one operational scenario
- Design limits or quantitative targets when known

## Recommended steps

1. For each critical user need, derive one or more system requirements (`@RequirementRole` = `system`, `functional`, `performance`, `safety`, …).
2. Give each system requirement a `subject` and a `require constraint` when measurable.
3. Connect need → system requirement with `#derivation connection`.
4. Add `@RequirementIdentity` stable IDs.
5. Set `@StatusInfo` appropriately; approved/critical requirements should plan verification next.
6. Prefer ISQ/SI quantities over ad-hoc numbers without units.

## SysML v2 concepts used

- `requirement` with `subject`, `assume`, `require constraint`
- `#derivation connection`
- `Elan8RequirementMetadata`, `Elan8RequirementManagement`
- `ModelingMetadata::StatusInfo`
- ISQ/SI quantity types

## Minimum required output

- At least one derived system requirement per critical user need in the increment
- Derivation links
- Subject declared on system requirements

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| Role + identity + subject + constraint on critical reqs | Full need set derived; StatusInfo workflow |
| Verification planned next | Verification cases in same increment |

Cross-link: robot-vacuum `StakeholderNeeds` → `SystemRequirements` cliff/safety requirements.

## Quality checks

- QR-REQ-01: approved requirements have a subject
- QR-REQ-04: measurable requirements have quantities/units/criteria
- QR-REQ-05: derived requirements trace to source

## Example

```sysml
package SystemRequirements {
    private import ISQ::*;
    import Elan8RequirementMetadata::*;
    import Elan8RequirementManagement::*;
    import ModelingMetadata::*;

    part def CleaningRobot;

    requirement operateSafely {
        @RequirementRole { role = user; }
        @RequirementIdentity { requirementId = "USR-SAFE-001"; }
        doc /* The product shall be safe for unattended operation. */
    }

    requirement stopOnCliff {
        subject robot : CleaningRobot;
        @RequirementRole { role = safety; }
        @RequirementIdentity { requirementId = "SYS-SAFE-010"; }
        @StatusInfo { status = inProgress; }
        attribute maxReactionTime : TimeValue = 200 [ms];
        require constraint { robot.cliffReactionTime <= maxReactionTime }
        doc /* The robot shall stop after cliff detection within maxReactionTime. */
    }

    #derivation connection {
        end #original ::> operateSafely;
        end #derive ::> stopOnCliff;
    }
}
```

## Common mistakes

- System requirements that are still stakeholder wishes (not testable)
- Missing subjects or constraints on quantitative requirements
- Derivation only in documents, not in the model
