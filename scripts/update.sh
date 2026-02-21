#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/update.sh [--allow-dirty] [TARGET_DIR]

Pulls latest changes for this repo, then installs kitty config files.
Default TARGET_DIR: ${XDG_CONFIG_HOME:-$HOME/.config}/kitty
EOF
}

ALLOW_DIRTY="no"
TARGET_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --allow-dirty)
      ALLOW_DIRTY="yes"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -n "${TARGET_DIR}" ]]; then
        usage
        exit 1
      fi
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

if ! command -v git >/dev/null 2>&1; then
  echo "git is required but not found in PATH." >&2
  exit 1
fi

if [[ ! -d "${REPO_DIR}/.git" ]]; then
  echo "Not a git repository: ${REPO_DIR}" >&2
  exit 1
fi

if [[ "${ALLOW_DIRTY}" != "yes" ]] && [[ -n "$(git -C "${REPO_DIR}" status --porcelain)" ]]; then
  echo "Working tree has local changes; refusing to pull." >&2
  echo "Commit/stash changes, or re-run with --allow-dirty." >&2
  exit 1
fi

git -C "${REPO_DIR}" pull --ff-only

if [[ -n "${TARGET_DIR}" ]]; then
  "${SCRIPT_DIR}/install.sh" "${TARGET_DIR}"
else
  "${SCRIPT_DIR}/install.sh"
fi

echo "Update complete."
