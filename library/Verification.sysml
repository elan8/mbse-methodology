package MethodVerification {
    doc /* Evidence references used by verification cases. Requirements use native SysML constructs. */
    private import ScalarValues::String;

    part def VerificationEvidence {
        doc /* Reference to external verification evidence. Own it within the relevant verification case; a URI alone does not establish a passing verdict. */
        attribute evidenceName : String;
        attribute evidenceUri : String;
    }
}
