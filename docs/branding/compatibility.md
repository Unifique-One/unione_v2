# UNIFIQUE ONE — Compatibility and resilience rules

## 1. Core resilience rules

1. **Images are disposable; volumes and central assets are not.** All branding must live in Podman named volumes or officially supported extension points mounted from `/opt/unione/branding/`. Replacing an image must not remove the identity.
2. **One source of truth.** Colours, typography, spacing, logo and favicon are defined once under `/opt/unione/branding/tokens/` and `assets/`. Applications consume derived files; they do not keep independent copies of brand values.
3. **Official interfaces only.** Use Nextcloud theming/OCC and documented app settings. If an app has no stable hook, record the limitation in `exceptions.md` rather than patching its bundled CSS/JS inside the image.
4. **No blind replacements.** Never replace every occurrence of the word "Nextcloud". Licence notices, attribution, version strings, security warnings and audit data must survive upgrades.
5. **Pinned and reversible.** Record image tag/digest and app versions before upgrade; keep the previous digest available for rollback.
6. **Backup before change.** Each upgrade is preceded by a verified backup of config/data/theme volumes, tunnel configuration and **Traefik static/dynamic config and router rules**, with a checksum manifest.
7. **Re-apply, then verify.** After every upgrade, re-run the idempotent branding scripts from `/opt/unione/scripts/branding/`, then execute the relevant sections of `validation.md`.
8. **Secrets stay out.** No API token, certificate private key or mail credential may be committed to the project tree; rotate the exposed token (E-06).
9. **Scope stays fixed.** **Only `csphere.cloud` may be altered**: no other domain or zone is changed. The 17 unrelated tunnels and `console`/`csphere-api`/`csphere` DNS records are never touched during maintenance.
10. **Proxy stays fixed.** **Traefik** is the reverse proxy; no Caddy component, config or route may be introduced. Request path is cloudflared tunnel → Traefik → service.
11. **Stable container names.** Names follow `pt/container.md`: `unione-traefik` (reverse proxy) and `unione-cloudflared` (tunnel), alongside `unione-postgres`, `unione-redis`, `unione-nextcloud`, `unione-collabora`, `unione-coturn` and `unione-status`. The `traefik` network alias remains because Tunnel ingress targets `http://traefik:80`; the `cloudflared` alias may remain. Ollama is excluded.

## 2. Upgrade procedure

| Step | Action | Evidence to keep |
| --- | --- | --- |
| 1 | Record current versions: Podman, crun, Nextcloud core, every enabled app, Office/Collabora component, cloudflared (`unione-cloudflared`), **Traefik** (`unione-traefik`) | Version snapshot file |
| 2 | Create and checksum pre-upgrade backups of affected volumes, tunnel config and **Traefik router rules** | Backup name + checksum manifest |
| 3 | Upgrade **one component at a time** using pinned images/app versions | Change log entry |
| 4 | Confirm volumes are remounted with the same names and permissions (SELinux labels on Rocky Linux 9.4 where bind mounts are used) | Mount inspection record |
| 5 | Re-run idempotent branding apply scripts | Drift report showing only intended changes |
| 6 | Re-check the matrix in section 3 | Completed checklist |
| 7 | If a check fails, roll back using section 4 and record the exception | Rollback note |

## 3. What must be rechecked after any upgrade

### 3.1 Platform and runtime

- Podman still 5.8.2-class rootful runtime with crun; container starts without manual intervention.
- Default network and any new networks do not change service-to-service addressing; named volumes are attached to the correct containers.
- Resource headroom still acceptable: 4 vCPU, ~6.4 GiB available RAM, 52 GiB free on `/` before the upgrade.
- Bind-mount/SELinux labels remain valid; theme assets stay read-only.
- **Traefik** still starts with the pinned image and its config volume attached; no Caddy process or config appears after the upgrade.
- Container names remain `unione-traefik` and `unione-cloudflared`; the `traefik` network alias still resolves for Tunnel ingress at `http://traefik:80`.

### 3.2 Nextcloud core and theming

