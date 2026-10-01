package GuardStopUseCases {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::useCases; status = StageStatusKind::applicable; rationale = "Populated for the guard-stop increment.";  }
    private import GuardStopContext::*;
    private import GuardStopTypes::*;
    private import GuardStopRequirements::*;
    use case accessGuardedArea {
        subject system : GuardStopTypes::Controller = specifiedController;
        actor user : Operator;
        objective {
            frame preventUnexpectedMotion;
            doc /* Permit guarded-area access with drive enable removed. The controller obligations are defined by safeAccess and removeDriveEnable. */
        }
        doc /* Motivation: service access. Trigger: operator opens the guard. Precondition: drive enabled and guard closed. Success: drive enable removed within the specified limit. Alternate event: guard signal is lost. Actual machine access safety also requires stopping-distance and hazard assessment, outside this increment. */
        action nominal {
            action guardOpens;
            action detect : DetectStopDemand;
            action disable : RemoveDriveEnable;
            first guardOpens then detect;
            first detect then disable;
            doc /* Nominal scenario: deliberate guard opening creates a stop demand. */
        }
        action signalLoss {
            action signalLost;
            action detect : DetectStopDemand;
            action disable : RemoveDriveEnable;
            first signalLost then detect;
            first detect then disable;
            doc /* Degraded scenario: missing input is treated as a stop demand. */
        }
    }
    binding useCaseActor bind accessGuardedArea.user = GuardStopContext::operator;
}
