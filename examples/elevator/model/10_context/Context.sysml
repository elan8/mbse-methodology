package ElevatorContext {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::context; status = StageStatusKind::applicable; rationale = "Distinct content for the two-elevator example."; }
    private import ElevatorTypes::*;
    part specifiedService : ElevatorService;
    part passenger : Passenger;
    part owner : Owner;
    part maintainer : Maintainer;
    concern convenientTravel;
    concern protectedAccess;
    concern serviceContinuity;
    doc /* Problem: passengers need predictable travel across six floors, including when one car is unavailable. Boundary includes panels, group control, cars, drives and doors. Building structure, mains supply, emergency services and maintenance organization are external. Installation, maintenance and recovery affect needs; fire-service operation, evacuation, detailed mechanical design and certification remain outside this teaching baseline. */
}
