package Project {
    doc /*
      Project metadata and Elan8 Method tailoring.
      Process ownership and releases stay in Git; engineering meaning lives here.
    */

    import Elan8::Method::Core::*;

    part projectInfo : ProjectInfo {
        attribute :>> projectName = "NewSystem";
        attribute :>> profile = small;
        attribute :>> notes = "Replace with project-specific tailoring notes.";
    }

    doc /*
      Conventions:
      - Definitions: PascalCase
      - Usages: camelCase
      - Prefer ISQ/SI quantities
      - Import narrowly from Elan8::Method and the required domain namespaces
    */
}
