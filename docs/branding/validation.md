# UNIFIQUE ONE — Validation checklist

## 1. Scope and preconditions

- [ ] All changes are confined to **`csphere.cloud`**; no other domain, zone, DNS record or tunnel was altered.
- [ ] The reverse proxy in use is **Traefik**; there is **no Caddy** container, config, route or reference in the deployment.
- [ ] `ai.csphere.cloud` serves the **Nextcloud Assistant UI only**; **no Ollama backend**, local model server or downloaded model exists.
- [ ] No Podman, cloudflared, curl or Cloudflare API command was executed to produce this document; checks below are to be executed at validation time.
- [ ] The Cloudflare token value does not appear in any documentation, script or config artifact in the project tree (E-06).
- [ ] Backup with checksum manifest exists and was taken before the changes being validated.
- [ ] Exceptions in `exceptions.md` are current, including E-01 **RESOLVED (2026-11-27)** with official favicon provenance, preserved records (E-04), unrelated tunnels (E-05), token rotation (E-06) and Ollama exclusion (E-07).
- [ ] Containers use the official names from `pt/container.md`: `unione-traefik` and `unione-cloudflared` (alongside `unione-postgres`, `unione-redis`, `unione-nextcloud`, `unione-collabora`, `unione-coturn`, `unione-status`). The `traefik` network alias is retained for Tunnel ingress at `http://traefik:80`; the `cloudflared` alias may remain. Ollama is excluded.

## 1.1 Recorded verification results (documentation pass)

- **PASSED — Nextcloud branding:** theming name `UNIFIQUE ONE`, slogan, logo, official PNG favicon/icon (`favicon-32x32-01e518e661.png` for `theming.favicon` and `apple-touch-icon-c435f4f4da.png` for `theming.icon`), primary colour and font verified through the official theming mechanisms; all enabled apps checked individually with the same tokens. Technical notices, licences and version information were preserved.
- **PASSED — Status page:** `status.csphere.cloud` uses the official design tokens from `pt/unione.md` and the official PNG favicon; no invented colours or visual assets.
- Naming reference: reverse proxy is **Traefik** (not Caddy), container `unione-traefik`; Tunnel container is `unione-cloudflared`. Only `csphere.cloud` may be altered.

## 2. Hostname checks

For every row: HTTPS certificate valid; page loads; title/product name is `UNIFIQUE ONE`; official logo and official PNG favicon (`favicon-32x32-01e518e661.png`) render; primary colour `#212492` and yellow `#F5EC5A` accents are present; no unintended Nextcloud product identity in user-facing areas; route passes cloudflared → **Traefik** → service; hostname is in `csphere.cloud`.

| Hostname | Expected surface | Specific checks | Result |
| --- | --- | --- | --- |
| `cloud.csphere.cloud` | Main portal / login | Branded login and landing page; correct redirect after login | ☐ |
| `drive.csphere.cloud` | Nextcloud Files (canonical) | List/grid, breadcrumbs, details drawer, share dialog | ☐ |
| `files.csphere.cloud` | Files (**alias of `drive`**) | Identical content and branding to `drive`; same Traefik backend | ☐ |
| `office.csphere.cloud` | Office editor | Editor chrome/toolbar and document list branded | ☐ |
| `meet.csphere.cloud` | Talk | Chat list, conversation, in-call controls, join screen | ☐ |
| `calendar.csphere.cloud` | Calendar | Month/week views and event dialog | ☐ |
| `contacts.csphere.cloud` | Contacts | Contact cards, groups, import UI | ☐ |
| `forms.csphere.cloud` | Forms | Builder **and** public/anonymous form page | ☐ |
| `board.csphere.cloud` | Deck / boards (canonical) | Boards, cards, labels, collaboration view | ☐ |
| `whiteboard.csphere.cloud` | Whiteboard (**alias of `board`**) | Same tokens/logo as `board`; same backend | ☐ |
| `notes.csphere.cloud` | Notes | Note list, editor toolbar, empty state | ☐ |
| `tasks.csphere.cloud` | Tasks | Task lists, detail view, completion state | ☐ |
| `projects.csphere.cloud` | **Deck view** (mapped) | Lands on Deck projects/boards view with board branding | ☐ |
| `ai.csphere.cloud` | **Nextcloud Assistant UI only** | Assistant interface branded; **no Ollama/backend/model UI or endpoint**; model/deployment deferred (E-03, E-07) | ☐ |
| `id.csphere.cloud` | Identity / SSO (canonical) | Branded login/SSO page | ☐ |
| `auth.csphere.cloud` | Identity / SSO (**alias of `id`**) | Byte-for-byte equivalent branded login experience | ☐ |
| `mail.csphere.cloud` | Webmail | Branded if configured; otherwise recorded as blocked on credentials (E-02) | ☐ |
| `status.csphere.cloud` | Status page | Official tokens; status/incident detail retained | ☐ |
| `admin.csphere.cloud` | Restricted admin | Branding applied; technical/version/audit/licence text still visible | ☐ |
| `api.csphere.cloud` | API endpoint | No visual branding expected; pre-existing record state preserved unless separately authorized | ☐ |

