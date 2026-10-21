package ProjectDocuments {
    doc /* Native content-selection seeds, not executable document templates.
         * Bind to a pinned document library/generator before generating CRS/SRS/SDS. */
    view customerRequirementsContent : StandardViewDefinitions::GeneralView {
        expose ProjectStakeholderRequirements::**;
        expose ProjectContext::**;
    }
    view systemRequirementsContent : StandardViewDefinitions::GeneralView {
        expose Product::Specification::**;
    }
    view systemDesignContent : StandardViewDefinitions::GeneralView {
        expose Product::Architecture::**;
        expose Product::Integration::**;
    }
}
