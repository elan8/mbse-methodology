package ElevatorSystemRequirements {
    private import ElevatorTypes::*;
    private import ISQ::TimeValue;
    private import SI::*;
    private import RequirementDerivation::*;
    requirement <'SYS-001'> callAcknowledgement {
        subject system : ElevatorService;
        attribute maximumRegistration : TimeValue = 1 [s];
        require constraint { system.registeredWithin <= maximumRegistration }
        doc /* A valid journey request shall be registered within 1 s. Derived engineering target contributing to predictable travel; alone it does not prove the waiting target. */
    }
    requirement <'SYS-002'> obstructionResponse {
        subject system : ElevatorService;
        attribute maximumResponse : TimeValue = 0.5 [s];
        require constraint { system.doorResponse <= maximumResponse }
        doc /* During closing, an obstruction shall initiate reopening within 0.5 s. Teaching target; force and geometry assessment remain open. */
    }
    requirement <'SYS-003'> outageDispatch {
        subject system : ElevatorService;
        require constraint { system.unavailableCarExcluded }
        doc /* When a car is declared unavailable, subsequent assignments shall exclude it while the remaining car provides reduced service. The 30 s two-car target is not claimed in this mode. */
    }
    #derivation connection travelToRegistration { end #original ::> ElevatorNeeds::convenientJourney; end #derive ::> callAcknowledgement; }
    #derivation connection protectionToReopen { end #original ::> ElevatorNeeds::protectedJourney; end #derive ::> obstructionResponse; }
    #derivation connection continuityToDispatch { end #original ::> ElevatorNeeds::continuedService; end #derive ::> outageDispatch; }
}
