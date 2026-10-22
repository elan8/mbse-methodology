package ProjectDocuments {
    doc /* Native content-selection seeds, not executable document templates.
         * Bind to a pinned document library/generator before generating CRS/SRS/SDS. */
    view customerRequirementsContent : StandardViewDefinitions::GeneralView {
        expose ProjectStakeholderRequirements::**;
        expose ProjectContext::**;
    }
    view systemRequirementsContent : StandardViewDefinitions::GeneralView {
        expose Product::ProductSpecification;
        expose Product::Requirements::**;
    }
    view systemDesignContent : StandardViewDefinitions::GeneralView {
        expose Product::ProductArchitecture;
        expose Product::ProductIntegration;
        expose Product::candidate;
    }
}
