package GuardStopFunctions {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::functions; status = StageStatusKind::applicable; rationale = "Populated for the guard-stop increment.";  }
    private import GuardStopTypes::*;
    action detectStopDemand : DetectStopDemand;
    action disableDrive : RemoveDriveEnable;
    doc /* Both guard opening and signal loss create a stop demand. These functions are allocated to the selected controller. */
}
