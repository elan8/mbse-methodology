package Project {
    doc /*
      Project metadata and Elan8 Method tailoring.
      Process ownership and releases stay in Git; engineering meaning lives here.
    */

    private import Elan8Method::MethodCore::*;

    part projectInfo : ProjectInfo {
        attribute :>> projectName = "NewSystem";
        attribute :>> profile = TailoringProfileKind::small;
        attribute :>> notes = "Replace with project-specific tailoring notes.";
    }

    doc /*
      Conventions:
      - Definitions: PascalCase
      - Usages: camelCase
      - Prefer ISQ/SI quantities
      - Import narrowly from Elan8Method and the required domain namespaces
    */
}
