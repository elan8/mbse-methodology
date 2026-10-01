package MethodCore {
    doc /*
      Lightweight Elan8 Method vocabulary: decisions, assumptions, risks, and project information.

      Process mechanics (PR review, CODEOWNERS, release tags, work increments)
      stay in Git and surrounding tooling. This package encodes engineering
      meaning only.
    */

    private import ScalarValues::String;
    private import ScalarValues::Boolean;

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
        doc /* Project name and notes. Area tailoring can be explained in project or package documentation. */
        attribute projectName : String;
        attribute notes : String;
    }
}
