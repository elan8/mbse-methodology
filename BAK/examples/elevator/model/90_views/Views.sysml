package ElevatorViews {
    view mission { expose ElevatorContext::*; }
    view scenarios { expose ElevatorUseCases::*; expose ElevatorFunctions::*; }
    view architecture { expose ElevatorLogical::*; expose ElevatorPhysical::*; }
    view traceability { expose ElevatorNeeds::*; expose ElevatorStakeholderRequirements::*; expose ElevatorSystemRequirements::*; expose ElevatorFunctions::*; expose ElevatorLogical::*; expose ElevatorPhysical::*; expose ElevatorAnalysis::*; expose ElevatorVerification::*; }
    view readiness { expose ElevatorStakeholderRequirements::*; expose ElevatorSystemRequirements::*; expose ElevatorVerification::*; }
}
