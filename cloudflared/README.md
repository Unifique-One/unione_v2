# Cloudflare Tunnel

O Quadlet lê `TUNNEL_TOKEN` de `/etc/unione/cloudflared/tunnel.env`.
Mantenha esse arquivo fora do Git e com permissão 0600.

O container segue o padrão de `pt/container.md`: `unione-cloudflared`, com o alias de rede
`cloudflared` (que pode permanecer). O ingress aponta para o alias `traefik` do container
`unione-traefik`, que deve ser preservado.

No painel Cloudflare, configure `cloud.csphere.cloud` com destino `http://traefik:80` (alias de rede do `unione-traefik`).
Adicione outros hostnames apenas depois de criar as rotas no `unione-traefik`.

Configure `admin.csphere.cloud` em Cloudflare Access e exija MFA na política/IdP.
Não publique o dashboard do `unione-traefik`.
