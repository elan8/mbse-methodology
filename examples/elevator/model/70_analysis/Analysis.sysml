package ElevatorAnalysis {
    private import Elan8Method::MethodCore::*;
    private import ISQ::TimeValue;
    private import SI::*;
    analysis waitingEstimate {
        subject system = ElevatorPhysical::service;
        @Assumption { assumptionId = "ASM-001"; statement = "Six synthetic call-to-door-open waits for the illustrative light-traffic profile; not a dispatch simulation or hardware measurement."; }
        attribute wait1 : TimeValue = 12 [s];
        attribute wait2 : TimeValue = 18 [s];
        attribute wait3 : TimeValue = 24 [s];
        attribute wait4 : TimeValue = 20 [s];
        attribute wait5 : TimeValue = 16 [s];
        attribute wait6 : TimeValue = 30 [s];
        attribute meanWait : TimeValue = (wait1 + wait2 + wait3 + wait4 + wait5 + wait6) / 6;
        objective { require constraint { meanWait <= ElevatorStakeholderRequirements::waitingTarget.maximumMeanWait } }
    }
    analysis obstructionBudget {
        subject system = ElevatorPhysical::service;
        @Assumption { assumptionId = "ASM-002"; statement = "Illustrative detection, control and actuation budgets; no force, stopping-distance or worst-case timing evidence."; }
        attribute detection : TimeValue = 0.1 [s];
        attribute control : TimeValue = 0.1 [s];
        attribute actuation : TimeValue = 0.2 [s];
        objective { require constraint { detection + control + actuation <= ElevatorSystemRequirements::obstructionResponse.maximumResponse } }
    }
}
