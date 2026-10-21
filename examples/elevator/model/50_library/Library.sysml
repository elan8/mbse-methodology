package ElevatorProjectLibrary {
    private import ScalarValues::Integer;
    item def CallRequest { attribute callId : Integer; }
    item def CallAcknowledgement { attribute callId : Integer; }
    port def CallServicePort {
        in item request : CallRequest;
        out item acknowledgement : CallAcknowledgement;
    }
    action def ForwardCall {
        in request : CallRequest;
        out forwarded : CallRequest;
        bind forwarded = request;
    }
    action def RegisterCall {
        in request : CallRequest;
        out acknowledgement : CallAcknowledgement;
        bind acknowledgement.callId = request.callId;
    }
    action def PresentAcknowledgement {
        in confirmation : CallAcknowledgement;
        out displayed : CallAcknowledgement;
        bind displayed = confirmation;
    }
}
