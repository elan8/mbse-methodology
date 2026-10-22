#!/usr/bin/env python3
"""Exercise the rule contract against a live native semantic export and view."""
import argparse
import copy
import json
from pathlib import Path
import subprocess
import tempfile
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
            specification = by_name["Elevator::ElevatorSpecification"]
            assertions = [x for x in nodes if x["kind"] == "SatisfyRequirementUsage"
                          and x["owner"] == specification["token"]]
            self.assertTrue(any(edge["kind"] == "satisfySource" and
                                edge["peer"]["qualified_name"] == "Elevator::acknowledgement"
                                for node in assertions for edge in node["relationships"]["outgoing"]))
            behavior = by_name["Elevator::ElevatorArchitecture::acknowledge"]
            self.assertEqual("PerformActionUsage", behavior["kind"])
            self.assertEqual(["Elevator::ElevatorSpecification::acknowledge"],
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

        def test_roles_and_selections_are_independent_of_package_layout(self):
            # Arbitrary type/group names deliberately avoid role suffixes and
            # the Specification/Architecture/Integration package convention.
            source = """
package Shared {
    part def A :> Elan8::SystemsEngineering::SystemSpecification;
    part def B :> A, Elan8::SystemsEngineering::SystemArchitecture;
}
package Flat {
    part def A :> Elan8::SystemsEngineering::SystemSpecification;
    part def B :> A, Elan8::SystemsEngineering::SystemArchitecture {
        part child : Shared::A;
    }
    part def C :> B, Elan8::SystemsEngineering::SystemIntegration {
        part child : Shared::B :>> child;
    }
}
package Grouped {
    package Contracts {
        part def A :> Elan8::SystemsEngineering::SystemSpecification;
    }
    package Designs {
        part def B :> Contracts::A, Elan8::SystemsEngineering::SystemArchitecture {
            part child : Shared::A;
        }
    }
    package Baselines {
        part def C :> Designs::B, Elan8::SystemsEngineering::SystemIntegration {
            part child : Shared::B :>> child;
        }
    }
}
"""
            cache = ROOT / ".cache"
            cache.mkdir(exist_ok=True)
            with tempfile.TemporaryDirectory(prefix="namespace-layout-", dir=cache) as directory:
                path = Path(directory) / "Layout.sysml"
                path.write_text(source, encoding="utf-8")
                native = json.loads(subprocess.run(
                    [*common, "model-export", str(path), "--format", "json"],
                    check=True, capture_output=True, text=True, encoding="utf-8").stdout)
            self.assertEqual(0, native["summary"]["error_count"])
            self.assertEqual(0, native["summary"]["warning_count"])
            checker = StructureChecker([native], complete=True)
            self.assertEqual([], checker.run()["diagnostics"])
            for name, role in {"Flat::A": "BB", "Flat::B": "GB", "Flat::C": "WB",
                               "Grouped::Contracts::A": "BB", "Grouped::Designs::B": "GB",
                               "Grouped::Baselines::C": "WB"}.items():
                key = next(key for key, value in checker.names.items() if value == name)
                self.assertEqual(role, checker.role(key), name)

        def test_flat_specification_view_does_not_select_designs(self):
            product = json.loads(subprocess.run(
                [*common, "diagram", str(ROOT / "examples/elevator/model"),
                 "--view", "Elevator::Views::specification", "--format", "json"],
                check=True, capture_output=True, text=True, encoding="utf-8").stdout)
            self.assertEqual("complete", product["completeness"]["status"])
            roots = {product["references"][product["projection"]["nodes"][key]["reference"]]["qualifiedName"]
                     for key in product["projection"]["exposedRoots"]}
            self.assertEqual({"Elevator::ElevatorSpecification", "Elevator::AcknowledgeCall",
                              "Elevator::AcknowledgementRequirement", "Elevator::acknowledgement"}, roots)
            names = {node["name"] for node in product["projection"]["nodes"]}
            self.assertTrue(names.isdisjoint({"ElevatorArchitecture", "ElevatorReleaseAIntegration", "releaseA"}))

        def test_native_leaf_parts_need_no_system_role_adapters(self):
            source = """
package LeafCases {
    private import Elan8::SystemsEngineering::*;
    part def Leaf;
    part def SelectedLeaf :> Leaf;
    part def Contract :> SystemSpecification;
    part def Design :> Contract, SystemArchitecture {
        part supplied : Leaf;
    }
    part def Inherited :> Design, SystemIntegration;
    part def Selected :> Design, SystemIntegration {
        part supplied : SelectedLeaf :>> supplied;
    }
    part def OuterContract :> SystemSpecification;
    part def OuterDesign :> OuterContract, SystemArchitecture {
        part child : Contract;
    }
    part def OuterSelected :> OuterDesign, SystemIntegration {
        part child : Selected :>> child;
    }
    part def HiddenComposite {
        part child : Contract;
    }
    part def InvalidHidden :> Contract, SystemArchitecture {
        part hidden : HiddenComposite;
    }
    part def InvalidLocal :> Contract, SystemArchitecture {
        part hidden : Leaf { part child : Contract; }
    }
    part def InvalidSelected :> Design, SystemIntegration {
        part supplied : Leaf :>> supplied { part child : Contract; }
    }
}
"""
            cache = ROOT / ".cache"
            cache.mkdir(exist_ok=True)
            with tempfile.TemporaryDirectory(prefix="native-leaves-", dir=cache) as directory:
                path = Path(directory) / "Leaves.sysml"
                path.write_text(source, encoding="utf-8")
                native = json.loads(subprocess.run(
                    [*common, "model-export", str(path), "--format", "json"],
                    check=True, capture_output=True, text=True, encoding="utf-8").stdout)
            self.assertEqual(0, native["summary"]["error_count"])
            for complete in (False, True):
                report = StructureChecker([native], complete=complete).run()
                findings = {(x["element"], x["id"]) for x in report["diagnostics"]}
                self.assertEqual({("LeafCases::InvalidHidden", "E8-GB-002"),
                                  ("LeafCases::InvalidLocal", "E8-GB-002"),
                                  ("LeafCases::InvalidSelected", "E8-WB-003")}, findings)

    result = unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(ContractTests))
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    raise SystemExit(main())
