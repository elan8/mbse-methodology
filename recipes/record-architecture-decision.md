# Recipe: Record an architecture decision

## Engineering question

What did we decide, what alternatives existed, and what is the rationale?

## Expected input

- A choice that affects interfaces, technology, or verification
- Optional evaluation notes from the alternatives recipe

## Recommended steps

1. Assign a stable `decisionId`.
2. Annotate the owning definition/usage with `@DecisionRecord` (title, rationale, status).
3. Link related assumptions/risks.
4. Reference the decision in the PR description; merge records the approval in Git.
5. When the decision selects a catalog part, keep “kind of” (specialization) separate from “implemented by” (dependency), as in robot-vacuum `selectedImplementation`.

## SysML v2 concepts used

- `Elan8Method::DecisionRecord`
- `dependency` for implementation selection
- Git PR for process approval

## Minimum required output

- One DecisionRecord on the element that embodies the choice
- Rationale understandable without meeting notes

## Minimal vs medium

| Minimal (small) | Medium |
| --- | --- |
| DecisionRecord metadata | Decision log view + linked analysis |
| Rationale in metadata only | Also ADR markdown in repo `docs/adr/` if required by org |

## Example

```sysml
part def DriveModule {
    @DecisionRecord {
        decisionId = "ADR-DRIVE-002";
        title = "Differential drive with stall detection";
        rationale = "Meets cliff-stop timing with existing motor drivers";
        status = "accepted";
    }
}
```

## Quality checks

- QR-ARCH-05

## Common mistakes

- Decision only in chat history
- Annotating every trivial naming choice
