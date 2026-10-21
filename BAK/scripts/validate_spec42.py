#!/usr/bin/env python3
"""Run `spec42 check` over the whole mbse-methodology workspace.

Python replacement for the old validate-spec42.ps1 (this repo's tooling no
longer depends on PowerShell). Usage:

    python3 scripts/validate_spec42.py
    python3 scripts/validate_spec42.py --spec42 /path/to/spec42 --format json
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from _spec42 import REPO_ROOT, find_spec42, library_path_args  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--spec42", help="Path to the spec42 executable")
    parser.add_argument(
        "--format", choices=["text", "json", "sarif", "junit"], default="text"
    )
    args = parser.parse_args()

    spec42 = find_spec42(args.spec42)
    command = [
        spec42,
        *library_path_args(),
        "check",
        str(REPO_ROOT),
        "--workspace-root",
        str(REPO_ROOT),
        "--format",
        args.format,
    ]
    return subprocess.run(command).returncode


if __name__ == "__main__":
    raise SystemExit(main())
