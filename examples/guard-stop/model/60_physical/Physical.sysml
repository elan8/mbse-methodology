package GuardStopPhysical {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::physicalArchitecture; status = StageStatusKind::applicable; rationale = "Populated for the guard-stop increment.";  }
    private import GuardStopTypes::*;
    private import GuardStopRequirements::*;
    private import GuardStopFunctions::*;
    part controller : Controller {
        @DecisionRecord { decisionId = "DEC-001"; title = "One controller owns detection and inhibition"; rationale = "A single controller gives one measurable input-to-output response boundary for this teaching example."; }
    }
    allocate detectStopDemand to controller;
    allocate disableDrive to controller;
    satisfy removeDriveEnable by controller;
    doc /* Satisfaction is a design claim, not a recorded test result. Public ports define the selected controller boundary; external wiring is outside this example. */
}
