#!/usr/bin/env bash
# Pack library/ into an Elan8 method libraries KPAR.
# Requires a Spec42 checkout with the kpar crate (sibling ../spec42 by default).

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
library_dir="${repo_root}/library"
version="${1:-0.1.0}"
artifact="${2:-elan8-method-libraries-${version}.kpar}"
out="${repo_root}/dist/${artifact}"
spec42_root="${SPEC42_ROOT:-${repo_root}/../spec42}"

if [[ ! -d "${library_dir}" ]]; then
  echo "Missing ${library_dir}" >&2
  exit 1
fi
if [[ ! -d "${spec42_root}" ]]; then
  echo "Missing Spec42 checkout at ${spec42_root}; set SPEC42_ROOT" >&2
  exit 1
fi

mkdir -p "$(dirname "${out}")"
cd "${spec42_root}"
cargo run --quiet -p kpar --bin kpar-pack -- \
  --root "${library_dir}" \
  --name elan8-method-libraries \
  --version "${version}" \
  --named-source "method=${library_dir}" \
  --output "${out}"

echo "Wrote ${out}"
