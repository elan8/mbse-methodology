package CallController {
    private import ISQ::TimeValue;
    private import SI::*;
    private import ElevatorProjectLibrary::*;
    part def ControllerSpecification :> Elan8::SystemsEngineering::SystemSpecification {
        port calls : CallServicePort;
        perform action register : RegisterCall;
        bind register.request = calls.request;
        bind register.acknowledgement = calls.acknowledgement;
        attribute latency : TimeValue;
        attribute limit : TimeValue = 0.15 [s];
        assert constraint withinLimit { latency <= limit }
    }

    part def ControllerArchitecture
        :> ControllerSpecification, Elan8::SystemsEngineering::SystemArchitecture {
        attribute :>> latency = 0.12 [s];
    }

}
