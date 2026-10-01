package GuardStopAnalysis {
    private import ISQ::TimeValue;
    private import SI::*;
    private import GuardStopPhysical::*;
    private import GuardStopRequirements::*;
    analysis responseBudget {
        subject system = controller;
        @Elan8Method::MethodCore::Assumption { assumptionId = "ASM-001"; statement = "Illustrative worst-case budgets; hardware measurements must substantiate these values before a compliance claim."; }
        attribute detectionBudget : TimeValue = 0.050 [s];
        attribute outputBudget : TimeValue = 0.100 [s];
        objective { require constraint { detectionBudget + outputBudget <= removeDriveEnable.maximumResponseTime } }
    }
}
