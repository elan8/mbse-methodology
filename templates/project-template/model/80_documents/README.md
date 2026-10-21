# Controlled document definitions

`Documents.sysml` supplies native content-selection seeds for CRS, SRS and SDS.

- CRS selects stakeholder/customer obligations and project context.
- SRS selects system specifications/requirements and applicable interfaces.
- SDS selects chosen architecture/integration, behavior, analyses and decisions.

These identify sources; they are not executable document templates. Choose and pin a document library/generator (for example Doc42), then define actual document views, sections, ordering, prose and output configuration here. Reference authoritative elements and system views instead of copying engineering content. Include source baseline/configuration and coverage/evidence limitations.

Store generated documents outside `model/`, normally in `generated/`. Record the generation command and binding version in `project.md`.
