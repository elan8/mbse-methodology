package MinimalTraceability {
    doc /* Teaching fixture: derive, satisfy, and verify with Elan8 requirement libraries. */

    private import ScalarValues::String;
    private import Elan8Method::Metadata::*;
    private import ModelingMetadata::*;
    private import RequirementDerivation::*;

    part def DeliverySystem {
        attribute systemName : String;
    }

    part notificationService : DeliverySystem {
        attribute :>> systemName = "notification-service";
    }

    requirement <'USR-001'> notifyCustomer {
        @RequirementRole { role = RequirementRoleKind::user; }
        @StatusInfo { status = StatusKind::done; }
        doc /* Customers shall be notified when an order changes state. */
    }

    requirement <'SYS-001'> sendOrderUpdate {
        @RequirementRole { role = RequirementRoleKind::functional; }
        @StatusInfo { status = StatusKind::done; }
        doc /* The delivery system shall send an order update notification after state changes. */
    }

    #derivation connection {
        end #original ::> notifyCustomer;
        end #derive ::> sendOrderUpdate;
    }

    satisfy sendOrderUpdate by notificationService;

    verification verifyOrderUpdateNotification {
        subject systemUnderTest : DeliverySystem;
        objective {
            verify sendOrderUpdate;
        }
    }
}
