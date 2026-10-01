package ElevatorLogical {
    private import Elan8Method::MethodCore::*;

    private import ElevatorTypes::*;
    part dispatchManager {
        port requests : ~RequestPort;
        port carA : DispatchPort;
        port carB : DispatchPort;
    }
    part carControlA { port dispatch : ~DispatchPort; }
    part carControlB { port dispatch : ~DispatchPort; }
    part doorManagement;
    part protectiveSupervision;
    connect dispatchManager.carA to carControlA.dispatch;
    connect dispatchManager.carB to carControlB.dispatch;
    flow dispatchManager.carA.assignment to carControlA.dispatch.assignment;
    flow carControlA.dispatch.status to dispatchManager.carA.status;
    flow dispatchManager.carB.assignment to carControlB.dispatch.assignment;
    flow carControlB.dispatch.status to dispatchManager.carB.status;
    allocate ElevatorFunctions::registerCall to dispatchManager;
    allocate ElevatorFunctions::assignCar to dispatchManager;
    allocate ElevatorFunctions::excludeUnavailableCar to dispatchManager;
    allocate ElevatorFunctions::executeJourney to carControlA;
    allocate ElevatorFunctions::executeJourney to carControlB;
    allocate ElevatorFunctions::manageDoors to doorManagement;
    allocate ElevatorFunctions::inhibitMovement to protectiveSupervision;
    doc /* Logical partition separates fleet decisions from local execution and protective responsibilities. Assignment carries destination and car identity; status carries availability and floor. Door/protection collaboration contracts remain partial. */
}
