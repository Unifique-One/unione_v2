# UNIFIQUE ONE — Phased implementation plan

## 1. Governing rules

These rules come directly from `pt/domain.md` and the pre-deploy baseline in `inventory.md`:

- Nextcloud remains internal technology; the user-facing product name is **UNIFIQUE ONE** in every interface.
- `/opt/unione/pt/unione.md` and the official Unifique palette published at `https://brandfetch.com/tca.com.br` are the only sources of visual identity: no invented colours, logos or favicons. Brandfetch adds Denim `#1067CE` to the already documented royal `#212492` and Energy Yellow `#F5EC5A`.
- No container image edits, no manual changes inside running containers, no destructive core modifications.
- Persist all customization through Podman volumes or officially supported extension points.
- Use rootful Podman 5.8.2 with crun; resource budget is 4 vCPU, ~6.4 GiB available RAM and 52 GiB free on `/`.
- Apply changes incrementally, one application at a time, with a backup before every destructive step.
- Every apply operation is idempotent and re-runnable; no blind string replacement of "Nextcloud".
- Legal notices, licence credits, version and security information must remain in technical/admin surfaces.
- The reverse proxy is **Traefik**, not Caddy. No Caddy configuration, container or route is part of this stack; do not create one.
- Container names follow `pt/container.md`: `unione-traefik` (reverse proxy) and `unione-cloudflared` (tunnel), alongside the six existing `unione-*` services. The `traefik` network alias remains because tunnel ingress targets `http://traefik:80`; the `cloudflared` alias may remain. Ollama is excluded.
- **Strict scope rule: only `csphere.cloud` may be altered.** All DNS records, Traefik routers, cloudflared public hostnames and proxy configuration changes are confined to hostnames in the `csphere.cloud` zone. No other domain or zone is touched. Within `csphere.cloud`, the explicitly preserved records and the 17 unrelated tunnels remain untouched unless separately authorized (E-04, E-05).
- No Podman, cloudflared, curl or API command was executed to produce this plan; commands below are **reference steps for implementation time**, not actions already taken.

## 2. Phase sequence

| Phase | Name | Deliverable | Gate before proceeding |
| --- | --- | --- | --- |
| 0 | Scope lock & secrets | Written scope: 20 hostnames in `inventory.md`; exclusions in `exceptions.md`; token rotation ticket created | Token rotation owner assigned; out-of-scope resources explicitly frozen |
| 1 | Discovery / baseline | `inventory.md` accepted | Confirmed 0 containers/images/volumes/pods and only default `podman` network |
| 2 | Design system | Central tokens and derived assets under `/opt/unione/branding/` | Every value traced to `pt/unione.md`; no invented assets; official favicon/icon set recorded (E-01 resolved 2026-11-27) |
| 3 | Nextcloud core | Branded login, header, navigation, dashboard, share screens, public pages | OCC theming verified in browser; no core files modified |
| 4 | Nextcloud apps | Files, Photos, Calendar, Contacts, Talk, Deck, Notes, Tasks, Forms, Whiteboard, Office individually checked | Each app has its own verification record |
| 5 | Complementary services & proxy | Nextcloud Assistant UI for `ai`, Mail, Status, Admin, API surfaces and **Traefik** reverse-proxy routes configured where possible | Unsupported surfaces listed in `exceptions.md`; no local Ollama backend and no Caddy component is deployed |
| 6 | Visual & hostname integration | Alias pairs and `projects` Deck view consistent; cloudflared public hostnames mapped to **Traefik** routers, then to services | All 20 hostnames resolve through tunnel → Traefik → service; only `csphere.cloud` records changed; preserved records and unrelated tunnels unchanged |
| 7 | Tests & documentation | `validation.md` executed, `compatibility.md` and `exceptions.md` current | Full acceptance gate passes; backup restore drill succeeds |

## 3. Design system to create in Phase 2

Source: `pt/unione.md`. Central files are the single source of truth; applications consume them via mounted volumes.

