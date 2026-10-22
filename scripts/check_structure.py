#!/usr/bin/env python3
"""Reference BB/GB/WB structural checker for a complete Spec42 model-export JSON.

No source parsing, constraint evaluation or verification is performed. Supply
--dependency-export for project types defined outside the exported workspace.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path


MARKERS = {
    "SystemsEngineering::SystemSpecification": "BB",
    "SystemsEngineering::SystemArchitecture": "GB",
    "SystemsEngineering::SystemIntegration": "WB",
}
PRIORITY = {"NONE": 0, "BB": 1, "GB": 2, "WB": 3}


class StructureChecker:
    def __init__(self, exports, complete=False, single_base=False):
        self.nodes, self.names, self.owned = {}, {}, {}
        self.targets = set()
        for index, export in enumerate(exports):
            projection = export["projection"]
            truncation = projection["truncation"]
            if (export["summary"]["error_count"] or
                    not projection["envelope"]["complete"] or
                    truncation["elements_returned"] != truncation["elements_total"] or
                    truncation["elements_incomplete"]):
                raise ValueError("A complete, error-free semantic export is required")
            for node in projection["elements"]:
                key = node["token"]
                self.nodes[key] = node
                self.names[key] = node["qualified_name"]
                if index == 0 and node["kind"] == "PartDefinition":
                    self.targets.add(key)
                for relation in node["relationships"].values():
                    if isinstance(relation, dict):
                        for target in relation.get("targets", []):
                            self.names[target["token"]] = target["qualified_name"]
        for node in self.nodes.values():
            self.owned.setdefault(node["owner"], []).append(node["token"])
        self.complete, self.single_base = complete, single_base
        self.diagnostics = []
        self._seen = set()

    def refs(self, key, relation):
        return [x["token"] for x in self.nodes.get(key, {}).get(
            "relationships", {}).get(relation, {}).get("targets", [])]

    def ancestors(self, key, relation="specialization", active=()):
        if key in active:
            raise ValueError("Cyclic semantic ancestry/redefinition")
        result = set()
        for parent in self.refs(key, relation):
            result.add(parent)
            result.update(self.ancestors(parent, relation, (*active, key)))
        return result

    def marker(self, key):
        return MARKERS.get(self.names.get(key))

    def role(self, key):
        roles = [self.marker(x) for x in {key, *self.ancestors(key)}]
        return max((r for r in roles if r), key=PRIORITY.get, default="NONE")

    def bases(self, key, role):
        candidates = {x for x in self.ancestors(key)
                      if not self.marker(x) and self.role(x) == role}
        return {x for x in candidates if not any(
            x in self.ancestors(other) for other in candidates - {x})}

    def parts_owned(self, key):
        # Export schema 1 uses the concrete native metaclass. In particular,
        # ConnectionUsage/ViewUsage are NOT constituent PartUsage records.
        return [x for x in self.owned.get(key, [])
                if self.nodes[x]["kind"] == "PartUsage"]

    def merge(self, inherited, own):
        result = list(dict.fromkeys(inherited))
        for feature in own:
            redefined = self.ancestors(feature, "redefinition")
            result = [x for x in result if x not in redefined]
            if feature not in result:
                result.append(feature)
        return result

    def parts(self, key, active=()):
        if key in active:
            raise ValueError("Cyclic definition specialization")
        inherited = []
        for parent in self.refs(key, "specialization"):
            inherited += self.parts(parent, (*active, key))
        return self.merge(inherited, self.parts_owned(key))

    def types(self, feature):
        declared = self.refs(feature, "typing")
        if declared:
            return declared
        return list(dict.fromkeys(t for base in self.refs(feature, "redefinition")
                                  for t in self.types(base)))

    def feature_name(self, feature):
        node = self.nodes[feature]
        if node["name"]:
            return node["name"]
        bases = self.refs(feature, "redefinition")
        return self.feature_name(bases[0]) if bases else "<anonymous>"

    def absent(self, feature):
        multiplicity = self.nodes[feature].get("multiplicity")
        return bool(multiplicity and multiplicity.get("upper") in (0, "0"))

    def terminal(self, feature):
        """An ordinary typed leaf needs no artificial system-role adapter.

        Reject unmarked composites and usage-local composition: they must not
        conceal subsystem contracts or bypass recursive selection checks.
        """
        types = self.types(feature)
        local = {feature, *self.ancestors(feature, "redefinition")}
        return bool(types) and not any(self.parts_owned(x) for x in local) and all(
            self.role(t) == "NONE" and not self.parts(t) for t in types)

    def unresolved(self, key):
        # References to the exact role objects are sufficient; unknown imported
        # project definitions need a dependency export rather than guessing.
        return any(x not in self.nodes and not self.marker(x)
                   for x in {key, *self.ancestors(key)})

    def emit(self, code, root, feature=None, path="", severity="error", message=""):
        key = (code, root, feature, path)
        if key in self._seen:
            return
        self._seen.add(key)
        node = self.nodes[feature or root]
        self.diagnostics.append({
            "id": code, "severity": severity,
            "status": "unresolved" if code == "E8-EXPORT-001" else "violation",
            "element": self.names[root], "feature": path,
            "offendingElement": node["qualified_name"],
            "location": node["location"], "message": message,
        })

    def check_definition(self, key):
        role = self.role(key)
        if role == "NONE" or self.marker(key):
            return
        if self.unresolved(key):
            self.emit("E8-EXPORT-001", key, severity="info",
                      message="Import the missing project dependency export; checks deferred.")
            return
        if role == "BB":
            for child in self.parts(key):
                self.emit("E8-BB-001", key, child, self.feature_name(child),
                          message="BB contains a structural part/reference.")
            return
        required = self.bases(key, "BB" if role == "GB" else "GB")
        if not required:
            self.emit("E8-GB-001" if role == "GB" else "E8-WB-001", key,
                      message="Missing actual specification/architecture specialization.")
            return
        if self.single_base and len(required) > 1:
            self.emit("E8-STYLE-001", key, severity="warning",
                      message="Optional single-principal-base convention is not met.")
        if role == "GB":
            for child in self.parts(key):
                types = self.types(child)
                if any(self.unresolved(t) for t in types):
                    self.emit("E8-EXPORT-001", key, child, self.feature_name(child),
                              severity="info", message="Child type ancestry is unavailable.")
                elif not self.terminal(child) and (not any(self.role(t) == "BB" and not self.marker(t) for t in types)
                      or any(self.role(t) in ("GB", "WB") for t in types)):
                    self.emit("E8-GB-002", key, child, self.feature_name(child),
                              message="GB child must be typed by a project BB contract or an ordinary typed leaf.")
            return
        inherited = list(dict.fromkeys(x for base in required for x in self.parts(base)))
        effective = self.parts(key)
        for child in effective:
            targets = {child, *self.ancestors(child, "redefinition")}
            if not targets.intersection(inherited):
                self.emit("E8-WB-002", key, child, self.feature_name(child),
                          message="New WB composition has no inherited child identity.")
        for original in inherited:
            replacements = [x for x in effective
                            if x == original or original in self.ancestors(x, "redefinition")]
            if len(replacements) > 1:
                self.emit("E8-WB-002", key, original, self.feature_name(original),
                          message="Competing replacements for one inherited child.")
                continue
            if not replacements:
                continue
            child = replacements[0]
            if self.absent(child):
                continue
            path = self.feature_name(child)
            types = self.types(child)
            designs = [t for t in types if self.role(t) in ("GB", "WB") and not self.marker(t)]
            ordinary = self.terminal(original) and self.terminal(child)
            if ordinary:
                designs = types
            if not designs:
                code = "E8-WB-004" if child == original else "E8-WB-003"
                self.emit(code, key, child, path,
                          severity="error" if code != "E8-WB-004" or self.complete else "warning",
                          message="Constituent has no selected child design.")
                continue
            if any(self.unresolved(t) for t in designs):
                self.emit("E8-EXPORT-001", key, child, path, severity="info",
                          message="Selected design ancestry is unavailable.")
                continue
            if not all(any(contract == design or contract in self.ancestors(design)
                           for design in designs) for contract in self.types(original)):
                self.emit("E8-WB-005", key, child, path,
                          message="Selected design does not specialize the inherited contract.")
            if not ordinary:
                self.check_nested(key, child, designs, path, (key,))

    def check_nested(self, root, selected, designs, path, active):
        for design in designs:
            if design in active:
                self.emit("E8-WB-004", root, selected, path,
                          severity="error" if self.complete else "warning",
                          message="Recursive design: selection completeness is unresolved.")
                continue
            children = self.merge(self.parts(design), self.parts_owned(selected))
            for child in children:
                if self.absent(child):
                    continue
                child_path = path + "." + self.feature_name(child)
                types = self.types(child)
                if any(self.unresolved(t) for t in types):
                    self.emit("E8-EXPORT-001", root, child, child_path, severity="info",
                              message="Nested child ancestry is unavailable.")
                    continue
                if self.terminal(child):
                    continue
                next_designs = [t for t in types
                                if self.role(t) in ("GB", "WB") and not self.marker(t)]
                if not next_designs:
                    self.emit("E8-WB-004", root, child, child_path,
                              severity="error" if self.complete else "warning",
                              message="Selected design contains an unresolved child contract.")
                else:
                    self.check_nested(root, child, next_designs, child_path, (*active, design))

    def run(self):
        for key in sorted(self.targets, key=lambda x: self.names[x]):
            self.check_definition(key)
        return {"checker": "elan8-structural-reference", "catalogVersion": "0.4.0",
                "coverage": {"definitionStructure": "partially-assessed" if any(
                    x["id"] == "E8-EXPORT-001" for x in self.diagnostics) else "checked",
                             "usageLocalRootOverrides": "not-assessed",
                             "contextualConstraints": "not-assessed", "verification": "not-assessed"},
                "options": {"completeSelection": self.complete,
                            "singlePrincipalBase": self.single_base},
                "diagnostics": self.diagnostics}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("export", type=Path)
    parser.add_argument("--dependency-export", action="append", default=[], type=Path)
    parser.add_argument("--complete-selection", action="store_true")
    parser.add_argument("--single-principal-base", action="store_true")
    parser.add_argument("--format", choices=["text", "json"], default="text")
    args = parser.parse_args()
    try:
        exports = [json.loads(path.read_text(encoding="utf-8-sig"))
                   for path in [args.export, *args.dependency_export]]
        report = StructureChecker(exports, args.complete_selection, args.single_principal_base).run()
    except (ValueError, KeyError, OSError) as error:
        parser.exit(2, f"Cannot check semantic export: {error}\n")
    if args.format == "json":
        print(json.dumps(report, indent=2))
    else:
        for item in report["diagnostics"]:
            print(f"{item['severity']} {item['id']} {item['element']} {item['feature']}: {item['message']}")
        print("Structural definition checks only; root usage overrides, constraints and evidence not assessed.")
    return int(any(x["severity"] == "error" for x in report["diagnostics"]))


if __name__ == "__main__":
    raise SystemExit(main())
