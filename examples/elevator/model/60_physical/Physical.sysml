package ElevatorPhysical {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::physicalArchitecture; status = StageStatusKind::applicable; rationale = "Distinct content for the two-elevator example."; }
    private import ElevatorTypes::*;
    part service : InstalledService {
        @DecisionRecord { decisionId = "DEC-001"; title = "Central dispatch with local car control"; rationale = "One fleet view supports two-car assignment; local controllers own motion and door execution. Protection requires further independence analysis."; }
        @Risk { riskId = "RISK-001"; description = "Group-controller outage can interrupt new assignments; recovery and local protective behavior need separate analysis."; severity = "Unassessed teaching risk"; }
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
