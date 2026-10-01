package ElevatorUseCases {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::useCases; status = StageStatusKind::applicable; rationale = "Distinct content for the two-elevator example."; }
    private import ElevatorTypes::*;
    private import ElevatorContext::*;
    use case travel {
        subject system : ElevatorService;
        actor user : Passenger;
        objective { frame convenientTravel; }
        doc /* Trigger: valid origin/destination request. Preconditions: at least one car available, floors 0..5, origin differs from destination. Outcome: requested-floor arrival with boarding/alighting opportunities. */
        action nominal {
            action register : RegisterCall;
            action dispatch : AssignCar;
            action journey : ExecuteJourney;
            action doors : ManageDoors;
            flow register.accepted to dispatch.request;
            flow dispatch.assignment to journey.assignment;
            flow journey.arrival to doors.arrival;
            first register then dispatch;
            first dispatch then journey;
            first journey then doors;
            doc /* Abstract end-to-end path; ExecuteJourney includes pickup and transport. Detailed boarding interlocks remain refinement work. */
        }
    }
    use case recoverObstructedDoor {
        subject system : ElevatorService;
        actor user : Passenger;
        objective { frame protectedAccess; }
        action obstructionDetected;
        action inhibit : InhibitMovement;
        action reopen : ManageDoors;
        first obstructionDetected then inhibit;
        first inhibit then reopen;
        doc /* Trigger: obstruction during closing. Outcome: reopening initiated and movement inhibited; retry policy remains open. */
    }
    use case isolateCar {
        subject system : ElevatorService;
        actor technician : Maintainer;
        objective { frame serviceContinuity; }
        action declareUnavailable;
        action exclude : ExcludeUnavailableCar;
        action redispatch : AssignCar;
        first declareUnavailable then exclude;
        first exclude then redispatch;
        doc /* Precondition: controlled maintenance request. Outcome: subsequent requests use the remaining car. Physical isolation and return-to-service procedures require further specification. */
    }
}
