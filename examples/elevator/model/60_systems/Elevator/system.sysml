package Elevator {
    private import ISQ::TimeValue;
    private import SI::*;

    package Specification {
        action def AcknowledgeCall {
            doc /* Boundary intent: acknowledge a valid request under nominal unloaded conditions.
                 Detailed request/acknowledgement event behavior is outside this timing slice. */
        }
        part def ElevatorSpecification :> Elan8::SystemsEngineering::SystemSpecification {
            attribute latency : TimeValue;
            attribute limit : TimeValue = 0.20 [s];
            perform action acknowledge : AcknowledgeCall;
        }
        requirement <'ELEV-SYS-001'> acknowledgement {
            doc /* A valid call shall be acknowledged within the subject's limit under nominal
                 unloaded operation. Source: synthetic pilot stakeholder obligation ACK-NEED-01.
                 Owner: pilot contract owner. Planned method: timing analysis, later system test. */
            subject elevator : ElevatorSpecification;
            require constraint { elevator.latency <= elevator.limit }
        }
    }
    package Architecture {
        part def ElevatorArchitecture
            :> Specification::ElevatorSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            part panel : CallPanel::Specification::PanelSpecification {
                attribute :>> limit = 0.05 [s];
            }
            part controller : CallController::Specification::ControllerSpecification;
            connect panel.calls to controller.calls;
            attribute :>> latency = panel.latency + controller.latency;
            doc /* Serial timing abstraction only. No queuing, communication overhead or concurrency.
                 Latency covers panel processing plus controller registration; acceptance conditions
                 must justify this measurement boundary. No detailed action allocation is modeled. */
        }
    }
    package Integration {
        part def ElevatorReleaseAIntegration
            :> Architecture::ElevatorArchitecture, Elan8::SystemsEngineering::SystemIntegration {
            part redefines panel : CallPanel::Architecture::FastPanelArchitecture;
            part redefines controller : CallController::Architecture::ControllerArchitecture;
        }
        part releaseA : ElevatorReleaseAIntegration;
        satisfy Specification::acknowledgement by releaseA;
    }
    package Verification {
        verification def AcknowledgementAnalysis {
            subject elevator : Specification::ElevatorSpecification;
            objective { verify Specification::acknowledgement; }
            doc /* Planned case only. No execution/verdict is supplied by this definition. */
        }
        verification releaseAAnalysis : AcknowledgementAnalysis {
            subject :>> elevator = Integration::releaseA;
        }
    }
    package Views {
        private import Elan8::SystemsEngineering::*;
        view specification : SpecificationView {
            expose Elevator::Specification::**;
        }
        view architecture : ArchitectureView {
            expose Elevator::Architecture::ElevatorArchitecture;
        }
        view integration : IntegrationView {
            expose Elevator::Integration::releaseA;
        }
    }
}