Alias parity checks: `drive` = `files`, `board` = `whiteboard`, `id` = `auth`; any divergence is a failure.

## 3. Login and SSO flow

- [ ] Login at `cloud`, `id` and `auth` shows official wordmark, official PNG favicon, royal/yellow palette and product name `UNIFIQUE ONE`.
- [ ] Successful login redirects to the correct workspace; session persists across alias hostnames as designed.
- [ ] Logout returns to the branded login page.
- [ ] Password reset, error messages, empty states and notifications use official tokens.
- [ ] Second-factor / SSO challenge screens (if enabled) are branded and functional.
- [ ] Public share links render branded headers without exposing internal identity.
- [ ] No technical/login text required for security or licensing was removed.

## 4. Application-by-application checks

| Application | Checks | Result |
| --- | --- | --- |
| Files | Upload, star, trash/restore, share drawer, list/grid toggle, empty state | ☐ |
| Photos | Gallery, albums, viewer chrome | ☐ |
| Calendar | Create event, month/week navigation, dialogs | ☐ |
| Contacts | Create/import contact, card styling | ☐ |
| Talk / Meet | Send message, start/join call, notification styling | ☐ |
| Deck / Board / Projects | Create board/card, labels, Deck view, Whiteboard canvas via alias | ☐ |
| Notes | Create note, editor toolbar, empty state | ☐ |
| Tasks | Create task, due-date badge, completion state | ☐ |
| Forms | Build form, submit/view public form, confirmation screen | ☐ |
| Office | Open/create document, editor chrome, save/status indicators | ☐ |
| Nextcloud Assistant (`ai`) | Assistant UI branding only; confirm no Ollama backend or local model component | ☐ |
| Mail | Login/inbox/compose once credentials are supplied (E-02) | ☐ |
| Status | Service list, incident banner, footer | ☐ |
| Admin | Branding plus retained version, audit, licence and security information | ☐ |

## 5. Mobile web and responsive behaviour

- [ ] Check widths ≈375 px, ≈768 px and ≈1024 px on portal, Files, login and one app per family.
- [ ] Sidebar collapses/restores; header remains readable; touch targets remain usable.
- [ ] Favicon/home-screen icon and PWA manifest icons render from the official PNG/ICO set (`favicon-32x32-01e518e661.png`, `apple-touch-icon-c435f4f4da.png`, `favicon-cd754f5597.ico`); the wordmark-derived `favicon.svg` is a legacy fallback only.
- [ ] Light and dark surface treatments remain legible with official text/background tokens.
- [ ] No horizontal overflow or clipped buttons in dialogs and forms.

## 6. Legal notices and technical text

- [ ] Licence credits, attribution, version strings, security warnings and audit information are present where required.
- [ ] No blanket replacement of the word "Nextcloud" in technical/admin areas.
- [ ] Footer/legal pages follow official typography and colours without hiding required text.
- [ ] Font and icon assets used are approved/pinned; no unapproved external dependency introduced.

## 7. DNS, tunnel and Traefik routing

- [ ] All 20 hostnames resolve and are served over HTTPS through cloudflared.
- [ ] cloudflared public-hostname rules match the map in `inventory.md`; `/root/.cloudflared/cert.pem` exists.
- [ ] **Traefik** is the active reverse proxy: routers exist for all 20 hostnames and forward to the correct backend services.
- [ ] **No Caddy** process, container, config or route exists.
- [ ] The Traefik container is named `unione-traefik` and the tunnel container `unione-cloudflared`; the `traefik` network alias still resolves for ingress at `http://traefik:80`.
- [ ] Every DNS/tunnel/Traefik change is for a `csphere.cloud` hostname only; **no other domain was altered**.
- [ ] Alias pairs share the same Traefik backend and identical content.
- [ ] `console.csphere.cloud`, `csphere-api.csphere.cloud`, `csphere.csphere.cloud` and the pre-existing `api` record state are unchanged.
- [ ] The 17 unrelated tunnels are unchanged and remain out of scope.

## 8. Backups and restore

- [ ] Pre-change backup exists with dated name and checksum manifest, covering Nextcloud config/data/theme volumes, Traefik config, tunnel config and any DB volume.
- [ ] Restore drill into a scratch volume succeeded; checksums verified before restore.
- [ ] Post-change backup created before the next maintenance window.
- [ ] Backup artifacts are stored outside the volumes they protect and fit within 52 GiB free on `/`.

## 9. Sign-off

| Area | Verified by | Date | Status |
| --- | --- | --- | --- |
| Hostnames (20) | | | ☐ |
| Login / SSO | | | ☐ |
| Applications | | | ☐ |
| Mobile web | | | ☐ |
| Legal notices | | | ☐ |
| DNS / tunnel / Traefik | | | ☐ |
| Backups / restore | | | ☐ |
| Exceptions reviewed | | | ☐ |

Sign-off is valid only if every box above is checked, every remaining limitation is recorded in `exceptions.md`, the proxy is Traefik with no Caddy, `ai.csphere.cloud` is Nextcloud Assistant only with no Ollama, and all changes were confined to `csphere.cloud`.
