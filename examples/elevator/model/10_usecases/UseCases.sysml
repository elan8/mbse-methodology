package ElevatorUseCases {
    use case acknowledgeCall {
        subject elevator : Elevator::Specification::ElevatorSpecification;
        doc /* A user submits a valid call. Panel processing and controller registration
             * are serial under nominal unloaded conditions, with zero queuing or
             * communication overhead. This is not a complete executable interaction. */
    }
}
