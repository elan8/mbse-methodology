package GuardStopRequirements {
    private import Elan8Method::Metadata::*;
    private import RequirementDerivation::*;
    private import ISQ::TimeValue;
    private import SI::*;
    private import GuardStopContext::*;
    requirement <'NEED-001'> safeAccess {
        subject system : GuardStopTypes::Controller;
        stakeholder user : GuardStopTypes::Operator;
        frame preventUnexpectedMotion;
        @RequirementRole { role = RequirementRoleKind::user; }
        doc /* Access shall not leave the drive enabled. */
    }
    requirement <'SYS-001'> removeDriveEnable {
        subject system : GuardStopTypes::Controller;
        stakeholder user : GuardStopTypes::Operator;
        frame preventUnexpectedMotion;
        @RequirementRole { role = RequirementRoleKind::safety; }
        attribute maximumResponseTime : TimeValue = 0.200 [s];
        require constraint { system.driveDisabled and system.responseTime <= maximumResponseTime }
        doc /* On guard opening or loss of the guard signal, remove drive enable within 200 ms, measured from the input event to the disabled output. Reset behavior and mechanical stopping distance are separate follow-up obligations. */
    }
    #derivation connection accessToStop {
        end #original ::> safeAccess;
        end #derive ::> removeDriveEnable;
    }
    binding needStakeholder bind safeAccess.user = GuardStopContext::operator;
    binding requirementStakeholder bind removeDriveEnable.user = GuardStopContext::operator;
}