- **Colours:** royal/Jacksons Purple `#212492`, dark `#161869`, light `#3539B8`, Denim `#1067CE`, Energy Yellow `#F5EC5A`, bright yellow `#FFD500`, cyan `#00AEEF`, magenta `#E6007E`, green `#45B649`, purple `#743BBD`; neutrals `#FFFFFF`, `#111111`, `#F6F8FC`, `#EEF2F9`, `#DCE3F0`, `#C2CCE0`, `#5E6882`, `#2A324B`, `#0F1429`. Denim is used only where contrast passes: light-theme links/buttons on white (5.45:1) and accent gradients; dark-theme links remain cyan (7.20:1 on `#0F1429`) because Denim falls to 3.34:1 there.
- **Semantic tokens:** background `#FFFFFF`, surface `#F6F8FC`, text `#0F1429`, muted text `#5E6882`, border `#DCE3F0`.
- **Nextcloud variable bridge:** map `--color-primary`, `--color-primary-element`, `--color-primary-element-hover`, `--color-primary-element-text`, `--color-main-background`, `--color-background-hover`, `--color-main-text`, `--color-text-maxcontrast`, `--color-border` to the official tokens.
- **Typography:** Plus Jakarta Sans for display, Inter for body, with declared fallbacks; licence and local hosting of font files must be confirmed before use.
- **Shape:** radii 6/10/16/22/9999 px and the documented soft shadows.
- **Logo/favicon:** the brand owner supplied two official 1024x1024 JPEGs with solid square backgrounds. The theme serves background-free PNG cuts instead (`unione-symbol-dark.png` on light surfaces, `unione-symbol-light.png` on the always-blue header and dark surfaces), so no square plate is rendered. The original JPEGs are kept only as documentation of the source. The wordmark SVGs derived from `pt/unione.md` remain the text/wordmark fallback; the canonical favicon/icon files are the official PNG/ICO assets downloaded from `https://unifique.com.br/` into `/opt/unione/branding/assets/favicons/` (E-01 resolved 2026-11-27). No icon is invented.

## 4. Per-service branding method

| Service / hostname(s) | Official mechanism first | Persisted location | Idempotency key | What must be individually verified |
| --- | --- | --- | --- | --- |
| Nextcloud core — `cloud` | `occ theming:update` for product name, slogan, primary colour, logo, background and legal notice keys; custom theme only for unsupported settings | `unione-nextcloud-config`, `unione-nextcloud-themes` | Stored theming values + checksum of logo/background assets | Login, dashboard, header, app menu, share dialog, user settings, public share link |
| Files — `drive`, `files` | Core theming plus app CSS overlay from central tokens | Theme volume | Token file checksum + app CSS checksum | List/grid toggle, breadcrumbs, details drawer, star/trash actions, empty state |
| Photos | App CSS overlay | Theme volume | App CSS checksum | Gallery tiles, album view, viewer chrome |
| Calendar | App CSS overlay | Theme volume | App CSS checksum | Month/week grid, event popover, settings |
| Contacts | App CSS overlay | Theme volume | App CSS checksum | Contact cards, groups, import dialog |
| Talk — `meet` | Core theming + Talk's supported appearance settings | Config + theme volumes | Talk config values + CSS checksum | Chat list, conversation, in-call controls, join screen, notifications |
| Deck / Whiteboard — `board`, `whiteboard`, `projects` (Deck view) | Core theming + Deck/Whiteboard CSS overlay | Theme volume | CSS checksum | Boards, cards, labels, projects view, canvas UI |
| Notes | App CSS overlay | Theme volume | CSS checksum | Note list, editor toolbar, empty state |
| Tasks | App CSS overlay | Theme volume | CSS checksum | Lists, task detail, completed-state styling |
| Forms | App CSS overlay | Theme volume | CSS checksum | Builder **and** anonymous/public form page |
| Office — `office` | Office app configuration / official white-label options only if licensed | Office config volume | App config values | Editor toolbar, save/status bar, document list |
| Nextcloud Assistant — `ai` | Nextcloud Assistant official theming/UI; app CSS overlay from central tokens | Assistant config + theme volume | Theming values + CSS checksum | Assistant UI only; **no local Ollama backend**; AI model/deployment deferred by user decision (E-03, E-07) |
| Mail — `mail` | Official webmail theme config once credentials exist | Mail config volume | Config values | Login, inbox, compose; blocked pending credentials (E-02) |
| Status — `status` | Status service config + token overlay | Status config volume | Config values + CSS checksum | Service list, incident banner, footer |
| Admin — `admin` | Core theming with admin exemptions | Config + theme volumes | Stored theming values | Branding present; version/audit/licence/security text still visible |
| API — `api` | No UI work | DNS/tunnel config only | Recorded DNS state | Confirm existing record untouched unless explicitly authorized |
| Tunnel routing | `cloudflared` public-hostname config and DNS records, forwarding to **Traefik** | `/root/.cloudflared/config.yml` (certificate already at `/root/.cloudflared/cert.pem`) | Hostname-to-service map checksum | All 20 hostname routes; alias parity; no changes to unrelated tunnels |
| Traefik reverse proxy | Traefik static/dynamic configuration with host rules restricted to `csphere.cloud`; no Caddy | `unione-traefik-config` volume; routers/services/entrypoints config | Router rule checksum + hostname allowlist | All 20 hostnames reach the correct service; alias pairs share one router target; no router exists for any other domain |

