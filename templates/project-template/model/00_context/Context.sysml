package ProjectContext {
    ref part systemOfInterest : Product::Specification::ProductSpecification;
    doc /* TODO: boundary, environment, referenced external participants,
         * lifecycle situations, exclusions and exchanges. */
    view context : Elan8::SystemsEngineering::ContextView {
        expose ProjectContext::**;
    }
}
