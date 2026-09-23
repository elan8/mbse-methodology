#!/usr/bin/env python3
"""Fail if a library/*.sysml definition has zero references outside library/.

Scope, deliberately: only `metadata def`, `part def`, `view def`, and
`viewpoint` declarations are checked -- the constructs a project author
would type by name (`@Foo { ... }`, `part x : Foo`, `: FooView`, `satisfy
FooViewpoint`). Two things are excluded on purpose:

- `enum def ...Kind` and `attribute def`: supporting types an author never
  spells out directly (nobody writes `attribute x : Identifier` in a
  recipe; they write `@RequirementIdentity { requirementId = "..."; }` and
  the Identifier type is exercised transitively). Checking those would only
  produce false positives.
- bare `concern` declarations: concern names are lowercase words
  (`scenario`, `architecture`, `traceability`, ...) that coincidentally
  appear all over the prose in docs/recipes regardless of whether the
  actual SysML `concern` element is ever framed by anything -- a
  reference-count check on them is closer to noise than signal. The
  `viewpoint` that frames a concern is the externally-meaningful unit.

This is a regex heuristic, not a SysML parser -- it approximates the
manual audit that removed UserRequirementRole, VerificationResult,
RequirementBaseline, TraceabilityConcern, and AbstractionLevel in 2026-09
(see the PR that introduced this script). Re-run that audit's judgment
call, don't just silence a failure by adding to the allowlist.

Usage:
    python3 scripts/check_unused_library_defs.py
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
LIBRARY_DIR = REPO_ROOT / "library"

# Search these trees for real usage. library/ itself is excluded: a
# definition referencing a sibling definition inside the library doesn't
# count as "earning its keep" -- an outside project has to use it.
SEARCH_DIRS = ["recipes", "examples", "templates", "docs"]

# Definitions that are legitimate internal building blocks with no expected
# direct outside reference. Keep this list short and justified; it is a
# deliberate exception, not a way to silence the check.
ALLOWLIST = {
    # Base part def for the three stakeholder-role usages in Viewpoints.sysml
    # (systemsEngineer, productStakeholder, verificationEngineer); those
    # usages, not the base def, are what a project would reference.
    "StakeholderRole",
}

DEF_PATTERNS = [
    re.compile(r"\b(?:metadata|part|view)\s+def\s+(?:<\w+>\s+)?(\w+)"),
    re.compile(r"\bviewpoint\s+(\w+)\s*\{"),
]


def collect_definitions() -> dict[str, Path]:
    definitions: dict[str, Path] = {}
    for sysml_file in sorted(LIBRARY_DIR.glob("*.sysml")):
        text = sysml_file.read_text(encoding="utf-8")
        for pattern in DEF_PATTERNS:
            for match in pattern.finditer(text):
                definitions[match.group(1)] = sysml_file
    return definitions


def is_referenced(name: str) -> bool:
    pattern = re.compile(rf"\b{re.escape(name)}\b")
    for dirname in SEARCH_DIRS:
        base = REPO_ROOT / dirname
        if not base.is_dir():
            continue
        for path in base.rglob("*"):
            if not path.is_file() or path.suffix not in (".md", ".sysml"):
                continue
            if pattern.search(path.read_text(encoding="utf-8", errors="ignore")):
                return True
    return False


def main() -> int:
    definitions = collect_definitions()
    unused = [
        (name, path)
        for name, path in sorted(definitions.items())
        if name not in ALLOWLIST and not is_referenced(name)
    ]

    if unused:
        print(f"{len(unused)} of {len(definitions)} library definition(s) have no "
              f"reference in {', '.join(SEARCH_DIRS)}/:\n")
        for name, path in unused:
            print(f"  {name}  ({path.relative_to(REPO_ROOT)})")
        print(
            "\nEither wire it into a recipe/example/template, add it to "
            "ALLOWLIST in this script with a one-line justification, or "
            "remove it -- see this script's docstring."
        )
        return 1

    print(f"All {len(definitions)} checked library definition(s) are referenced "
          f"outside library/.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
