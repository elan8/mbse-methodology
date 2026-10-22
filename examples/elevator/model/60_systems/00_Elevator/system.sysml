package Elevator {
    private import ISQ::TimeValue;
    private import SI::*;
    private import ElevatorProjectLibrary::*;

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

    action def RoutedAcknowledgement :> AcknowledgeCall {
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
        :> ElevatorSpecification, Elan8::SystemsEngineering::SystemArchitecture {
        part panel : CallPanel::PanelSpecification {
            attribute :>> limit = 0.05 [s];
        }
        part controller : CallController::ControllerSpecification;
        bind calls = panel.operator;
        connect panel.registration to controller.calls;
        flow panel.registration.request to controller.calls.request;
        flow controller.calls.acknowledgement to panel.registration.acknowledgement;
        perform action acknowledge : RoutedAcknowledgement
            redefines ElevatorSpecification::acknowledge;
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

    part def ElevatorReleaseAIntegration
        :> ElevatorArchitecture, Elan8::SystemsEngineering::SystemIntegration {
        part redefines panel : CallPanel::FastPanelArchitecture;
        part redefines controller : CallController::ControllerArchitecture;
    }
    part releaseA : ElevatorReleaseAIntegration;

    package Verification {
        verification def AcknowledgementAnalysis {
            subject elevator : ElevatorSpecification;
            objective { verify acknowledgement; }
            doc /* Planned timing check of this subject's inherited requirement.
                 * A separate execution/result is needed before claiming verification. */
        }
        verification releaseAAnalysis : AcknowledgementAnalysis {
            subject :>> elevator = releaseA;
        }
    }
    package Views {
        private import Elan8::SystemsEngineering::*;
        view specification : SpecificationView {
            expose Elevator::ElevatorSpecification;
            expose Elevator::AcknowledgeCall;
            expose Elevator::AcknowledgementRequirement;
            expose Elevator::acknowledgement;
        }
        view architecture : ArchitectureView {
            expose Elevator::ElevatorArchitecture;
        }
        view integration : IntegrationView {
            expose Elevator::releaseA;
        }
    }
}
