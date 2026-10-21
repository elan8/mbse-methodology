package Elevator {
    private import ISQ::TimeValue;
    private import SI::*;
    private import ElevatorProjectLibrary::*;

    package Specification {
        action def AcknowledgeCall {
            in request : CallRequest;
            out acknowledgement : CallAcknowledgement;
            bind acknowledgement.callId = request.callId;
        }
        requirement def AcknowledgementRequirement {
            subject elevator : ElevatorSpecification;
            require constraint { elevator.latency <= elevator.limit }
        }
        requirement <'ELEV-SYS-001'> acknowledgement : AcknowledgementRequirement {
            doc /* A valid call is acknowledged within 200 ms under nominal unloaded
                 * operation. Source: ACK-NEED-01. This is the authoritative criterion;
                 * the BB explicitly asserts it for its own subject below. */
        }
        part def ElevatorSpecification :> Elan8::SystemsEngineering::SystemSpecification {
            port calls : CallServicePort;
            attribute latency : TimeValue;
            attribute limit : TimeValue = 0.20 [s];
            perform action acknowledge : AcknowledgeCall;
            bind acknowledge.request = calls.request;
            bind acknowledge.acknowledgement = calls.acknowledgement;
            satisfy acknowledgement;
        }
    }
    package Architecture {
        action def RoutedAcknowledgement :> Specification::AcknowledgeCall {
            action forward : ForwardCall;
            action register : RegisterCall;
            action present : PresentAcknowledgement;
            flow request to forward.request;
            flow forward.forwarded to register.request;
            flow register.acknowledgement to present.confirmation;
            flow present.displayed to acknowledgement;
            first forward then register;
            first register then present;
        }
        part def ElevatorArchitecture
            :> Specification::ElevatorSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            part panel : CallPanel::Specification::PanelSpecification {
                attribute :>> limit = 0.05 [s];
            }
            part controller : CallController::Specification::ControllerSpecification;
            bind calls = panel.operator;
            connect panel.registration to controller.calls;
            flow panel.registration.request to controller.calls.request;
            flow controller.calls.acknowledgement to panel.registration.acknowledgement;
            perform action acknowledge : RoutedAcknowledgement
                redefines Specification::ElevatorSpecification::acknowledge;
            bind acknowledge.forward = panel.forward;
            bind acknowledge.register = controller.register;
            bind acknowledge.present = panel.present;
            allocate acknowledge.forward to panel;
            allocate acknowledge.register to controller;
            allocate acknowledge.present to panel;
            attribute :>> latency = panel.latency + controller.latency;
            doc /* One valid request, serial processing, no queuing/communication overhead.
                 * Panel latency includes forwarding and presentation together, not each
                 * action separately. Controller latency covers registration.
                 * These are explicit teaching assumptions, not measured guarantees. */
        }
    }
    package Integration {
        part def ElevatorReleaseAIntegration
            :> Architecture::ElevatorArchitecture, Elan8::SystemsEngineering::SystemIntegration {
            part redefines panel : CallPanel::Architecture::FastPanelArchitecture;
            part redefines controller : CallController::Architecture::ControllerArchitecture;
        }
        part releaseA : ElevatorReleaseAIntegration;
    }
    package Verification {
        verification def AcknowledgementAnalysis {
            subject elevator : Specification::ElevatorSpecification;
            objective { verify Specification::acknowledgement; }
            doc /* Planned timing check of this subject's inherited requirement.
                 * A separate execution/result is needed before claiming verification. */
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
