# Recipe: Create a logical architecture

## Engineering question

Which responsibilities and collaborations are needed before (or apart from) choosing technologies?

## Expected input

- System requirements and key scenarios
- Context / system boundary

## Recommended steps

1. List responsibilities implied by critical scenarios (as candidate `action` usages or nested actions under a system operate action).
2. Optionally group collaborations into logical `part` usages — only if that clarifies ownership; **not mandatory**.
3. Define the main logical interfaces (ports/items) between responsibilities.
4. `allocate` actions to parts when a realizing structure exists (or will exist).
5. Record open technology choices as assumptions or defer to a decision recipe.
6. Tag with `@EngineeringConcern { concern = architecture; }` and `@AbstractionLevel { level = logical; }` when useful.

## SysML v2 concepts used

- `action` / `part` / `port` / `allocate`
- `Elan8::Method` metadata
- See [abstraction-levels](../docs/abstraction-levels.md)

## Minimum required output

- Named functional decomposition (actions) covering the increment
- At least one allocation to structure **or** an explicit note that physical baseline is next
- Critical collaboration boundaries identified

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| Actions under one operate usage; allocate straight to physical parts | Optional logical parts + interfaces before technology selection |
| Skip parallel logical tree | Document logical interface stability for multi-team work |

## Example

```sysml
action def OperateRobot {
    action sense;
    action supervise;
    action move;
}

part def RobotSystem {
    perform action operate : OperateRobot;
    part sensors;
    part controller;
    part drive;
    allocate operate.sense to sensors;
    allocate operate.supervise to controller;
    allocate operate.move to drive;
}
```

Cross-link: robot-vacuum `Architecture::robotSystem` allocates `operate` steps to physical LRUs.

## Quality checks

- QR-ARCH-03: responsibilities allocate where applicable
- Avoid duplicating the same function as both a full logical part tree and physical tree without need

## Common mistakes

- Forcing a complete logical BDD-style tree for a small product
- Logical “parts” that are secretly technology choices (MCU, ROS node) without saying so
