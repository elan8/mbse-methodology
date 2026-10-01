package GuardStopVerification {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::'verification'; status = StageStatusKind::applicable; rationale = "Populated for the guard-stop increment.";  }
    private import GuardStopTypes::*;
    private import GuardStopPhysical::*;
    private import GuardStopRequirements::*;
    private import ISQ::TimeValue;
    private import SI::*;
    private import ScalarValues::Boolean;
    private import VerificationCases::*;
    verification def RemovalTimingCheck {
        subject testedController : Controller;
        in attribute measuredResponseTime : TimeValue;
        in attribute driveDisabled : Boolean;
        in attribute inputConditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify removeDriveEnable; }
        return verdict = PassIf(inputConditionApplied and driveDisabled and measuredResponseTime <= removeDriveEnable.maximumResponseTime);
        doc /* The input condition is guard opening or signal loss, as specified by each case. Inputs must come from evidence for the identified controller baseline. PassIf evaluates supplied observations; it does not perform a physical test. */
    }
    verification nominalObservation : RemovalTimingCheck {
        subject :>> testedController = controller;
        in attribute :>> measuredResponseTime = 10.050 [s];
        in attribute :>> driveDisabled = true;
        in attribute :>> inputConditionApplied = true;
        doc /* Synthetic nominal fixture: guard opened. Expected verdict: pass. */
    }
    verification degradedObservation : RemovalTimingCheck {
        subject :>> testedController = controller;
        in attribute :>> measuredResponseTime = 0.180 [s];
        in attribute :>> driveDisabled = true;
        in attribute :>> inputConditionApplied = true;
        doc /* Synthetic degraded fixture: guard signal lost. Expected verdict: pass. */
    }
    verification lateResponseObservation : RemovalTimingCheck {
        subject :>> testedController = controller;
        in attribute :>> measuredResponseTime = 0.201 [s];
        in attribute :>> driveDisabled = true;
        in attribute :>> inputConditionApplied = true;
        doc /* Synthetic negative control: response exceeds limit. Expected verdict: fail. */
    }
}
