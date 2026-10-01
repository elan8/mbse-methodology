package MethodMetadata {
    doc /*
      Annotates standard SysML requirement usages with engineering role and
      stable identity. Does not introduce custom requirement definitions.

      Formerly RequirementMetadata in sysml-domain-libraries.
    */

    private import ScalarValues::String;

    enum def RequirementRoleKind {
        enum user;
        enum system;
        enum functional;
        enum performance;
        enum safety;
        enum 'interface';
        enum security;
        enum regulatory;
    }

    metadata def RequirementRole {
        doc /*
          Annotates a requirement usage with its engineering role
          (user need, system requirement, etc.).
        */
        :> annotatedElement : SysML::RequirementUsage;
        attribute role : RequirementRoleKind;
    }

    metadata def RequirementIdentity {
        doc /* Optional stable identifier for a requirement usage (e.g. USR-001, SYS-042). */
        :> annotatedElement : SysML::RequirementUsage;
        attribute requirementId : String;
    }
}
