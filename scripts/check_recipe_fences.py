#!/usr/bin/env python3
"""Syntax-check every ```sysml code fence in recipes/*.md.

Recipe examples are often deliberately incomplete fragments (undefined
external types, missing imports, no enclosing package) so this does NOT
resolve them against the method/domain libraries -- that would fail on
every intentionally-partial example. It only checks that each fence is
well-formed SysML syntax (balanced braces, valid statements), the same
class of mistake a forgotten brace or malformed keyword would produce.

This will NOT catch a fence that parses cleanly but is semantically
pointless (for example a stray, unnamed `metadata def` used as a comment)
-- that still needs a human reviewer. It only guards against outright
breakage.

Usage:
    python3 scripts/check_recipe_fences.py
    python3 scripts/check_recipe_fences.py --spec42 /path/to/spec42
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _spec42 import REPO_ROOT, find_spec42  # noqa: E402

FENCE_RE = re.compile(r"```sysml\n(.*?)```", re.DOTALL)


def find_fences(markdown_path: Path) -> list[tuple[int, str]]:
    text = markdown_path.read_text(encoding="utf-8")
    fences = []
    for match in FENCE_RE.finditer(text):
        line_no = text.count("\n", 0, match.start()) + 1
        fences.append((line_no, match.group(1)))
    return fences


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--spec42", help="Path to the spec42 executable")
    args = parser.parse_args()
    spec42 = find_spec42(args.spec42)

    recipes_dir = REPO_ROOT / "recipes"
    failures: list[tuple[Path, int, str]] = []
    checked = 0

    with tempfile.TemporaryDirectory() as tmp:
        tmp_path = Path(tmp)
        for md_file in sorted(recipes_dir.glob("*.md")):
            for line_no, fence in find_fences(md_file):
                checked += 1
                fence_file = tmp_path / f"fence_{checked}.sysml"
                fence_file.write_text(fence, encoding="utf-8")
                result = subprocess.run(
                    [spec42, "check", "--no-stdlib", str(fence_file)],
                    capture_output=True,
                    text=True,
                )
                if result.returncode != 0:
                    rel = md_file.relative_to(REPO_ROOT)
                    failures.append((rel, line_no, result.stdout + result.stderr))

    if failures:
        print(f"{len(failures)} of {checked} sysml fence(s) failed to parse:\n")
        for path, line_no, output in failures:
            print(f"--- {path}:{line_no} ---")
            print(output.strip())
            print()
        return 1

    print(f"All {checked} sysml fence(s) in recipes/ parse cleanly.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
