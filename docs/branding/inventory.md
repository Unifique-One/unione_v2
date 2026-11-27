# UNIFIQUE ONE — Pre-deployment inventory

## 1. Scope of this document

- Sources read in full: `/opt/unione/pt/domain.md` and `/opt/unione/pt/unione.md`.
- This is a **pre-deploy baseline**: no containers, images, volumes, pods, tunnels, DNS records or application files were changed while producing this package.
- No Podman, cloudflared, curl or Cloudflare API commands were executed for this documentation pass.
- Only files under `/opt/unione/docs/branding/` were written.
- The Cloudflare API token present in `pt/domain.md` is **active but exposed in plaintext**. Its value is deliberately **not reproduced** in any file of this package. See `exceptions.md` (E-06).
- The reverse proxy is **Traefik**, not Caddy. No Caddy container, config or route exists at baseline and none may be introduced.
- **Strict scope rule: only `csphere.cloud` may be altered.** Every DNS, tunnel and Traefik router change is confined to that zone; no other domain or zone is touched. Within the zone, explicitly preserved records and the 17 unrelated tunnels stay untouched (E-04, E-05).

## 2. Exact baseline findings supplied for this engagement

| Item | Finding |
| --- | --- |
| Initial project tree | `/opt/unione` initially contained **only** `pt/domain.md`, `pt/unione.md` and an empty `docs/` directory |
| Operating system | Rocky Linux 9.4 |
| Compute | 4 vCPU |
| Memory | 7.4 GiB RAM total, approximately 6.4 GiB available |
| Storage | 52 GiB free on `/` |
| Container runtime | Podman **5.8.2**, **rootful**, using **crun** |
| Containers | **0** |
| Images | **0** |
| Volumes | **0** |
| Pods | **0** |
| Networks | Only the default **`podman`** network exists |
| Tunnel client | **cloudflared 2026.11.2** installed |
| Tunnel credentials | `/root/.cloudflared/cert.pem` exists |
| Reverse proxy decision | **Traefik** (not Caddy); not deployed at baseline because there are **0 containers** |
| Cloudflare zone | **csphere.cloud** is active |
| Cloudflare token | Token in `pt/domain.md` is **active** but stored in **plaintext**; value omitted here |
| Pre-existing DNS | `api`, `console`, `csphere-api`, `csphere` records exist and point to tunnel UUIDs **not present in the account** |
| Other tunnels | **17 unrelated tunnels** exist and are **strictly out of scope** |

Consequence: there is no live deployment to rebrand yet. Every customization location below is a **target state** to be created by the implementation, not an existing file. The planned request path is `cloudflared` tunnel → **Traefik** reverse proxy → service container; all public hostnames are in `csphere.cloud`.

## 3. Subdomain map

Canonical names are the ones explicitly named in `pt/domain.md`. Alias names resolve to the **same** application and the **same** branding configuration; they are not separate products and must not receive a different visual identity.

