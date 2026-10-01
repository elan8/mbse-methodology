# Tailoring model content

Choose the minimum content that answers the current engineering question. The six [model areas](model-areas.md) provide navigation; there is no project-wide size profile, mandatory area completion, or disposition metadata.

- **Use separately** when an area provides distinct engineering information.
- **Merge** useful content into another area when a separate model would duplicate it. Explain where the content lives and why.
- **Omit content** when it adds no value to the scope. Explain the reason briefly; distinguish an intentional omission from work still to be done.

Record explanations in package documentation or project notes. Keep the template's familiar placeholders when useful for navigation; they do not require duplicated content. Do not classify every element or maintain a matrix of concerns and areas.

Requirements remain canonical in `05_requirements`, even when architecture content is merged. A small controller may allocate functions directly to physical components and explain that Logical is unused. The [elevator example](../examples/elevator/README.md) benefits from separate fleet-dispatch and local-control responsibilities, so all six areas contain useful content.

Choose depth from the question, uncertainty and risk. Add interface contracts, degraded scenarios, quantitative analysis or richer views when needed. Merging an area does not waive critical obligations or evidence requirements. Review the result with the [increment checklist](increment-review.md).
