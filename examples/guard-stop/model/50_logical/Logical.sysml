package GuardStopLogical {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::logicalArchitecture; status = StageStatusKind::mergedIntoAnotherStage; rationale = "Both functions run on one controller. A separate logical part tree would duplicate the physical baseline."; mergedInto = EngineeringStageKind::physicalArchitecture; }

}
