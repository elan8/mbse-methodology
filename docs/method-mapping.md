# Method mapping (orientation)

Elan8 Method concerns and recipes compared to familiar MBSE approaches. This is **orientation**, not a claim of one-to-one equivalence.

| Elan8 concern | Typical recipes | SYSMOD (approx.) | OOSEM (approx.) | Arcadia (approx.) | INCOSE process flavor |
| --- | --- | --- | --- | --- | --- |
| Purpose | purpose, context, concerns | System idea, stakeholder needs | Stakeholder needs, context | Operational Analysis (need) | Stakeholder needs definition |
| Behavior | scenario, degraded behavior | Use cases / processes | Scenario analysis, logical behavior | System / Logical functions | System requirements & functional analysis |
| Architecture | logical architecture, interface, decision | System architecture | Logical → physical architecture | Logical / Physical Architecture | Architecture definition |
| Evidence | evaluate alternative | Trade-off / analysis | Analysis / trade studies | Early validation | Analysis & decision management |
| Verification | derive requirements, verification | Requirements & test | Verification planning | Integration & IVV hooks | Verification & validation |
| Evolution | (Git + quality rules) | Configuration / baselines | Iterative development | Model maintenance | Configuration & information management |

## Deliberate differences

- Elan8 organizes work as **continuous concerns** and **vertical increments**, not mandatory sequential layers.
- Logical architecture as a **parallel part tree is optional**; allocation from actions to parts is required.
- Textual SysML v2 + Git are first-class; diagrams are views.
- Method metadata stays light; process enforcement prefers PRs, CODEOWNERS, and CI.

## If you already use Arcadia or OOSEM

Keep your team’s mental model. Map Elan8 recipes onto the activities you already run, drop duplicated layer modeling where SysML v2 already connects behavior and structure, and adopt the project template when starting new SysML v2 work.
