package MissingVerification {
    doc /*
      Intentional gap fixture: derive and satisfy without verification.
      Used to teach completeness checks for active system requirements.
    */

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

    requirement <'USR-002'> notifyCustomer {
        @RequirementRole { role = RequirementRoleKind::user; }
        @StatusInfo { status = StatusKind::done; }
        doc /* Customers shall receive timely order-state notifications. */
    }

    requirement <'SYS-002'> sendOrderUpdate {
        @RequirementRole { role = RequirementRoleKind::functional; }
        @StatusInfo { status = StatusKind::done; }
        doc /* The delivery system shall publish notification events for order-state changes. */
    }

    #derivation connection {
        end #original ::> notifyCustomer;
        end #derive ::> sendOrderUpdate;
    }

    satisfy sendOrderUpdate by notificationService;
}
