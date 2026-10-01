package ElevatorFunctions {
    private import Elan8Method::MethodCore::*;
    @StageDisposition { stage = EngineeringStageKind::functions; status = StageStatusKind::applicable; rationale = "Distinct content for the two-elevator example."; }
    private import ElevatorTypes::*;
    action registerCall : RegisterCall;
    action assignCar : AssignCar;
    action executeJourney : ExecuteJourney;
    action manageDoors : ManageDoors;
    action inhibitMovement : InhibitMovement;
    action excludeUnavailableCar : ExcludeUnavailableCar;
    doc /* Reusable responsibilities shared by scenarios; flows and sequencing live in contextual paths. The dispatch action specifies responsibility, not an executable scheduling algorithm. */
}
