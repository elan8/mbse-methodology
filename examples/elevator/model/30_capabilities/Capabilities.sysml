package ElevatorCapabilities {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::capabilities; status = StageStatusKind::applicable; rationale = "Distinct content for the two-elevator example."; }
    private import ElevatorTypes::*;
    private import ElevatorContext::*;
    use case passengerTransport {
        subject system : ElevatorService;
        objective { frame convenientTravel; }
        include ElevatorUseCases::travel;
        doc /* Capability: transport passengers across six floors. Outcome measure: mean waiting time under the agreed traffic profile; CUST-001. */
    }
    use case protectedAccessService {
        subject system : ElevatorService;
        objective { frame protectedAccess; }
        include ElevatorUseCases::recoverObstructedDoor;
        doc /* Capability: protect boarding and travel; CUST-002 and SYS-002 address selected aspects, not complete hazard coverage. */
    }
    use case reducedService {
        subject system : ElevatorService;
        objective { frame serviceContinuity; }
        include ElevatorUseCases::isolateCar;
        include ElevatorUseCases::travel;
        doc /* Capability: retain service with one available car; SYS-003. No unchanged waiting-time guarantee. */
    }
}
