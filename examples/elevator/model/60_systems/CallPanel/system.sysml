package CallPanel {
    private import ISQ::TimeValue;
    private import SI::*;
    private import ElevatorProjectLibrary::*;
    part def PanelSpecification :> Elan8::SystemsEngineering::SystemSpecification {
        port operator : CallServicePort;
        port registration : ~CallServicePort;
        perform action forward : ForwardCall;
        perform action present : PresentAcknowledgement;
        bind forward.request = operator.request;
        bind forward.forwarded = registration.request;
        bind present.confirmation = registration.acknowledgement;
        bind present.displayed = operator.acknowledgement;
        attribute latency : TimeValue;
        attribute limit : TimeValue default = 0.08 [s];
        assert constraint contractLimit { limit <= 0.08 [s] }
        assert constraint withinLimit { latency <= limit }
    }

    part def StandardPanelArchitecture
        :> PanelSpecification, Elan8::SystemsEngineering::SystemArchitecture {
        attribute :>> latency = 0.06 [s];
    }
    part def FastPanelArchitecture
        :> PanelSpecification, Elan8::SystemsEngineering::SystemArchitecture {
        attribute :>> latency = 0.04 [s];
    }

}