- `occ status` and `occ app:list` succeed; enabled app list matches the documented inventory.
- Stored theming values (`occ config:app:get theming name`, `slogan`, colour keys) still read `UNIFIQUE ONE` and `#212492`-based official values.
- Login page, header, navigation, dashboard, share dialogs and public share links still show the official wordmark and official PNG favicon (`favicon-32x32-01e518e661.png`) and no unintended Nextcloud product identity.
- Custom theme directory (if used) is still mounted and has not been overwritten by image content.
- CSS custom-property bridge is intact: `--color-primary`, `--color-primary-element`, `--color-primary-element-hover`, `--color-primary-element-text`, `--color-main-background`, `--color-background-hover`, `--color-main-text`, `--color-text-maxcontrast`, `--color-border`. Upstream renames require updating central tokens, not per-app patches.
- Legal/notice text, licence credits and version/security information remain visible where required.

### 3.3 Applications — check each individually

- Files (list/grid, details drawer, empty state), Photos, Calendar, Contacts, Talk (including in-call UI), Deck/Board/Projects view, Notes, Tasks, Forms (**public** form page), Whiteboard, Office editor chrome, **Nextcloud Assistant UI for `ai` only (no Ollama backend or local model)**, Mail webmail, Status page and Admin pages.
- Favicon and `rel="icon"`/PWA manifest entries on each web surface; verify the official PNG/ICO files from `https://unifique.com.br/` are in use (`favicon-32x32-01e518e661.png`, `apple-touch-icon-c435f4f4da.png`, `favicon-cd754f5597.ico`) and the wordmark-derived `favicon.svg` is only a legacy fallback (E-01 RESOLVED 2026-11-27).
- Fonts: Plus Jakarta Sans and Inter still resolve from the approved local/hosted source; fallback rendering is acceptable. If a CDN is used, confirm it is still approved and pinned; do not silently introduce a new external dependency.
- Icons: if Lucide or another icon set is used, confirm version/pinning and that icons render on all target surfaces.
- Mobile web breakpoints (≈375 px and ≈768 px) still collapse navigation and keep touch targets usable.

### 3.4 DNS, tunnel and out-of-scope resources

- All 20 hostnames from `inventory.md` resolve and route through cloudflared → **Traefik** → the intended service.
- **Traefik** router rules still match only `csphere.cloud` hostnames; no router, DNS record or tunnel hostname exists for any other domain. No Caddy route exists.
- Alias pairs remain identical in content: `drive`/`files`, `board`/`whiteboard`, `id`/`auth`; `projects` still lands on the Deck view.
- cloudflared configuration schema still accepts `/root/.cloudflared/config.yml`; `cert.pem` exists; tunnel UUID and public-hostname rules are unchanged.
- `api`, `console`, `csphere-api`, `csphere` records are unchanged; the 17 unrelated tunnels are unchanged and still out of scope.
- Token rotation status is current; no plaintext token appears in documentation, scripts or config files.

### 3.5 Backups

- A new pre-upgrade backup exists with a checksum manifest.
- Restore drill into a scratch volume succeeded after the previous upgrade; result recorded in `validation.md`.
- Post-change state is backed up before the next maintenance window.

## 4. Rollback

1. Stop only the affected service(s); do not stop unrelated services or tunnels.
2. Restore the pre-upgrade named volumes and config files from the dated backup, including **Traefik config and router rules**; verify checksums before use.
3. Redeploy the previously pinned image digest/app version.
4. Re-run the idempotent branding scripts against the restored state.
5. Re-run the affected checks from `validation.md` and record the rollback in the change log.
6. If the cause was an upstream branding change, update central tokens/themes and retest before attempting the upgrade again.

## 5. Change log requirement

Every upgrade or rollback entry must include: date, component and version/digest changed (including Traefik), backup identifier, branding drift report, validation result, exceptions opened or closed, and confirmation that changes were confined to `csphere.cloud` with out-of-scope tunnels/DNS records untouched and no Caddy component introduced.
