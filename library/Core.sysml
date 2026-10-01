package MethodCore {
    doc /*
      Lightweight Elan8 Method vocabulary: engineering concerns, fixed-stage
      disposition, decisions, assumptions, and risks.

      Process mechanics (PR review, CODEOWNERS, release tags, work increments)
      stay in Git and surrounding tooling. This package encodes engineering
      meaning only.
    */

    private import ScalarValues::String;
    private import ScalarValues::Boolean;

    enum def EngineeringConcernKind {
        enum purpose;
        enum behavior;
        enum architecture;
        enum evidence;
        enum 'verification';
        enum evolution;
    }


    enum def EngineeringStageKind {
        enum context;
        enum useCases;
        enum capabilities;
        enum functions;
        enum logicalArchitecture;
        enum physicalArchitecture;
        enum 'verification';
    }

    enum def StageStatusKind {
        enum applicable;
        enum notApplicable;
        enum mergedIntoAnotherStage;
    }

    metadata def EngineeringConcern {
        doc /* Tags a model element with one of the six continuous Elan8 concerns. */
        attribute 'concern' : EngineeringConcernKind;
    }

    metadata def StageDisposition {
        doc /*
          Declares whether a fixed-structure stage package (context, use cases,
          capabilities, functions, logical architecture, physical architecture,
          verification) is populated, deliberately skipped, or merged into a
          neighboring stage for this project. Every stage package carries exactly
          one StageDisposition so tooling can distinguish "empty on purpose" from
          "empty because someone forgot it." Skipped or merged stages require a
          rationale.
        */
        attribute stage : EngineeringStageKind;
        attribute status : StageStatusKind;
        attribute rationale : String;
        attribute mergedInto : EngineeringStageKind[0..1];
    }

    metadata def DecisionRecord {
        doc /*
          Records an architecture or engineering decision with rationale.
          Approval/workflow status lives in Git (PR merge), not in the model.
        */
        attribute decisionId : String;
        attribute title : String;
        attribute rationale : String;
    }

    metadata def Assumption {
        doc /* Explicit assumption that underpins design or analysis. */
        attribute assumptionId : String;
        attribute statement : String;
        attribute valid : Boolean = true;
    }

    metadata def Risk {
        doc /* Lightweight risk annotation; domain-specific hazard models live elsewhere. */
        attribute riskId : String;
        attribute description : String;
        attribute severity : String;
    }

    part def ProjectInfo {
        doc /* Project name and notes. StageDisposition records tailoring independently for each stage. */
        attribute projectName : String;
        attribute notes : String;
    }
}
