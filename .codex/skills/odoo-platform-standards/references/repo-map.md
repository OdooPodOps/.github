# Repo to Spec Mapping

## Core Files (always read)
- `00-vision.md`
- `01-architecture.md`
- `adr/ADR-0001-odoo-image-versioning-strategy.md`
- `adr/ADR-0002-client-repository-strategy.md`
- `adr/ADR-0003-shared-vs-dedicated-cluster-model.md`

## Repository-Specific Files
- `odoo-hardened-images` -> `02-images.md`
- `odoo-addon-template-generic` -> `03-addons-generic.md`
- `odoo-addon-template-client` -> `04-addons-client.md`
- `odoo-client-ops-template` -> `05-ops-config.md`
- `odoo-infra-provisioning` -> `08-infra-provisioning.md`
- `odoo-specs` -> `10-implementation-backlog.md`, `11-execution-order.md`
- `.github` -> `01-architecture.md`, `10-implementation-backlog.md`

## Topic Extensions
- CI/CD, pipeline, deploy, backup -> `06-cicd.md`
- security, secrets, ssh, rotation -> `07-security-secrets.md`
- observability, logging, audit, dashboard -> `09-observability-audit.md`
