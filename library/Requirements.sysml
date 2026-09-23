package Elan8 {
    package Method {
        package Requirements {
            doc /*
              Canonical Elan8 Method vocabulary for verification evidence and
              traceability concerns. Prefer OMG ModelingMetadata::StatusInfo for
              lifecycle/work status on requirements and other elements, and native
              SysML requirement relationships (satisfy, derive, trace, refine) for
              traceability links rather than a bespoke traceability element.

              Formerly RequirementManagement in sysml-domain-libraries.
            */

            attribute def Identifier;
            attribute def Name;
            attribute def EvidenceUri;

            part def VerificationEvidence {
                attribute evidenceName : Name;
                attribute evidenceUri : EvidenceUri;
            }
        }
    }
}
