# Recipe: Define the system context

## Engineering question

What is inside the system boundary, and which external actors or systems interact with it?

## Expected input

- Draft purpose and stakeholder list ([define-system-purpose](define-system-purpose.md))
- Known external systems, users, and environment elements

## Recommended steps

1. Declare the system of interest as a `part` (black box).
2. Model external actors and systems as parts (or items) outside the SOI.
3. Define the main external interfaces as `port` / `interface` usages—even if coarse.
4. Capture context exchanges as connections or flows at a high level.
5. Expose the context in a view that satisfies `MissionAndContextViewpoint`.

## SysML v2 concepts used

- `part def` / `part`
- `port` / `interface` (lightweight)
- `connection` / `flow`
- `Elan8Viewpoints::MissionAndContextViewpoint`
- `@AbstractionLevel { level = operational; }` or `system` as appropriate

## Minimum required output

- Named SOI part
- At least two external actors/systems
- One documented system boundary (`doc` or concern)
- Coarse external interaction list

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| SOI + actors as parts, narrative boundary | Typed external ports/interfaces for each actor |
| Skip formal MissionAndContext view | Dedicated context view satisfying Elan8 viewpoint |

## Quality checks

- QR-ARCH-01: external interactions intended to pass through ports/interfaces
- Context can be explained on one page / one view

## Example

```sysml
package Context {
    import Elan8Method::*;
    import Elan8Viewpoints::*;

    part def HouseholdUser;
    part def MobileApp;
    part def HomeEnvironment;
    part def FloorCleaningRobot;

    part context {
        @EngineeringConcern { concern = purpose; }
        @AbstractionLevel { level = operational; }
        part user : HouseholdUser;
        part app : MobileApp;
        part home : HomeEnvironment;
        part robot : FloorCleaningRobot;
        doc /* Robot is the SOI; user, app, and home are external. */
    }

    view contextOverview : MissionAndContextView {
        expose context;
        expose context.user;
        expose context.app;
        expose context.home;
        expose context.robot;
    }
}
```

## Common mistakes

- Putting the entire product breakdown in the context diagram
- Omitting environment elements that drive safety or performance
- Encoding identity as strings instead of typed parts/ports
