package Elan8Method {
    doc /* Canonical facade for Elan8 Method vocabulary. Leaf packages are declared once in separate files. */
    package Verification {
        public import MethodVerification::*;
    }
    package Metadata {
        public import MethodMetadata::*;
    }
    public import MethodCore;
    public import Viewpoints;
}
