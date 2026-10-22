package ElevatorDocuments {
    doc /* Content selections only; no document generator binding is selected. */
    view customerRequirementsContent : StandardViewDefinitions::GeneralView {
        expose ElevatorStakeholderRequirements::**;
        expose ElevatorContext::**;
    }
    view systemRequirementsContent : StandardViewDefinitions::GeneralView {
        expose Elevator::ElevatorSpecification;
        expose Elevator::AcknowledgeCall;
        expose Elevator::AcknowledgementRequirement;
        expose Elevator::acknowledgement;
    }
    view systemDesignContent : StandardViewDefinitions::GeneralView {
        expose Elevator::ElevatorArchitecture;
        expose Elevator::RoutedAcknowledgement;
        expose Elevator::ElevatorReleaseAIntegration;
        expose Elevator::releaseA;
    }
}
