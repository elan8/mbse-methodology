package ElevatorUseCases {
    use case acknowledgeCall {
        subject elevator : Elevator::Specification::ElevatorSpecification;
        actor user : ElevatorContext::User;
        doc /* Trigger: user sends a valid CallRequest. The panel forwards it,
             * the controller registers it, and the panel returns a
             * CallAcknowledgement carrying the same callId. Nominal unloaded
             * scenario only. See RoutedAcknowledgement for flows and ordering. */
    }
}
