#!/usr/bin/env bash
# Pack library/ into an Elan8 method libraries KPAR.
# Requires an installed kpar-pack executable; override its path with KPAR_PACK_EXE.

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
library_dir="${repo_root}/library"
version="${1:-0.1.0}"
artifact="${2:-elan8-method-libraries-${version}.kpar}"
out="${repo_root}/dist/${artifact}"
packer="${KPAR_PACK_EXE:-kpar-pack}"

if [[ ! -d "${library_dir}" ]]; then
  echo "Missing ${library_dir}" >&2
  exit 1
fi
if ! command -v "${packer}" >/dev/null 2>&1; then
  echo "Missing KPAR packer: ${packer}; install kpar-pack or set KPAR_PACK_EXE" >&2
  exit 1
fi

mkdir -p "$(dirname "${out}")"
"${packer}" \
  --root "${library_dir}" \
  --name elan8-method-libraries \
  --version "${version}" \
  --named-source "method=${library_dir}" \
  --output "${out}"

echo "Wrote ${out}"
