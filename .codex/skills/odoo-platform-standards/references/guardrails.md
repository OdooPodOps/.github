# Guardrails

## Mandatory Decisions (from ADRs)
- Keep supported Odoo versions side by side in one images repository on `main`.
- Use one addons repository per client for private custom modules.
- Use one ops/config repository per client for runtime config and deployment overlays.
- Support both shared and dedicated cluster models.

## Security and Config Rules
- Never store plaintext secrets in Git.
- Do not place long-lived secrets directly on servers.
- Keep image tags and addon versions explicit and immutable per release.

## Platform Conventions
- Use repository naming `odoo-<domain>-<purpose>`.
- Keep environment model explicit: `dev`, `staging`, `prod`.
- For production release, preserve approval-gated deployment logic.

## Change Control
- If a change contradicts a spec or ADR, do not silently implement divergence.
- Propose spec update and ADR first, then implement.
