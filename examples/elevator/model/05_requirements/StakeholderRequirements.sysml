package ElevatorStakeholderRequirements {
    private import ElevatorTypes::*;
    private import ISQ::TimeValue;
    private import SI::*;
    private import RequirementDerivation::*;
    requirement <'CUST-001'> waitingTarget {
        subject system : ElevatorService;
        attribute maximumMeanWait : TimeValue = 30 [s];
        require constraint { system.meanWaitingTime <= maximumMeanWait }
        doc /* Fictional owner brief EB-01 revision A: mean call-to-door-open wait <=30 s for the six-request light-traffic profile defined in the walkthrough, two cars available. Teaching obligation, not an industry or contractual baseline. Canonical here; do not duplicate in SystemRequirements. */
    }
    requirement <'CUST-002'> doorProtection {
        subject system : ElevatorService;
        require constraint { system.movementInhibited }
        doc /* Fictional owner brief EB-01 revision A: inhibit car movement while doors are not confirmed closed and locked. Evaluate with that input condition applied. */
    }
    #derivation connection travelToWait { end #original ::> ElevatorNeeds::convenientJourney; end #derive ::> waitingTarget; }
    #derivation connection accessToProtection { end #original ::> ElevatorNeeds::protectedJourney; end #derive ::> doorProtection; }
}
