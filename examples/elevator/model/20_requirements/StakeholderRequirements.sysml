package ElevatorStakeholderRequirements {
    requirement <'ACK-NEED-01'> timelyAcknowledgement {
        subject elevator : Elevator::ElevatorSpecification;
        doc /* Synthetic pilot obligation: timely acknowledgement of a valid call.
             * Owner: pilot contract owner. ELEV-SYS-001 proposes the measurable
             * 200 ms system criterion. Operational validation is pending. */
    }
}
