00_context: Define system scope and system context
10_usecases: Define usecases (optional)
20_requirements: Stakeholder requirements
50_library: Reusable elements, e.g. coordinate frames, parts that are used in multiple subsystems, etc.
60_systems: This folder contains the main system and its subsystems , by default as a flat folder structure.
Each (sub)system folder by default contains 1 file (system.sysml) for the BB/GB/WB decomposition, ports, behavior, system views, etc . If needed more files can be added if 1 file becomes to big: make those available in the package of the (sub)system itself.
80_documents: Here we define documents in SysML that can be used by tooling to automatically generate documents like CRS, SRS, SDS, etc.

The method roles are defined in https://github.com/elan8/sysml-domain-libraries in the package Elan8::SystemsEngineering
