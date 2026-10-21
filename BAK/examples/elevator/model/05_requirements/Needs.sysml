package ElevatorNeeds {
    private import ElevatorTypes::*;
    private import ElevatorContext::*;
    requirement <'NEED-001'> convenientJourney {
        subject system : ElevatorService;
        stakeholder user : Passenger;
        frame convenientTravel;
        doc /* Passengers need predictable travel to their requested floor. Validate outcomes under an agreed traffic profile, not just controller response. */
    }
    requirement <'NEED-002'> protectedJourney {
        subject system : ElevatorService;
        frame protectedAccess;
        doc /* Passengers need boarding and travel without hazardous door or car movement. */
    }
    requirement <'NEED-003'> continuedService {
        subject system : ElevatorService;
        frame serviceContinuity;
        doc /* The owner needs reduced passenger service during a single-car outage and controlled maintenance isolation. */
    }
}
