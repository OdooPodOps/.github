# OdooPodOps

OdooPodOps is an engineering platform for Odoo integrators who need secure, repeatable, multi-client operations on Kubernetes.
Our goal is to run each client in isolated runtime boundaries while preserving fast delivery, controlled deployments, and strong security defaults.

## Project Goals

- Standardize Odoo development and operations across all clients.
- Make upgrades and deployments reproducible from Git repositories.
- Support both shared-cluster and dedicated-cluster operating models.
- Enforce security, secrets hygiene, and auditability as platform defaults.

## Repository Map

- [odoo-specs](https://github.com/OdooPodOps/odoo-specs): platform specifications, roadmap phases, and ADRs.
- [odoo-ai-skills](https://github.com/OdooPodOps/odoo-ai-skills): repository-scoped AI skills for Codex and Claude Code.
- [odoo-hardened-images](https://github.com/OdooPodOps/odoo-hardened-images): hardened base images for supported Odoo versions.
- [odoo-addon-template-generic](https://github.com/OdooPodOps/odoo-addon-template-generic): template for reusable multi-client addons.
- [odoo-addon-template-client](https://github.com/OdooPodOps/odoo-addon-template-client): template for client-private addons.
- [odoo-client-ops-template](https://github.com/OdooPodOps/odoo-client-ops-template): template for per-client Kubernetes and ops configuration.
- [odoo-infra-provisioning](https://github.com/OdooPodOps/odoo-infra-provisioning): infrastructure provisioning and hardening modules.

## Delivery Model

- V0.1: standardization of repositories and conventions.
- V0.2: CI/CD automation and controlled promotions.
- V0.3: secrets and security controls.
- V0.4: secure infrastructure provisioning.
- V0.5: logging, observability, and recurring audits.

## Working Principles

- Explicit standards over hidden conventions.
- No secrets in repositories.
- Production changes require controlled gates.
- Architecture decisions are tracked with ADRs.
