package Project {
    doc /*
      Project metadata and Elan8 Method tailoring.
      Process ownership and releases stay in Git; engineering meaning lives here.
    */

    import Elan8Method::*;

    part projectInfo : ProjectTailoring {
        attribute :>> projectName = "NewSystem";
        attribute :>> profile = small;
        attribute :>> notes = "Replace with project-specific tailoring notes.";
    }

    doc /*
      Conventions:
      - Definitions: PascalCase
      - Usages: camelCase
      - Prefer ISQ/SI quantities
      - Import Elan8* method packages; import domain/technical libraries as needed
    */
}
