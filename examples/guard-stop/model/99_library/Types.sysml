package GuardStopTypes {
    private import ISQ::TimeValue;
    item def GuardSignal { attribute healthy : ScalarValues::Boolean; attribute closed : ScalarValues::Boolean; }
    item def DriveEnable { attribute enabled : ScalarValues::Boolean; }
    port def GuardInput { in signal : GuardSignal; }
    port def DriveOutput { out command : DriveEnable; }
    part def Operator;
    part def Controller {
        port guardInput : GuardInput;
        port driveOutput : DriveOutput;
        attribute responseTime : TimeValue;
        attribute driveDisabled : ScalarValues::Boolean;
    }
    action def DetectStopDemand;
    action def RemoveDriveEnable;
}