| Hostname | Intended service / web surface | Canonical / alias | Target application | Branding notes |
| --- | --- | --- | --- | --- |
| `cloud.csphere.cloud` | Main portal, login and workspace entry | **Canonical** (portal) | Nextcloud core | Primary product surface; name shown to users is `UNIFIQUE ONE` |
| `drive.csphere.cloud` | Files and storage | **Canonical** (Files) | Nextcloud Files | Official name in `pt/domain.md` |
| `files.csphere.cloud` | Files and storage | **Alias of `drive`** | Nextcloud Files | Same Files app, same theme, same logo/favicon; no separate identity |
| `office.csphere.cloud` | Documents and spreadsheets | **Canonical** | Nextcloud Office | Verify editor/chrome separately from core Files UI |
| `meet.csphere.cloud` | Videoconference and chat | **Canonical** | Nextcloud Talk | Check call screen, chat pane and join page |
| `calendar.csphere.cloud` | Calendar | **Canonical** | Nextcloud Calendar | Check month/week views and event dialogs |
| `contacts.csphere.cloud` | Contacts | **Canonical** | Nextcloud Contacts | Check contact cards and import UI |
| `forms.csphere.cloud` | Forms | **Canonical** | Nextcloud Forms | Check builder **and** public form page |
| `board.csphere.cloud` | Boards and collaboration | **Canonical** (boards) | Nextcloud Deck / Whiteboard | Official name in `pt/domain.md` |
| `whiteboard.csphere.cloud` | Whiteboard | **Alias of `board`** | Same collaboration surface | Same tokens and assets as `board`; not a standalone brand |
| `notes.csphere.cloud` | Notes | **Canonical** | Nextcloud Notes | Check list, editor and empty state |
| `tasks.csphere.cloud` | Tasks | **Canonical** | Nextcloud Tasks | Check lists, details and reminders UI |
| `projects.csphere.cloud` | Projects | **Mapped view** | **Deck view** (projects/boards view) | Uses the Deck/board branding; documented mapping, not a separate product |
| `ai.csphere.cloud` | Nextcloud Assistant interface | **Canonical** | Nextcloud Assistant UI only; **no local Ollama backend** | Maps to the Nextcloud Assistant interface only. No local model server or Ollama deployment is used. AI model/deployment is deferred by user decision (E-03, E-07) |
| `id.csphere.cloud` | Identity and SSO | **Canonical** (identity) | Login / SSO surface | Official name in `pt/domain.md` |
| `auth.csphere.cloud` | Identity and SSO | **Alias of `id`** | Same login / SSO surface | Must render the identical branded login page |
| `mail.csphere.cloud` | Mail | **Canonical** | Webmail | Cannot be configured/validated until credentials are supplied (E-02) |
| `status.csphere.cloud` | Service status | **Canonical** | Status page | Apply official tokens; keep technical status information |
| `admin.csphere.cloud` | Restricted administration | **Canonical** | Admin interfaces | Branding allowed, but version, audit, licensing and diagnostic information must remain |
| `api.csphere.cloud` | API endpoint | **Canonical** (API) | Backend/API | Pre-existing DNS record points to a tunnel UUID absent from the account; do not repoint without an explicit owner decision |

### Alias pairs — summary

- `drive` ⇄ `files`: one Files service.
- `board` ⇄ `whiteboard`: one collaboration/board service.
- `id` ⇄ `auth`: one identity/login service.
- `projects` → Deck view: a view mapping, not an alias pair.

### Pre-existing records outside the product catalog

`console.csphere.cloud`, `csphere-api.csphere.cloud` and `csphere.csphere.cloud` also exist as DNS records pointing to tunnel UUIDs not present in the account. They are **preserved untouched** by this branding work and are not part of the user-facing catalog. See `exceptions.md` (E-04).

## 4. Service and interface inventory

Because the container baseline is zero, "customization location" records the **planned** persisted location, not a discovered file.

| Tool / interface | Web surface | Current state | Customization location (planned) | Recommended rebranding method |
| --- | --- | --- | --- | --- |
| Nextcloud core | Login, dashboard, header, navigation, share dialogs, user settings, admin pages | Not deployed | `unione-nextcloud-config` volume + `unione-nextcloud-themes` volume; central tokens under `/opt/unione/branding/` | Official theming through `occ theming:update` (product name, slogan, primary colour, logo, background, legal notices). Use a custom theme directory mounted from a volume only for settings OCC cannot express. **No core edits.** |
| Files / Drive | File list, grid, details drawer, breadcrumbs, empty states | Not deployed | Core theme + app-specific CSS overlay in theme volume | Inherit core tokens; individually verify list/grid, file icons, share drawer, trash and toasts |
| Photos | Gallery, albums | Not deployed | App CSS overlay in theme volume | Core theming is not guaranteed to cover gallery templates; verify separately |
| Calendar | Month/week views, event dialog | Not deployed | App CSS overlay | Verify colours, buttons and dialogs; do not assume core theme propagation |
| Contacts | Contact list, cards, import | Not deployed | App CSS overlay | Verify pills, avatars and form controls |
| Talk / Meet | Chat, call UI, join screen | Not deployed | App CSS overlay + official Talk settings where available | Verify in-call chrome and notifications, not just the chat list |
| Deck / Board / Projects | Boards, cards, Deck projects view | Not deployed | App CSS overlay | One branding for `board`, `whiteboard` and the `projects` Deck view |
| Notes | Note list and editor | Not deployed | App CSS overlay | Verify editor toolbar and empty state |
| Tasks | Task lists and detail view | Not deployed | App CSS overlay | Verify due-date badges and completion states |
| Forms | Form builder and **public** form | Not deployed | App CSS overlay | Public/shared page must be checked independently of the authenticated builder |
| Whiteboard | Canvas UI | Not deployed | Same as Deck/board | Alias of `board` |
| Office | Document/spreadsheet editor chrome | Not deployed | Office app config volume + official white-label settings if licensed | Use official configuration; if no supported hook exists, record a limitation instead of patching the image |
| Nextcloud Assistant — `ai` | Nextcloud Assistant UI | Not deployed | Assistant app config + theme volume | Brand using official Assistant/Nextcloud theming and central tokens; **no local Ollama backend**; model/deployment deferred (E-03, E-07) |
| Mail | Webmail UI | Not deployed | Mail app config volume + official theme options | Blocked on IMAP/SMTP credentials (E-02); no credentials may be invented |
| Status | Status page | Not deployed | Status service config + theme overlay | Apply official tokens; retain incident/version detail |
| Admin | Restricted administration UI | Not deployed | Core theme + admin-specific overlay | Keep technical, audit, licence and diagnostic information visible |
| API | No user-facing UI | Not deployed | DNS/tunnel configuration only | No visual branding needed; preserve the existing record state until authorized |
| Cloudflared tunnel | No UI | Installed; `cert.pem` present | Planned `/root/.cloudflared/config.yml` (never store the token there in plaintext) | Public hostnames map to the canonical services above; no changes to unrelated tunnels |
| Traefik reverse proxy | No user-facing UI; HTTP routing only | Not deployed (0 containers at baseline) | Planned `unione-traefik-config` volume for static/dynamic config and router rules | Routes only `csphere.cloud` hostnames from cloudflared to the correct service; no Caddy component |

