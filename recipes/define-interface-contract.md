# Recipe: Define an interface contract

## Engineering question

What must remain stable at a boundary between parts or systems?

## Expected input

- Interacting parts (context or architecture)
- Items / signals / energy that cross the boundary

## Recommended steps

1. Name the boundary and the two ends (supplier / consumer).
2. Define reusable `item def` (or attribute) types for what flows or is shared.
3. Define a `port def` and/or `interface def` with directed features.
4. Use conjugate ports (`~PortDef`) where directions reverse.
5. Connect with `interface` / `connect` / `flow` in the owning context.
6. Prefer library types over anonymous inline items on **public** boundaries.

## SysML v2 concepts used

- `item def`, `port def`, `interface def`, `flow`, conjugate `~`
- Domain/technical libraries for shared vocabulary when available

## Minimum required output

- At least one named port or interface definition used by two parts
- Typed items on directed features

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| One critical external interface typed | Interface defs for all public subsystem boundaries |
| Inline ports acceptable inside private assemblies | Reusable port/item library in `90_library` or domain libs |

## Example

```sysml
item def CliffObservation;
port def CliffSensePort {
    out item observation : CliffObservation;
}

part sensorAssy { port cliffOut : CliffSensePort; }
part supervisor { port cliffIn : ~CliffSensePort; }

interface cliffSense
    connect cliffOut ::> sensorAssy.cliffOut
         to cliffIn ::> supervisor.cliffIn;
```

## Quality checks

- QR-ARCH-01, QR-ARCH-02
- Unconnected public ports reported (QR-ARCH-04)

## Common mistakes

- Stringly-typed payloads (`attribute msg : String`) on public APIs
- Ports without item/attribute features (“empty sockets”)
