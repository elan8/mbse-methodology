package GuardStopCapabilities {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::capabilities; status = StageStatusKind::mergedIntoAnotherStage; rationale = "A separate mission capability layer adds no information for this controller; its outcome is represented by the physical controller and access use case."; mergedInto = EngineeringStageKind::physicalArchitecture; }

}