## 5. Official identity baseline (from `pt/unione.md`)

- Wordmark: inline SVG "unifique" with a yellow dot `#F5EC5A` and a cyan dot `#00AEEF` over the two "i" glyphs. The canonical favicon/icon set is **not** taken from this mockup: the official PNG/ICO files were downloaded from `https://unifique.com.br/` and copied to `/opt/unione/branding/assets/favicons/` (E-01 **RESOLVED 2026-11-27**; see `exceptions.md`). The wordmark-derived `favicon.svg` is a legacy fallback only.
- Primary royal: `#212492`; dark: `#161869`; light: `#3539B8`.
- Accents: yellow `#F5EC5A`, bright yellow `#FFD500`, cyan `#00AEEF`, magenta `#E6007E`, green `#45B649`, purple `#743BBD`.
- Neutrals: `#FFFFFF`, `#111111`, `#F6F8FC`, `#EEF2F9`, `#DCE3F0`, `#C2CCE0`, `#5E6882`, `#2A324B`, `#0F1429`.
- Typography: **Plus Jakarta Sans** (display) and **Inter** (body), with weights 400–800.
- Radii: 6 / 10 / 16 / 22 / 9999 px; soft shadows in royal/maroon tones.
- Nextcloud variables explicitly overridden in the source: `--color-primary`, `--color-primary-element`, `--color-primary-element-hover`, `--color-primary-element-text`, `--color-main-background`, `--color-background-hover`, `--color-main-text`, `--color-text-maxcontrast`, `--color-border`.
- The file is a visual mockup with example names and `unifique.com.br` placeholder URLs; those examples must not be copied literally into production text.

## 6. Planned central customization layout

```text
/opt/unione/
├── pt/unione.md                 # source of truth (read-only)
├── branding/
│   ├── assets/{logos,favicons,icons,images,fonts}/
│   ├── tokens/{colors,typography,spacing,design-tokens}.css
│   ├── themes/{global,login,navigation,components,responsive}.css
│   └── integrations/{nextcloud,services}/
├── docs/branding/               # this package
└── scripts/branding/            # idempotent apply/verify scripts
```

Runtime persistence will use Podman named volumes (for example `unione-nextcloud-config`, `unione-nextcloud-data`, `unione-nextcloud-themes`, `unione-traefik-config` for Traefik routers, plus per-service config volumes). None exist at baseline. Assets are mounted read-only from the central layer; mutable settings live in volumes so image replacement cannot erase them.

## 7. Method constraints carried into implementation

1. No edits inside running containers or directly to container images.
2. Prefer official theming/OCC/app configuration; document any unsupported case as an exception.
3. No blanket text replacement of the word "Nextcloud"; technical, licence, security and attribution text is preserved.
4. Every change is idempotent, reversible and preceded by a backup.
5. Each application is validated individually — a branded Nextcloud home page is not sufficient acceptance.
6. Out-of-scope resources (17 unrelated tunnels, `console`/`csphere-api`/`csphere` records) remain untouched despite the broad deletion permission written in `pt/domain.md`.
7. **Only `csphere.cloud` may be altered** — no other domain, zone, DNS record or tunnel. Traefik is the sole reverse proxy; Caddy is not used or referenced in the deployment.
