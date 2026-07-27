package Elan8Method {
    doc /*
      Lightweight Elan8 Method vocabulary: engineering concerns, abstraction
      levels, decisions, assumptions, risks, and increment identity.

      Process mechanics (PR review, CODEOWNERS, release tags) stay in Git.
      This package encodes engineering meaning only.
    */

    import Elan8RequirementManagement::Name;
    import Elan8RequirementManagement::Identifier;
    private import ScalarValues::Boolean;

    enum def EngineeringConcernKind {
        enum purpose;
        enum behavior;
        enum architecture;
        enum evidence;
        enum verification;
        enum evolution;
    }

    enum def AbstractionLevelKind {
        enum operational;
        enum system;
        enum logical;
        enum physical;
    }

    enum def TailoringProfileKind {
        enum small;
        enum medium;
        enum regulated;
    }

    metadata def EngineeringConcern {
        doc /* Tags a model element with one of the six continuous Elan8 concerns. */
        attribute concern : EngineeringConcernKind;
    }

    metadata def AbstractionLevel {
        doc /*
          Optional abstraction tag. Levels orient the model; they are not
          mandatory sequential phases. Small projects may collapse system+logical.
        */
        attribute level : AbstractionLevelKind;
    }

    metadata def DecisionRecord {
        doc /* Records an architecture or engineering decision with rationale. */
        attribute decisionId : Identifier;
        attribute title : Name;
        attribute rationale : Name;
        attribute status : Name;
    }

    metadata def Assumption {
        doc /* Explicit assumption that underpins design or analysis. */
        attribute assumptionId : Identifier;
        attribute statement : Name;
        attribute valid : Boolean = true;
    }

    metadata def Risk {
        doc /* Lightweight risk annotation; domain-specific hazard models live elsewhere. */
        attribute riskId : Identifier;
        attribute description : Name;
        attribute severity : Name;
    }

    metadata def EngineeringIncrement {
        doc /*
          Identifies a vertical engineering increment that connects concern,
          scenario, requirements, architecture, analysis, and verification.
        */
        attribute incrementId : Identifier;
        attribute objective : Name;
    }

    metadata def MethodElementOwner {
        doc /*
          Optional human-readable owner label for released model areas.
          Prefer CODEOWNERS / platform ownership for process enforcement.
        */
        attribute owner : Name;
    }

    part def ProjectTailoring {
        doc /* Project-level record of how the Elan8 Method is tailored. */
        attribute projectName : Name;
        attribute profile : TailoringProfileKind;
        attribute notes : Name;
    }
}
