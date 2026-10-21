package CallController {
    private import ISQ::TimeValue;
    private import SI::*;

    package Specification {
        part def ControllerSpecification :> Elan8::SystemsEngineering::SystemSpecification {
            port calls : ~CallPanel::CallPort;
            attribute latency : TimeValue;
            attribute limit : TimeValue = 0.15 [s];
            assert constraint withinLimit { latency <= limit }
        }
    }
    package Architecture {
        part def ControllerArchitecture
            :> Specification::ControllerSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            attribute :>> latency = 0.12 [s];
        }
    }
}
