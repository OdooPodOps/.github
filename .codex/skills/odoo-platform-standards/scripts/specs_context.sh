#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYNC_OUTPUT="$(${SCRIPT_DIR}/sync_specs.sh)"

specs_dir="$(printf '%s\n' "$SYNC_OUTPUT" | awk -F= '/^SPECS_DIR=/{print substr($0, index($0, "=") + 1)}')"
specs_commit="$(printf '%s\n' "$SYNC_OUTPUT" | awk -F= '/^SPECS_COMMIT=/{print substr($0, index($0, "=") + 1)}')"
specs_source="$(printf '%s\n' "$SYNC_OUTPUT" | awk -F= '/^SPECS_SOURCE=/{print substr($0, index($0, "=") + 1)}')"

repo_name="${1:-}"
if [ -z "$repo_name" ]; then
  if git_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
    repo_name="$(basename "$git_root")"
  else
    repo_name="$(basename "$(pwd)")"
  fi
fi

core_files=(
  "00-vision.md"
  "01-architecture.md"
  "adr/ADR-0001-odoo-image-versioning-strategy.md"
  "adr/ADR-0002-client-repository-strategy.md"
  "adr/ADR-0003-shared-vs-dedicated-cluster-model.md"
)

repo_files=()
case "$repo_name" in
  odoo-hardened-images)
    repo_files+=("02-images.md")
    ;;
  odoo-addon-template-generic)
    repo_files+=("03-addons-generic.md")
    ;;
  odoo-addon-template-client)
    repo_files+=("04-addons-client.md")
    ;;
  odoo-client-ops-template)
    repo_files+=("05-ops-config.md")
    ;;
  odoo-infra-provisioning)
    repo_files+=("08-infra-provisioning.md")
    ;;
  odoo-specs)
    repo_files+=("10-implementation-backlog.md" "11-execution-order.md")
    ;;
  .github)
    repo_files+=("10-implementation-backlog.md")
    ;;
esac

optional_files=(
  "06-cicd.md"
  "07-security-secrets.md"
  "09-observability-audit.md"
)

printf 'Specs directory: %s\n' "$specs_dir"
printf 'Specs commit: %s\n' "$specs_commit"
printf 'Specs source: %s\n' "$specs_source"
printf 'Target repository: %s\n\n' "$repo_name"

echo "Read now:"
for f in "${core_files[@]}"; do
  if [ -f "$specs_dir/$f" ]; then
    printf -- '- %s\n' "$specs_dir/$f"
  fi
done
for f in "${repo_files[@]}"; do
  if [ -f "$specs_dir/$f" ]; then
    printf -- '- %s\n' "$specs_dir/$f"
  fi
done

echo
echo "Read if relevant to current task:"
for f in "${optional_files[@]}"; do
  if [ -f "$specs_dir/$f" ]; then
    printf -- '- %s\n' "$specs_dir/$f"
  fi
done
