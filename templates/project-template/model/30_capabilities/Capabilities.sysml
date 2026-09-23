package Capabilities {
    doc /*
      Mission-level capabilities realized by use cases. A capability states what
      the system must be able to do; use cases show the interactions that realize
      it. Straightforward technical modules may not need a distinct capability
      layer — set StageDisposition to notApplicable with a rationale instead of
      leaving this package silently empty.
    */
    @StageDisposition { stage = capabilities; status = applicable; }

    import Elan8::Method::Core::*;

    // TODO: add capabilities and their realizing use cases
}