Reference OCC form at implementation time (verify flags against the installed version with `occ theming:update --help`):

```text
occ theming:update --name="UNIFIQUE ONE" --slogan="" \
  --color="#212492" --logo=<official asset> --background=<official asset>
occ config:app:get theming name        # read-back check, no secret output
occ app:list                            # app inventory after each phase
```

Do not paste API tokens or certificate material into OCC commands, config files kept in the project tree, or this documentation.

## 5. Podman persistence pattern

- Create named volumes before first deployment; baseline is 0 volumes, so nothing is being migrated.
- Mount official assets **read-only** into the container paths that Nextcloud/apps actually read; keep mutable settings in config volumes.
- Use rootful Podman with crun; on Rocky Linux 9.4 account for SELinux relabelling on bind mounts (appropriate `:Z`/`:z` options) when a bind mount is unavoidable.
- Keep images pinned by explicit tag/digest; upgrades replace the image, never the volume contents.
- Suggested volume roles: `unione-nextcloud-config`, `unione-nextcloud-data`, `unione-nextcloud-themes`, `unione-traefik-config` (Traefik static/dynamic config and router rules), plus one config volume per complementary service. Final names are recorded in the deployment manifest when created.
- The request path is cloudflared tunnel → **Traefik** → service container. Traefik routers must match only `csphere.cloud` hostnames; there is no Caddy proxy in the design.

## 6. Backups

- Take a backup **before** the first branding apply and before each subsequent destructive change or upgrade.
- Include: all affected named volumes, Nextcloud `config.php` and app configuration, theme/assets directories, tunnel `config.yml`, **Traefik static/dynamic config and router rules**, and any database volume used by the stack.
- Store backup artifacts **outside** the volumes being modified, with a dated name and a checksum manifest; size them against the 52 GiB free on `/`.
- Never place a backup inside the volume it is intended to restore.
- Perform at least one restore drill into a scratch volume before sign-off; record result and retention period in `validation.md`.

## 7. Idempotency

Apply scripts under `/opt/unione/scripts/branding/` must:

1. Read desired state from central tokens/assets only.
2. Read current state with official read commands (OCC/config getters, file checksums).
3. Apply only on detected drift; never append duplicate configuration lines or duplicate DNS/tunnel hostnames.
4. Be safe to run twice in a row with identical resulting state and no extra files.
5. Log changed items, fail loudly on unexpected state, and never rotate or write credentials.
6. Produce a verification report consumable by `validation.md`.

## 8. DNS and tunnel integration

- cloudflared 2026.11.2 and `/root/.cloudflared/cert.pem` already exist; no new certificate login is part of this documentation pass.
- Define public hostnames for all 20 mapped names; alias pairs point to the **same** origin service (`drive`/`files`, `board`/`whiteboard`, `id`/`auth`) and `projects` points to the Deck view.
- cloudflared forwards those hostnames to **Traefik**, whose routers select the backend service. Every DNS record, cloudflared hostname and Traefik router created or changed must be for a `csphere.cloud` hostname; **no other domain may be altered**.
- `api.csphere.cloud`, `console.csphere.cloud`, `csphere-api.csphere.cloud` and `csphere.csphere.cloud` are pre-existing records whose tunnel UUIDs are absent from the account. Preserve them; changing them requires an explicit owner decision.
- The 17 unrelated tunnels are strictly out of scope: do not list for deletion, modify or remove them, notwithstanding the broad delete statement in `pt/domain.md`.
- Rotate the exposed API token out-of-band, store it in a secret manager, restrict permissions on `pt/domain.md`, and verify consumers after rotation. The token value must never appear in documentation or scripts.

