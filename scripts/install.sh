#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/install.sh [TARGET_DIR]

Installs kitty config files from this repo into TARGET_DIR.
Default TARGET_DIR: ${XDG_CONFIG_HOME:-$HOME/.config}/kitty
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -gt 1 ]]; then
  usage
  exit 1
fi

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${1:-${XDG_CONFIG_HOME:-$HOME/.config}/kitty}"

FILES=(
  "kitty.conf"
  "common.conf"
  "linux.conf"
  "macos.conf"
  "theme.conf"
)

for file in "${FILES[@]}"; do
  if [[ ! -f "${REPO_DIR}/${file}" ]]; then
    echo "Missing required file: ${REPO_DIR}/${file}" >&2
    exit 1
  fi
done

mkdir -p "${TARGET_DIR}"

for file in "${FILES[@]}"; do
  cp -f "${REPO_DIR}/${file}" "${TARGET_DIR}/${file}"
  echo "Installed ${file} -> ${TARGET_DIR}/${file}"
done

echo "Install complete."
