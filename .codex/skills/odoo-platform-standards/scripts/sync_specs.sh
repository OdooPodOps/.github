#!/usr/bin/env bash
set -euo pipefail

BRANCH="${ODOO_SPECS_BRANCH:-main}"
DEFAULT_REMOTE="https://github.com/OdooPodOps/odoo-specs.git"
REMOTE_URL="${ODOO_SPECS_REPO_URL:-$DEFAULT_REMOTE}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_AGENT_HOME="$(cd "$SCRIPT_DIR/../../.." && pwd)"

if [ -n "${CODEX_HOME:-}" ]; then
  CODEX_HOME_DIR="$CODEX_HOME"
elif [ "$(basename "$LOCAL_AGENT_HOME")" = ".codex" ] || [ "$(basename "$LOCAL_AGENT_HOME")" = ".claude" ]; then
  CODEX_HOME_DIR="$LOCAL_AGENT_HOME"
else
  CODEX_HOME_DIR="$HOME/.codex"
fi

CACHE_DIR="${CODEX_HOME_DIR}/cache/odoo-platform-standards"
SPECS_DIR="${CACHE_DIR}/odoo-specs"

find_local_fallback() {
  if [ -n "${ODOO_SPECS_LOCAL_PATH:-}" ] && [ -d "${ODOO_SPECS_LOCAL_PATH}/.git" ]; then
    printf '%s\n' "${ODOO_SPECS_LOCAL_PATH}"
    return
  fi

  local repo_root
  local sibling
  if repo_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
    sibling="${repo_root}/../odoo-specs"
  else
    sibling="$(cd . && pwd)/../odoo-specs"
  fi

  if [ -d "${sibling}/.git" ]; then
    printf '%s\n' "${sibling}"
    return
  fi

  printf '\n'
}

sync_repo() {
  local source="$1"

  mkdir -p "$CACHE_DIR"

  if [ ! -d "${SPECS_DIR}/.git" ]; then
    if [ -d "$SPECS_DIR" ] && [ ! -d "${SPECS_DIR}/.git" ]; then
      rm -rf "$SPECS_DIR"
    fi
    git clone --depth 1 --branch "$BRANCH" "$source" "$SPECS_DIR" >/dev/null 2>&1
  else
    git -C "$SPECS_DIR" remote set-url origin "$source"
    git -C "$SPECS_DIR" fetch --depth 1 origin "$BRANCH" >/dev/null 2>&1
    if git -C "$SPECS_DIR" show-ref --verify --quiet "refs/heads/$BRANCH"; then
      git -C "$SPECS_DIR" checkout -q "$BRANCH"
    else
      git -C "$SPECS_DIR" checkout -q -b "$BRANCH" "origin/$BRANCH"
    fi
    git -C "$SPECS_DIR" reset --hard -q "origin/$BRANCH"
  fi
}

fallback_source="$(find_local_fallback)"
sync_source="$REMOTE_URL"

if ! sync_repo "$REMOTE_URL"; then
  if [ -n "$fallback_source" ]; then
    sync_source="$fallback_source"
    sync_repo "$fallback_source"
  elif [ -d "${SPECS_DIR}/.git" ]; then
    sync_source="cache-only"
  else
    echo "Could not sync odoo-specs from remote or local fallback." >&2
    echo "Set ODOO_SPECS_REPO_URL or ODOO_SPECS_LOCAL_PATH." >&2
    exit 1
  fi
fi

commit="$(git -C "$SPECS_DIR" rev-parse HEAD)"

echo "SPECS_DIR=$SPECS_DIR"
echo "SPECS_COMMIT=$commit"
echo "SPECS_BRANCH=$BRANCH"
echo "SPECS_SOURCE=$sync_source"
