package Elan8 {
    package Method {
        package Viewpoints {
            doc /*
              Five standard Elan8 Method viewpoints. Views are projections of the
              model; they do not duplicate engineering content.

              Projects satisfy these viewpoints with concrete views that expose
              project-specific elements.
            */

            private import Views::*;

            part def StakeholderRole;
            part systemsEngineer : StakeholderRole;
            part productStakeholder : StakeholderRole;
            part verificationEngineer : StakeholderRole;

            concern missionAndContext {
                doc /*
                  Explain why the system exists; show actors and external systems;
                  show the system boundary; expose key concerns and outcomes.
                */
                subject;
                stakeholder :>> systemsEngineer;
                stakeholder :>> productStakeholder;
            }

            concern scenario {
                doc /*
                  Explain one end-to-end scenario; show participants, actions, flows,
                  and outcomes; support behavior review.
                */
                subject;
                stakeholder :>> systemsEngineer;
                stakeholder :>> productStakeholder;
            }

            concern architecture {
                doc /*
                  Show logical or physical decomposition; show responsibilities;
                  expose critical interfaces and connections.
                */
                subject;
                stakeholder :>> systemsEngineer;
            }

            concern traceability {
                doc /*
                  Connect concerns, requirements, architecture, analysis, and
                  verification; expose gaps and orphaned elements.
                */
                subject;
                stakeholder :>> systemsEngineer;
                stakeholder :>> verificationEngineer;
            }

            concern verificationReadiness {
                doc /*
                  Show verification coverage; show missing methods or pass criteria;
                  show readiness and unresolved gaps.
                */
                subject;
                stakeholder :>> verificationEngineer;
                stakeholder :>> systemsEngineer;
            }

            viewpoint MissionAndContextViewpoint { frame missionAndContext; }
            viewpoint ScenarioViewpoint { frame scenario; }
            viewpoint ArchitectureViewpoint { frame architecture; }
            viewpoint TraceabilityViewpoint { frame traceability; }
            viewpoint VerificationReadinessViewpoint { frame verificationReadiness; }

            view def MissionAndContextView :> GeneralView {
                satisfy MissionAndContextViewpoint;
            }

            view def ScenarioView :> GeneralView {
                satisfy ScenarioViewpoint;
            }

            view def ArchitectureView :> GeneralView {
                satisfy ArchitectureViewpoint;
            }

            view def TraceabilityView :> GeneralView {
                satisfy TraceabilityViewpoint;
            }

            view def VerificationReadinessView :> GeneralView {
                satisfy VerificationReadinessViewpoint;
            }
        }
    }
}
