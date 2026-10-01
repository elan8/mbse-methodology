# Abstraction levels

Operational, system, logical and physical are useful words for explaining how concrete model content is. They are not another workflow, mandatory model layers or metadata tags.

| Level | Question | Typical content |
| --- | --- | --- |
| Operational | What must be achieved in the real world? | Stakeholder outcomes, context and operational scenarios |
| System | What must the system do at its boundary? | System obligations, behavior and external interfaces |
| Logical | Which responsibilities and collaborations are needed? | Technology-independent responsibilities and interface contracts |
| Physical | What implements the solution? | Selected hardware, software, mechanics and implementation interfaces |

A [model area](model-areas.md) is a navigation location; an abstraction level describes its content. They need not match one-to-one. A physical baseline may be the starting point for a question that leads back to stakeholder needs.

A parallel logical part tree is optional. Allocate actions directly to physical parts when sufficient, or introduce logical responsibilities when they clarify collaboration or alternatives. Explain merged or unused content with a short note, following [tailoring](tailoring.md). Allocation connects behavior and structure; it does not require duplicated layers.
