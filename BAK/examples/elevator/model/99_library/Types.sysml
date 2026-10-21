package ElevatorTypes {
    private import ScalarValues::*;
    private import ISQ::TimeValue;
    item def JourneyRequest { attribute origin : Integer; attribute destination : Integer; }
    item def CarAssignment { attribute carId : Integer; attribute destination : Integer; }
    item def CarStatus { attribute available : Boolean; attribute floor : Integer; }
    item def MotionCommand { attribute permitted : Boolean; attribute destination : Integer; }
    item def DoorCommand { attribute open : Boolean; }
    port def RequestPort { out request : JourneyRequest; }
    port def DispatchPort { out assignment : CarAssignment; in status : CarStatus; }
    port def MotionPort { out command : MotionCommand; }
    port def DoorPort { out command : DoorCommand; }
    part def Passenger;
    part def Owner;
    part def Maintainer;
    part def ElevatorService {
        attribute registeredWithin : TimeValue;
        attribute doorResponse : TimeValue;
        attribute meanWaitingTime : TimeValue;
        attribute movementInhibited : Boolean;
        attribute unavailableCarExcluded : Boolean;
    }
    part def RequestPanel { port calls : RequestPort; }
    part def GroupController { port calls : ~RequestPort; port carA : DispatchPort; port carB : DispatchPort; }
    part def CarController { port dispatch : ~DispatchPort; port motion : MotionPort; port doors : DoorPort; }
    part def Drive { port control : ~MotionPort; }
    part def DoorActuator { port control : ~DoorPort; }
    part def Brake;
    part def Sensor;
    part def CarAssembly {
        part controller : CarController;
        part drive : Drive;
        part doorActuator : DoorActuator;
        part brake : Brake;
        part positionSensor : Sensor;
        part doorSensor : Sensor;
        connect controller.motion to drive.control;
        connect controller.doors to doorActuator.control;
        flow controller.motion.command to drive.control.command;
        flow controller.doors.command to doorActuator.control.command;
        doc /* Brake and sensor wiring remains a detailed-design gap. Motion permission includes door-lock and availability checks, not a certified safety function. */
    }
    part def InstalledService :> ElevatorService {
        part panel : RequestPanel;
        part group : GroupController;
        part carA : CarAssembly;
        part carB : CarAssembly;
        connect panel.calls to group.calls;
        connect group.carA to carA.controller.dispatch;
        connect group.carB to carB.controller.dispatch;
        flow panel.calls.request to group.calls.request;
        flow group.carA.assignment to carA.controller.dispatch.assignment;
        flow carA.controller.dispatch.status to group.carA.status;
        flow group.carB.assignment to carB.controller.dispatch.assignment;
        flow carB.controller.dispatch.status to group.carB.status;
    }
    action def RegisterCall { in request : JourneyRequest; out accepted : JourneyRequest; }
    action def AssignCar { in request : JourneyRequest; out assignment : CarAssignment; }
    action def ExecuteJourney { in assignment : CarAssignment; out arrival : CarStatus; }
    action def ManageDoors { in arrival : CarStatus; }
    action def InhibitMovement;
    action def ExcludeUnavailableCar;
}
