package ElevatorViews {
    view mission { satisfy Elan8Method::Viewpoints::MissionAndContextViewpoint; expose ElevatorContext::*; }
    view scenarios { satisfy Elan8Method::Viewpoints::ScenarioViewpoint; expose ElevatorUseCases::*; expose ElevatorFunctions::*; }
    view architecture { satisfy Elan8Method::Viewpoints::ArchitectureViewpoint; expose ElevatorLogical::*; expose ElevatorPhysical::*; }
    view traceability { satisfy Elan8Method::Viewpoints::TraceabilityViewpoint; expose ElevatorNeeds::*; expose ElevatorStakeholderRequirements::*; expose ElevatorSystemRequirements::*; expose ElevatorFunctions::*; expose ElevatorLogical::*; expose ElevatorPhysical::*; expose ElevatorAnalysis::*; expose ElevatorVerification::*; }
    view readiness { satisfy Elan8Method::Viewpoints::VerificationReadinessViewpoint; expose ElevatorStakeholderRequirements::*; expose ElevatorSystemRequirements::*; expose ElevatorVerification::*; }
}
