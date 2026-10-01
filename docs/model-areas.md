# Model areas

Use these six areas to find and organize engineering content. They do not prescribe a development sequence or require an increment to fill every folder.

| Area | Practical question | Typical content |
| --- | --- | --- |
| Context (`10_context`) | Why is the system needed, for whom, and within what boundary? | Stakeholders, concerns, operating conditions, external systems and desired outcomes |
| Use Cases (`20_usecases`) | How do people and external systems interact with it? | Actor goals, conditions, nominal and degraded scenarios |
| Functions (`40_functions`) | What responsibilities must it perform? | Reusable actions, inputs, outputs and functional relationships |
| Logical Architecture (`50_logical`) | How should responsibilities collaborate, when a separate logical structure helps? | Responsibility boundaries, collaborations and interface contracts |
| Physical Architecture (`60_physical`) | What implements them? | Selected components, implementation interfaces and realization allocations |
| Verification (`80_verification`) | How will we evaluate obligations and intended outcomes? | Verification and validation plans, observations, verdicts and evidence references |

All canonical needs and requirements remain together in `05_requirements`. Analysis (`70_analysis`), views (`90_views`), project information (`00_project`) and local vocabulary (`99_library`) support the areas that need them. Folder numbers set browsing order, not activity order.

Use an area separately, merge its useful content into another area, or omit content when it adds no value. Explain a merge or omission briefly in package documentation or project notes; no disposition tag, size profile or completion status is needed. The template retains familiar folder locations as navigation placeholders. Do not duplicate content to fill them.

See [working steps](workflow.md), [tailoring](tailoring.md) and [increment review](increment-review.md).
