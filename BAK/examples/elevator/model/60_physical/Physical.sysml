package ElevatorPhysical {
    private import ModelingMetadata::Rationale;

    private import ElevatorTypes::*;
    part service : InstalledService {
        doc /* Decision DEC-001: central dispatch with local car control. Risk RISK-001 (unassessed teaching risk): a group-controller outage can interrupt new assignments; recovery and local protective behavior need separate analysis. */
        @Rationale { text = "DEC-001: one fleet view supports two-car assignment; local controllers own motion and door execution. Protection requires further independence analysis."; }
    }
    allocate ElevatorLogical::dispatchManager to service.group;
    allocate ElevatorLogical::carControlA to service.carA.controller;
    allocate ElevatorLogical::carControlB to service.carB.controller;
    allocate ElevatorLogical::doorManagement to service.carA.controller;
    allocate ElevatorLogical::doorManagement to service.carB.controller;
    allocate ElevatorLogical::protectiveSupervision to service.carA.controller;
    allocate ElevatorLogical::protectiveSupervision to service.carB.controller;
    satisfy ElevatorStakeholderRequirements::waitingTarget by service;
    satisfy ElevatorStakeholderRequirements::doorProtection by service;
    satisfy ElevatorSystemRequirements::callAcknowledgement by service;
    satisfy ElevatorSystemRequirements::obstructionResponse by service;
    satisfy ElevatorSystemRequirements::outageDispatch by service;
    doc /* Satisfaction declarations are design claims. Many-to-many logical realization is deliberate; common-cause failure and protective independence are unresolved. */
}
