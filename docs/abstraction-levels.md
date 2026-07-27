# Abstraction levels

The method uses four common abstraction levels.

They provide orientation but are **not** mandatory sequential phases.

| Level | Central question | Typical content |
| --- | --- | --- |
| Operational | What must be achieved in the real world? | Stakeholders, context, operational scenarios, needs |
| System | What must the system do as a black box? | System behavior, external interfaces, system requirements |
| Logical | Which responsibilities and collaborations are needed? | Logical functions, optional logical components, logical interfaces |
| Physical | How is the solution implemented? | Hardware, software, mechanics, people, physical interfaces |

Tag elements with `@AbstractionLevel` from `Elan8Method` when useful. Do not require every element to appear at every level.

## Flexible logical vs physical

Default guidance:

- **Logical** means responsibilities expressed as `action` (and optionally `part`) as needed.
- A **parallel logical-part tree is optional**. Many projects allocate behavior directly to physical parts.
- **Physical** means the selected implementation baseline when technology choices matter.
- Small projects may **combine System and Logical**.
- Existing product platforms may begin with a **Physical** baseline and work upward.
- **Allocation** (`allocate` behavior → parts) is the required bridge between behavior and structure—not mandatory layer duplication.

This matches lean SysML v2 practice (for example the robot-vacuum showcase) while still allowing richer logical architectures when the project needs them.

## Tailoring rules

- not every element must appear at every level;
- levels may evolve in parallel;
- traceability should capture engineering meaning, not administrative completeness;
- duplication between levels should be minimized.
