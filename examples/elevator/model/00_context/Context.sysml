package ElevatorContext {
    private import ElevatorProjectLibrary::CallServicePort;
    part def User { port calls : ~CallServicePort; }
    ref part user : User;
    ref part systemOfInterest : Elevator::ElevatorSpecification;
    connect user.calls to systemOfInterest.calls;
    doc /* Boundary: one valid call request and matching acknowledgement under
         * nominal unloaded conditions. Movement, safety control and building
         * infrastructure are outside this example. */
    view context : Elan8::SystemsEngineering::ContextView {
        expose ElevatorContext::**;
    }
}
