package GuardStopContext {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::context; status = StageStatusKind::applicable; rationale = "Populated for the guard-stop increment.";  }
    private import GuardStopTypes::*;
    part operator : Operator;
    part specifiedController : Controller;
    concern preventUnexpectedMotion {
        subject system : GuardStopTypes::Controller = specifiedController;
        stakeholder user : GuardStopTypes::Operator;
        doc /* The operator needs the drive-enable signal removed before access can lead to unexpected motion. */
    }
    doc /* Problem: the existing machine relies on a manual stop before guard access. Desired outcome: automatic inhibition on guard opening or signal loss. Boundary: controller input to drive-enable output; mechanical stopping distance is outside this increment. */
    binding concernStakeholder bind preventUnexpectedMotion.user = GuardStopContext::operator;
}
