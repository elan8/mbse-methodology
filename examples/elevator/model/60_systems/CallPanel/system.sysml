package CallPanel {
    private import ISQ::TimeValue;
    private import SI::*;

    item def CallRequest;
    port def CallPort { out item request : CallRequest; }

    package Specification {
        part def PanelSpecification :> Elan8::SystemsEngineering::SystemSpecification {
            port calls : CallPort;
            attribute latency : TimeValue;
            attribute limit : TimeValue default = 0.08 [s];
            assert constraint contractLimit { limit <= 0.08 [s] }
            assert constraint withinLimit { latency <= limit }
        }
    }
    package Architecture {
        part def StandardPanelArchitecture
            :> Specification::PanelSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            attribute :>> latency = 0.06 [s];
        }
        part def FastPanelArchitecture
            :> Specification::PanelSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            attribute :>> latency = 0.04 [s];
        }
    }
}
