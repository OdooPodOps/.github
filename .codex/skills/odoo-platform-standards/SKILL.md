---
name: odoo-platform-standards
description: Use when working in OdooPodOps repositories (odoo-hardened-images, odoo-addon-template-generic, odoo-addon-template-client, odoo-client-ops-template, odoo-infra-provisioning, .github, or odoo-specs). Syncs odoo-specs automatically, maps the current repository to relevant specification files, and enforces ADR and platform conventions before implementation.
metadata:
  short-description: Sync specs and enforce Odoo platform guardrails
---

# Odoo Platform Standards

## Overview
Use this skill before implementing or reviewing changes in any Odoo platform repository.
It removes manual specs pull by syncing `odoo-specs` to a local cache and loading only relevant documents.

## Workflow
1. Run `scripts/specs_context.sh` to sync specs and list mandatory files for the current repo.
2. Read all files under `Read now`.
3. Read `references/guardrails.md` and apply its checklist before editing.
4. For CI/CD tasks include `06-cicd.md`; for security include `07-security-secrets.md`; for logging/audit include `09-observability-audit.md`.
5. If a requested change conflicts with ADRs, stop and propose an ADR update in `odoo-specs/adr/`.

## Commands
```bash
bash .codex/skills/odoo-platform-standards/scripts/specs_context.sh
bash .codex/skills/odoo-platform-standards/scripts/specs_context.sh odoo-hardened-images
```

## Conventions Source
- Repository and topic mapping: `references/repo-map.md`
- Non-negotiable platform conventions: `references/guardrails.md`

## Output Requirements
- Mention the specs commit hash used.
- Mention the spec files used to make decisions.
- Mention any deviation and whether an ADR update is required.
