package ElevatorDocuments {
    doc /* Content selections only; no document generator binding is selected. */
    view customerRequirementsContent : StandardViewDefinitions::GeneralView {
        expose ElevatorStakeholderRequirements::**;
        expose ElevatorContext::**;
    }
    view systemRequirementsContent : StandardViewDefinitions::GeneralView {
        expose Elevator::Specification::**;
    }
    view systemDesignContent : StandardViewDefinitions::GeneralView {
        expose Elevator::Architecture::**;
        expose Elevator::Integration::**;
    }
}
