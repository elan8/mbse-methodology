package GuardStopViews {
    view traceability {
        satisfy Elan8Method::Viewpoints::TraceabilityViewpoint;
        expose GuardStopContext::*;
        expose GuardStopRequirements::*;
        expose GuardStopUseCases::*;
        expose GuardStopFunctions::*;
        expose GuardStopPhysical::*;
        expose GuardStopAnalysis::*;
        expose GuardStopVerification::*;
    }
}
