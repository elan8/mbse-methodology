#!/usr/bin/env python3
"""Exercise the rule contract against a live native semantic export and view."""
import argparse
import copy
import json
from pathlib import Path
import subprocess
import unittest

from check_structure import StructureChecker

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--spec42", required=True)
    parser.add_argument("--stdlib-path")
    parser.add_argument("--domain-library-path", required=True)
    args = parser.parse_args()
    common = [args.spec42, "--disable-kpar-library", "domain",
              "--disable-kpar-library", "method", "--library-path", args.domain_library_path]
    if args.stdlib_path:
        common += ["--stdlib-path", args.stdlib_path]
    workspace = str(ROOT / "examples/tooling-rules/model")
    export = json.loads(subprocess.run(
        [*common, "model-export", workspace, "--format", "json"],
        check=True, capture_output=True, text=True, encoding="utf-8").stdout)
    expected = json.loads((ROOT / "examples/tooling-rules/expected.json").read_text())

    class ContractTests(unittest.TestCase):
        elevator = None

        def elevator_export(self):
            if ContractTests.elevator is None:
                ContractTests.elevator = json.loads(subprocess.run(
                    [*common, "model-export", str(ROOT / "examples/elevator/model"), "--format", "json"],
                    check=True, capture_output=True, text=True, encoding="utf-8").stdout)
            return ContractTests.elevator

        def assert_mode(self, complete=False, single=False):
            report = StructureChecker([export], complete, single).run()
            checked = set()
            for case in expected["cases"]:
                checked.add(case["element"])
                findings = case.get("withCompleteSelection", case["expected"]) if complete else case["expected"]
                if single:
                    findings = [*findings, *case.get("withSinglePrincipalBase", [])]
                wanted = sorted((x["id"], x["severity"], x.get("feature", "")) for x in findings)
                actual = sorted((x["id"], x["severity"], x["feature"])
                                for x in report["diagnostics"] if x["element"] == case["element"])
                with self.subTest(case=case["element"]):
                    self.assertEqual(wanted, actual)
            self.assertTrue(all(x["element"] in checked for x in report["diagnostics"]),
                            "An unlisted helper definition has an unexpected diagnostic")

        def test_default_structural_cases(self):
            self.assert_mode()

        def test_complete_selection_includes_nested_and_recursive_cases(self):
            self.assert_mode(complete=True)

        def test_single_principal_base_is_an_optional_style_warning(self):
            self.assert_mode(single=True)

        def test_truncated_export_is_rejected(self):
            damaged = copy.deepcopy(export)
            damaged["projection"]["truncation"]["elements_total"] += 1
            with self.assertRaises(ValueError):
                StructureChecker([damaged])

        def test_language_errors_block_method_claims(self):
            damaged = copy.deepcopy(export)
            damaged["summary"]["error_count"] = 1
            with self.assertRaises(ValueError):
                StructureChecker([damaged])

        def test_parts_only_recipe_excludes_connections_and_ports(self):
            product = json.loads(subprocess.run(
                [*common, "diagram", workspace, "--view", "ToolingRuleExamples::partsOnly", "--format", "json"],
                check=True, capture_output=True, text=True, encoding="utf-8").stdout)
            nodes = product["projection"]["nodes"]
            self.assertEqual(2, len(nodes))
            self.assertEqual({"PartUsage"}, {x["metaclass"] for x in nodes})
            self.assertEqual({"projectionSubject", "child"}, {x["name"] for x in nodes})

        def test_requirement_is_bound_inside_specification_and_behavior_is_realized(self):
            export = self.elevator_export()
            self.assertEqual(0, export["summary"]["error_count"])
            nodes = export["projection"]["elements"]
            by_name = {x["qualified_name"]: x for x in nodes if x["name"]}
            specification = by_name["Elevator::Specification::ElevatorSpecification"]
            assertions = [x for x in nodes if x["kind"] == "SatisfyRequirementUsage"
                          and x["owner"] == specification["token"]]
            self.assertTrue(any(edge["kind"] == "satisfySource" and
                                edge["peer"]["qualified_name"] == "Elevator::Specification::acknowledgement"
                                for node in assertions for edge in node["relationships"]["outgoing"]))
            behavior = by_name["Elevator::Architecture::ElevatorArchitecture::acknowledge"]
            self.assertEqual("PerformActionUsage", behavior["kind"])
            self.assertEqual(["Elevator::Specification::ElevatorSpecification::acknowledge"],
                             [x["qualified_name"] for x in behavior["relationships"]["redefinition"]["targets"]])
            allocations = [x for x in nodes if x["kind"] == "AllocationUsage"]
            pairs = set()
            for allocation in allocations:
                edges = allocation["relationships"]["outgoing"]
                source = next(x["peer"]["qualified_name"].split("::")[-1]
                              for x in edges if x["kind"] == "allocateSource")
                target = next(x["peer"]["qualified_name"].split("::")[-1]
                              for x in edges if x["kind"] == "allocateTarget")
                pairs.add((source, target))
            self.assertEqual({("forward", "panel"), ("register", "controller"), ("present", "panel")}, pairs)
            self.assertTrue(export["projection"]["connectors"])
            for connector in export["projection"]["connectors"]:
                for end in connector["ends"]:
                    endpoint = end["endpoint"]
                    self.assertEqual("resolved", endpoint["root"]["status"])
                    self.assertEqual("resolved", endpoint["terminal"]["status"])

        def test_connected_example_has_complete_structural_definitions(self):
            report = StructureChecker([self.elevator_export()], complete=True).run()
            self.assertEqual([], report["diagnostics"])
            self.assertEqual("not-assessed", report["coverage"]["contextualConstraints"])

    result = unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(ContractTests))
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    raise SystemExit(main())
