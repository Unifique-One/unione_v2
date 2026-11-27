# UNIFIQUE ONE — Cloudflare Tunnel procedure (csphere.cloud only)

> **WARNING — SCOPE LIMIT**
> This procedure is **only** for the `csphere.cloud` zone and the single tunnel
> dedicated to UNIFIQUE ONE. Never create, edit, delete or route DNS for any
> other domain, zone or tunnel. Do not use the Cloudflare API token stored in
> the project notes for anything outside `csphere.cloud`. If a hostname below
> is not in the list, stop and ask before proceeding.

The quadlet `../cloudflared.container` runs the pinned image
`cloudflare/cloudflared:2025.11.1` as container `unione-cloudflared` on the
`unione` network. It reads `TUNNEL_TOKEN` from
`/etc/unione/cloudflared/tunnel.env` (mode `0600`) and mounts
`/root/.cloudflared` read-only at `/etc/cloudflared`. The tunnel ingress
origin is **`http://traefik:80`** (the alias of `unione-traefik`), never a
published host port.

## 1. Prerequisites on the host

- `/root/.cloudflared/cert.pem` (account certificate) and the tunnel
  credentials JSON already exist.
- `/root/.cloudflared/config.yml` contains `tunnel: <UUID>`, the matching
  `credentials-file`, and the ingress rules below.
- `/etc/unione/cloudflared/tunnel.env` contains **only**
  `TUNNEL_TOKEN=<token>` with mode `0600`. Do not commit or print it.
- `/opt/unione/secrets/cloudflare.tunnel.id` contains **only** that UUID;
  its value must match `tunnel:` in `config.yml`.

No files in `/root/.cloudflared`, `/opt/unione/secrets` or Cloudflare DNS are
created or changed by the stack files themselves.

## 2. Ingress configuration

Only these 20 hostnames belong to this tunnel. Every one points at Traefik;
routing inside the stack is handled by `../services.yml`.

```yaml
tunnel: <UUID from /opt/unione/secrets/cloudflare.tunnel.id>
credentials-file: /etc/cloudflared/<UUID>.json

ingress:
  - hostname: cloud.csphere.cloud
    service: http://traefik:80
  - hostname: drive.csphere.cloud
    service: http://traefik:80
  - hostname: files.csphere.cloud
    service: http://traefik:80
  - hostname: office.csphere.cloud
    service: http://traefik:80
  - hostname: meet.csphere.cloud
    service: http://traefik:80
  - hostname: calendar.csphere.cloud
    service: http://traefik:80
  - hostname: contacts.csphere.cloud
    service: http://traefik:80
  - hostname: forms.csphere.cloud
    service: http://traefik:80
  - hostname: board.csphere.cloud
    service: http://traefik:80
  - hostname: whiteboard.csphere.cloud
    service: http://traefik:80
  - hostname: notes.csphere.cloud
    service: http://traefik:80
  - hostname: tasks.csphere.cloud
    service: http://traefik:80
  - hostname: projects.csphere.cloud
    service: http://traefik:80
  - hostname: ai.csphere.cloud
    service: http://traefik:80
  - hostname: id.csphere.cloud
    service: http://traefik:80
  - hostname: auth.csphere.cloud
    service: http://traefik:80
  - hostname: mail.csphere.cloud
    service: http://traefik:80
  - hostname: status.csphere.cloud
    service: http://traefik:80
  - hostname: admin.csphere.cloud
    service: http://traefik:80
  - hostname: api.csphere.cloud
    service: http://traefik:80
  - service: http_status:404   # required catch-all
```

The last rule with no `hostname` is mandatory. Keep it as `http_status:404` so
unknown hosts are rejected rather than sent to an unintended origin.

## 3. DNS (manual, one-time, csphere.cloud only)

For each hostname in the list, if its CNAME does not already exist, create it
with the tunnel-specific command. Run these from a shell with `cloudflared`
installed; this documentation does not execute them.

```bash
for host in cloud drive files office meet calendar contacts forms board \
            whiteboard notes tasks projects ai id auth mail status admin api; do
  cloudflared tunnel route dns unione "${host}.csphere.cloud"
done
```

Before running anything, verify the target zone is `csphere.cloud` and that
the tunnel name/ID is the UNIFIQUE ONE tunnel. Do **not** run bulk route
commands against any other zone, and do not delete existing tunnels.

## 4. Start and verify

```bash
sudo cp /opt/unione/stack/cloudflared.container /etc/containers/systemd/
sudo systemctl daemon-reload
sudo systemctl enable --now cloudflared.service
systemctl status cloudflared.service
podman logs unione-cloudflared
```

From a public client, check `https://cloud.csphere.cloud/` and
`https://status.csphere.cloud/`. If a hostname fails, inspect the Traefik
router in `../services.yml` before touching Cloudflare configuration.

## 5. Rollback

```bash
sudo systemctl disable --now cloudflared.service
```

This stops only the UNIFIQUE ONE connector. Never remove DNS records or
tunnels belonging to other domains as part of a rollback.
