# New Elan8 project

Copy this directory and rename `Product` in `model/60_systems/Product/system.sysml`. Load the complete `model/` tree and the shared Elan8 domain-library dependency.

The numbered folders organize content; use whichever modeling sequence suits the project. Define context, optional scenarios and stakeholder requirements in their areas. Keep each system's specification, architecture, integration, behavior, analysis, verification and views together. Add developed subsystems as siblings under `60_systems`.

The [four view recipes](../../docs/views.md) explain the reusable view types, exposes and inherited filters already used here. Add behavior or verification views only when useful. `80_documents` contains separate content-selection seeds; document generation needs a document library/generator binding.

`project.md` is an optional setup note. The forms in `templates/records` are optional; Elan8 requires no increment records or gates. Empty packages and TODOs are prompts, not completed contracts or evidence.

Configure the sibling `sysml-domain-libraries/model` source or pass an explicit dependency path. Pin its revision/local changes until an artifact containing the roles/views is released. Do not copy shared definitions into this model.

Run the language checker and inspect the selected relationships/views. `Product::Integration::candidate` is an incomplete draft. Keep generated outputs outside `model/`.