## 9. Acceptance gate

Work is complete only when `validation.md` passes for every hostname, every application, login/SSO flow, mobile web, legal notices, DNS/tunnel/Traefik routing and backup restore — with changes confined to `csphere.cloud` — and every remaining limitation is recorded in `exceptions.md`.

## 10. Final Nextcloud theme and cleanup extension (2026-11-27)

Two read-only extension directories are mounted into `unione-nextcloud`; no core file is patched:

- `/opt/unione/branding/nextcloud-theme/unifique` → `/var/www/html/themes/unifique` — legacy theme with `defaults.php` plus `core/css/server.css` and `core/css/guest.css`. It implements light and dark themes via both OS preference and Nextcloud's `data-theme-dark` / `data-themes*=dark` body flags. Login uses the official LP-style deep-navy gradient (`#0F1429 → #161869 → #212492`) with yellow/cyan/Denim accents and a **solid** card (white + dark text in light mode, navy + white text in dark mode). The old translucent `.guest-box` grey card is explicitly overridden.
- `/opt/unione/branding/nextcloud-apps/unifique_branding` → `/var/www/html/apps/unifique_branding` — minimal AGPL app that injects one script on `BeforeTemplateRenderedEvent` and `BeforeLoginTemplateRenderedEvent`. It rewrites document titles, visible text and disallowed external links to `UNIFIQUE ONE` / `https://unifique.com.br`, removes the login-card prefix `Faça login em`, keeps the official contact redirects, reduces the guest footer to its icons only, and leaves security warnings and `csphere.cloud` links intact.

`apply-nextcloud-branding.sh` enables the app, sets `theme=unifique`, clears `enforce_theme`, sets an empty theming slogan, registers `unione@csphere.cloud` as the calendar organizer address, disables the four marketing/support apps (`firstrunwizard`, `nextcloud_announcements`, `support`, `survey_client`), and bumps `theming.cachebuster` so mounted CSS/JS is refetched. `stack/scripts/deploy.sh` and `stack/apps/nextcloud.container` mount both extension directories. `verify-nextcloud.sh` checks the theme files, app enablement, official URLs, calendar identity and marketing-app state.

The profile/account popup is treated as a surface, not as header chrome: the blue header keeps white text, while the popup inverts to dark text on `#FFFFFF` in light mode (`#0F1429` on white = 18.22:1, Denim `#1067CE` links = 5.45:1) and white text on `#2A324B` in dark mode (`#FFFFFF` on `#2A324B` = 12.68:1, cyan `#00AEEF` links = 5.01:1). Header white text over the navy/royal/Denim gradient is 15.34:1, 12.12:1 and 5.45:1 respectively. All pass WCAG AA.

The login card headline is forced to the canonical `UNIFIQUE ONE` (the Vue prefix `Faça login em` is removed) and centered by `guest.css`. The theming slogan and theme fallback are empty. No logo is rendered above the login card: the legacy `<div id="header" class="header-guest"><div class="logo"></div></div>` is hidden by `guest.css`. In the authenticated UI the theming app stores the transparent dark symbol as `logo` and the transparent light symbol as `logoheader`; the theme serves both locally and sets `--image-logo` to the dark symbol on light surfaces and the light symbol on dark surfaces, while the always-blue branded header uses the light symbol. Neither artwork has a square background. The guest footer has no card and no description or license text; it renders only the three official contact icons — WhatsApp, Telegram and E-mail — as byte-identical copies of the SVGs published by `unifique.com.br`, pointing to that site's exact redirects (`api.whatsapp.com/send?...`, `t.me/UnifiqueOficialBot`, `email2.unifique.com.br`). The icons are served from `/themes/unifique/core/img/` so the login CSP (`img-src 'self'`) allows them, and they get a white chip in dark mode for legibility. They render as 24 px icons in 36 px chips with 12 px spacing; the login block is centred in the viewport with extra space below its top accent line. Calendar free/busy requires the organizer address to match the account's registered email; the apply script therefore persists `unione@csphere.cloud` as that user's email. A direct POST to the scheduling outbox now returns HTTP 200 with `2.0;Success`, so new-event creation no longer shows `Falha ao buscar dados de livre/ocupado`.
