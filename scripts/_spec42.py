"""Shared helpers for locating the spec42 CLI and its library-path arguments.

Used by validate_spec42.py.
"""
from __future__ import annotations

import os
import shutil
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def find_spec42(explicit: str | None = None) -> str:
    """Resolve the spec42 executable.

    Priority: explicit --spec42 argument > SPEC42_EXE env var > spec42 on PATH.
    """
    if explicit:
        return explicit
    env = os.environ.get("SPEC42_EXE")
    if env:
        return env
    found = shutil.which("spec42")
    if found:
        return found
    raise SystemExit(
        "Could not find the spec42 executable. Set SPEC42_EXE, pass --spec42, "
        "or install the CLI on PATH."
    )


def library_path_args() -> list[str]:
    """Check against the standard library only; exclude optional managed archives.

    `method` is the managed archive this repository used to publish; spec42 releases that still
    bundle it must not load it into these models.
    """
    return [
        "--disable-kpar-library", "domain",
        "--disable-kpar-library", "method",
    ]
