# UNIFIQUE ONE — Podman stack (Traefik + quadlets)

Canonical product name: **UNIFIQUE ONE**. Canonical domain: **csphere.cloud**.

This directory contains the Podman quadlet units, Traefik configuration and a
direct `podman run` fallback for the UNIFIQUE ONE stack. The Cloudflare Tunnel
connector unit is included, but no Cloudflare/DNS changes are performed here.

## Files

| Path | Purpose |
| --- | --- |
| `unione.network` | Quadlet network unit for the shared `unione` network. |
| `traefik.container` | Traefik quadlet; alias `traefik`, publishes `8080:80`. |
| `cloudflared.container` | Cloudflare Tunnel quadlet; alias `cloudflared`. |
| `traefik.yml` | Static Traefik config: `web` on `:80`, file provider, API/dashboard disabled. |
| `services.yml` | Dynamic routers/services/middlewares for all 20 `*.csphere.cloud` hosts. |
| `apps/*.container` | Optional quadlets for PostgreSQL, Redis, Nextcloud, Collabora, TURN and status. |
| `env/nextcloud.env` | DB/Redis/Nextcloud environment; 20 trusted domains; mode `0600`. |
| `env/coturn.env` | Generated TURN shared secret; mode `0600`. |
| `config/coturn.conf` | Rendered TURN configuration. |
| `scripts/deploy.sh` | Fallback that starts every local container with `podman run --replace`. |
| `cloudflared/README.md` | Tunnel/config/DNS procedure scoped to `csphere.cloud` only. |

## Prerequisites

- Podman with quadlet support (`/etc/containers/systemd` and
  `podman-system-generator`).
- `/opt/unione/secrets/admin.htpasswd` in standard htpasswd format
  (`username:$2y$...`), owned by UID 65532 and mode `0600`. Traefik's
  `basicAuth` reads it directly via `usersFile`. Generate a line with
  `podman run --rm --entrypoint htpasswd docker.io/library/httpd:2 -Bbn admin PASSWORD`.
- `/etc/unione/cloudflared/tunnel.env` containing `TUNNEL_TOKEN=<token>` with
  mode `0600`; this is what the tunnel unit reads. The UUID is kept in
  `/opt/unione/secrets/cloudflare.tunnel.id` and must match the `tunnel:` value
  in `/root/.cloudflared/config.yml` for API-managed configuration.
- `/root/.cloudflared` with the tunnel config and credentials, mounted
  read-only by `cloudflared.container`.
- `/opt/unione/branding/integrations/services/status` must contain the static
  status site.
- `/opt/unione/branding` is mounted read-only into Nextcloud at `/mnt/branding`.

Nothing outside `/opt/unione/stack` is created or modified by this repository.

## Deployment with quadlets (preferred)

```bash
sudo cp /opt/unione/stack/unione.network \
        /opt/unione/stack/traefik.container \
        /opt/unione/stack/cloudflared.container \
        /etc/containers/systemd/
sudo cp /opt/unione/stack/apps/*.container /etc/containers/systemd/
sudo systemctl daemon-reload

sudo systemctl enable --now unione-network.service
sudo systemctl enable --now postgres.service redis.service nextcloud.service
sudo systemctl enable --now collabora.service coturn.service status.service
sudo systemctl enable --now traefik.service
sudo systemctl enable --now cloudflared.service   # only after the tunnel prerequisites are met
```

Quadlet generates service names from the **unit filenames**, while the
container names are the stable `unione-*` names. Useful checks:

```bash
systemctl status traefik.service
podman ps --filter network=unione
curl -H 'Host: cloud.csphere.cloud' http://127.0.0.1:8080/
```

## Fallback: direct `podman run`

If quadlets are unavailable:

```bash
bash /opt/unione/stack/scripts/deploy.sh
```

The script creates the `unione` network and the `unione-nextcloud`,
`unione-postgres` and `unione-redis` volumes if missing, then uses
`podman run -d --replace --restart unless-stopped` with stable names. It does
**not** start the tunnel connector: use `cloudflared.container` for that, or
run `/opt/unione/scripts/deploy-all.sh`, which starts `unione-cloudflared`.

## Network names and DNS

Every container attaches to `unione`. Stable container names resolve on that
network; the following aliases are added:

| Container | Alias |
| --- | --- |
| `unione-postgres` | `postgres` |
| `unione-redis` | `redis` |
| `unione-nextcloud` | `nextcloud` |
| `unione-collabora` | `collabora` |
| `unione-coturn` | `turn` |
| `unione-status` | `status` |
| `unione-traefik` | **`traefik`** |
| `unione-cloudflared` | `cloudflared` |

**Cloudflare Tunnel ingress targets `http://traefik:80`** on the `unione`
network — that is why Traefik carries `--network-alias traefik` in the fallback
and `NetworkAlias=traefik` in the quadlet. Only Traefik publishes a host port
(`8080:80`) for local testing; keep it private.

## Host routing

| Hostname | Upstream / middleware |
| --- | --- |
| `cloud.csphere.cloud` | `unione-nextcloud:80` |
| `drive.csphere.cloud` | Nextcloud Files (`/apps/files`) |
| `files.csphere.cloud` | Nextcloud Files (`/apps/files`) |
| `office.csphere.cloud` | `unione-collabora:9980` |
| `meet.csphere.cloud` | Nextcloud Talk (`/apps/spreed`) |
| `calendar.csphere.cloud` | Nextcloud Calendar |
| `contacts.csphere.cloud` | Nextcloud Contacts |
| `forms.csphere.cloud` | Nextcloud Forms |
| `board.csphere.cloud` | Nextcloud Deck |
| `whiteboard.csphere.cloud` | Nextcloud Whiteboard |
| `notes.csphere.cloud` | Nextcloud Notes |
| `tasks.csphere.cloud` | Nextcloud Tasks |
| `projects.csphere.cloud` | Nextcloud Deck |
| `ai.csphere.cloud` | Nextcloud Assistant (`/apps/assistant`) |
| `id.csphere.cloud` | `unione-nextcloud:80` |
| `auth.csphere.cloud` | Nextcloud login (`/index.php`) |
| `mail.csphere.cloud` | Nextcloud Mail |
| `status.csphere.cloud` | `unione-status:80` |
| `admin.csphere.cloud` | Nextcloud + `basicAuth` middleware |
| `api.csphere.cloud` | Nextcloud `remote.php` / `ocs/v2.php` rewrites |

### AI status

AI is intentionally deferred. There is no separate AI runtime, model volume or
AI container in this stack. `ai.csphere.cloud` currently serves the
**Nextcloud Assistant** interface only.

## Security notes

- `env/nextcloud.env` and `env/coturn.env` are `0600`; `config/coturn.conf` is
  `0640`.
- TURN uses a shared secret generated once and persisted. Rotating it also
  requires updating the Nextcloud Talk TURN secret.
- The TURN and status containers publish no host ports.
- `admin.csphere.cloud` is protected by HTTP Basic authentication; TLS is
  terminated at Cloudflare, and a middleware forces `X-Forwarded-Proto: https`.
