package ElevatorVerification {
    private import Elan8Method::MethodCore::*;

    private import ElevatorTypes::*;
    private import VerificationCases::*;
    private import ISQ::TimeValue;
    private import SI::*;
    private import ScalarValues::Boolean;
    verification def RegistrationCheck {
        subject testedService : ElevatorService;
        in attribute observed : TimeValue;
        in attribute conditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify ElevatorSystemRequirements::callAcknowledgement; }
        return verdict = PassIf(conditionApplied and (observed <= ElevatorSystemRequirements::callAcknowledgement.maximumRegistration));
        doc /* Evaluate supplied observations for the specified baseline and conditions. Missing evidence requires an inconclusive disposition in review, not an invented observation. */
    }
    verification registrationNominal : RegistrationCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 0.4 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification registrationBoundary : RegistrationCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 1 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification registrationLate : RegistrationCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 1.1 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: fail. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification def WaitingCheck {
        subject testedService : ElevatorService;
        in attribute observed : TimeValue;
        in attribute conditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify ElevatorStakeholderRequirements::waitingTarget; }
        return verdict = PassIf(conditionApplied and (observed <= ElevatorStakeholderRequirements::waitingTarget.maximumMeanWait));
        doc /* Evaluate supplied observations for the specified baseline and conditions. Missing evidence requires an inconclusive disposition in review, not an invented observation. */
    }
    verification lightTraffic : WaitingCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 20 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification excessiveWait : WaitingCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 31 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: fail. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification def ObstructionCheck {
        subject testedService : ElevatorService;
        in attribute observed : TimeValue;
        in attribute conditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify ElevatorSystemRequirements::obstructionResponse; }
        return verdict = PassIf(conditionApplied and (observed <= ElevatorSystemRequirements::obstructionResponse.maximumResponse));
        doc /* Evaluate supplied observations for the specified baseline and conditions. Missing evidence requires an inconclusive disposition in review, not an invented observation. */
    }
    verification obstructionReopen : ObstructionCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 0.4 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification obstructionLate : ObstructionCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = 0.6 [s];
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: fail. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification def ProtectionCheck {
        subject testedService : ElevatorService;
        in attribute observed : Boolean;
        in attribute conditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify ElevatorStakeholderRequirements::doorProtection; }
        return verdict = PassIf(conditionApplied and (observed));
        doc /* Evaluate supplied observations for the specified baseline and conditions. Missing evidence requires an inconclusive disposition in review, not an invented observation. */
    }
    verification unlockedDoors : ProtectionCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = true;
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification movementAllowed : ProtectionCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = false;
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: fail. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification def OutageCheck {
        subject testedService : ElevatorService;
        in attribute observed : Boolean;
        in attribute conditionApplied : Boolean;
        @VerificationMethod { kind = VerificationMethodKind::test; }
        objective { verify ElevatorSystemRequirements::outageDispatch; }
        return verdict = PassIf(conditionApplied and (observed));
        doc /* Evaluate supplied observations for the specified baseline and conditions. Missing evidence requires an inconclusive disposition in review, not an invented observation. */
    }
    verification carBUnavailable : OutageCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = true;
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: pass. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification unavailableAssigned : OutageCheck {
        subject :>> testedService = ElevatorPhysical::service;
        in attribute :>> observed = false;
        in attribute :>> conditionApplied = true;
        doc /* Synthetic teaching fixture. Expected verdict: fail. See walkthrough for applied conditions; no physical test is executed. */
    }
    verification stakeholderJourneyReview {
        subject system : ElevatorService = ElevatorPhysical::service;
        objective { verify ElevatorNeeds::convenientJourney; }
        doc /* Planned stakeholder validation: review call, pickup, requested-floor arrival and passenger feedback under agreed traffic and accessibility conditions. Outcome criteria and real observations are not yet agreed; no verdict or completed validation is claimed. */
    }

}
