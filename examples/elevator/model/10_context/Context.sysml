package ElevatorContext {
    private import Elan8Method::MethodCore::*;

    private import ElevatorTypes::*;
    part specifiedService : ElevatorService;
    part passenger : Passenger;
    part owner : Owner;
    part maintainer : Maintainer;
    concern convenientTravel;
    concern protectedAccess;
    concern serviceContinuity;
    doc
    /* Problem: passengers need predictable travel across six floors, including when one car is unavailable. Boundary includes panels, group control, cars, drives and doors. Building structure, mains supply, emergency services and maintenance organization are external. Installation, maintenance and recovery affect needs; fire-service operation, evacuation, detailed mechanical design and certification remain outside this teaching baseline. */
    doc /* Optional capability reasoning: passenger transport across six floors links to travel and CUST-001; protected boarding/travel links to recoverObstructedDoor and selected protection obligations; continued transport with one unavailable car links to isolateCar and remaining journeys. Reduced-service outcome targets remain open; no unchanged two-car waiting guarantee. These Context outcomes do not add a separate capability model layer. */
} // package ElevatorContext
