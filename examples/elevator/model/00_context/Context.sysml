package ElevatorContext {
    part def User;
    ref part user : User;
    ref part systemOfInterest : Elevator::Specification::ElevatorSpecification;
    doc /* Pilot boundary: call processing/registration under nominal unloaded
         * conditions. Movement, safety control and building infrastructure are
         * excluded. Complete boundary interfaces remain future pilot work. */
    view context : Elan8::SystemsEngineering::ContextView {
        expose ElevatorContext::**;
    }
}
