package MethodMetadata {
    doc /*
      Annotates standard SysML requirement usages with engineering role. Does not introduce custom requirement definitions.

      Requirement identifiers use native SysML short names.
    */

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

}
