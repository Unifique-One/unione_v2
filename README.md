# UNIFIQUE ONE — Cloudflare Tunnel + Traefik + Podman

Base de implantação da camada de entrada. Portal: `cloud.csphere.cloud`; domínio: `csphere.cloud`.

Fluxo: Cloudflare → `unione-cloudflared` → `unione-traefik` → aplicações na rede Podman `unione`.

Os containers seguem o padrão oficial de `pt/container.md`: `unione-cloudflared` (Cloudflare Tunnel)
e `unione-traefik` (reverse proxy), além de `unione-postgres`, `unione-redis`, `unione-nextcloud`,
`unione-collabora`, `unione-coturn` e `unione-status`. O alias de rede `traefik` permanece porque o
ingress do Tunnel aponta para `http://traefik:80`; o alias `cloudflared` também pode permanecer.
Ollama não faz parte do stack. O proxy reverso é Traefik (não Caddy).

## Escopo e premissas

- Este pacote instala os containers `unione-traefik` e `unione-cloudflared`. Não instala Nextcloud, Collabora, Talk ou outros produtos.
- O backend do portal está como `http://nextcloud:80`. Ajuste o alias para o nome DNS real do container Nextcloud.
- Os hostnames complementares são exemplos. Ative-os no `unione-traefik` somente quando os serviços existirem.
- O dashboard/API do `unione-traefik` não é publicado.
- Não exponha portas 80/443 da VM no roteador. O Tunnel cria conexões de saída.
- Cloudflare Access/MFA é configurado no painel Cloudflare; não é ativado automaticamente pelos arquivos.

## Instalação

Copie `opt/unione` para `/opt/unione` e os arquivos em `quadlet/` para `/etc/containers/systemd/`.

Crie o arquivo secreto:

```bash
sudo install -d -m 0700 /etc/unione/cloudflared
sudo install -m 0600 /dev/null /etc/unione/cloudflared/tunnel.env
sudoedit /etc/unione/cloudflared/tunnel.env
```

Conteúdo:

```bash
TUNNEL_TOKEN=COLE_AQUI_O_TOKEN_DO_TUNNEL
```

Proteja o arquivo:

```bash
sudo chown root:root /etc/unione/cloudflared/tunnel.env
sudo chmod 0600 /etc/unione/cloudflared/tunnel.env
```

No painel Cloudflare, crie um Tunnel `unifique-one` e configure Public Hostname:
- `cloud.csphere.cloud` → `http://traefik:80`

Adicione `drive`, `office`, `meet`, `ai`, `id` e `admin` somente quando as respectivas rotas estiverem preparadas. Todos podem apontar para `http://traefik:80`.

Copie os Quadlets:

```bash
sudo cp quadlet/unione.network /etc/containers/systemd/
sudo cp quadlet/traefik.container /etc/containers/systemd/
sudo cp quadlet/cloudflared.container /etc/containers/systemd/
```

Os arquivos `traefik.container` e `cloudflared.container` geram as unidades `traefik.service` e
`cloudflared.service`; os nomes dos containers são `unione-traefik` e `unione-cloudflared`
(conforme `ContainerName=`). Use os nomes dos containers (`unione-*`) em comandos `podman`.

Recarregue e inicie:

```bash
sudo systemctl daemon-reload
sudo systemctl start traefik.service
sudo systemctl start cloudflared.service
sudo systemctl enable traefik.service cloudflared.service
```

Verifique:

```bash
systemctl status traefik.service cloudflared.service
journalctl -u traefik.service -f
journalctl -u cloudflared.service -f
```

## Rede Podman e Nextcloud

O arquivo `unione.network` cria uma rede compartilhada. Conecte o Nextcloud existente:

```bash
podman network connect --alias nextcloud unione NOME_OU_ID_DO_CONTAINER
```

Se o Nextcloud já estiver conectado à rede, verifique se possui alias `nextcloud`:

```bash
podman network inspect unione
```

Ajuste a configuração dinâmica do `unione-traefik` em `/opt/unione/traefik/dynamic/services.yml` se o alias ou a porta interna forem diferentes.

## Cloudflare Access com MFA

No Cloudflare Zero Trust:
1. Access → Applications → Add an application → Self-hosted.
2. Configure `admin.csphere.cloud`.
3. Crie uma política Allow limitada a usuários/grupos administrativos específicos. Não use `Everyone`.
4. Exija MFA por meio do provedor de identidade e da política de autenticação correspondente.
5. Configure duração de sessão adequada e revise os logs.
6. Teste com uma conta autorizada e outra não autorizada.

Access não exige MFA automaticamente. A exigência deve ser configurada no IdP/política. O hostname administrativo não possui backend configurado neste pacote e deve permanecer sem aplicação publicada até a definição do destino. Não publique o dashboard do `unione-traefik`.

## Nextcloud atrás de proxy

Mescle no `config.php` os valores necessários, adaptando proxy e domínios:

```php
'trusted_domains' => [
  'cloud.csphere.cloud',
],
'trusted_proxies' => [
  'IP_OU_SUBREDE_REAL_DO_PROXY',
],
'overwriteprotocol' => 'https',
'overwritehost' => 'cloud.csphere.cloud',
```

Não copie literalmente o placeholder de `trusted_proxies`. Use o endereço/sub-rede efetivamente observados pelo Nextcloud e siga a documentação da versão instalada.

## Segurança e validação

- Nunca publique PostgreSQL, Redis, Podman socket ou SSH no Tunnel.
- Não armazene token no Git nem em imagem OCI.
- Fixe versões/digests das imagens antes de produção; revise atualizações deliberadamente.
- Configure WAF/Access e autenticação nas aplicações.
- Teste login, upload/download, WebSocket quando aplicável e bloqueio administrativo.
- Collabora e Talk exigem configuração específica de proxy, WebSocket, timeouts e, conforme a arquitetura, serviços adicionais.

## Verificação de branding

- Nextcloud: verificação concluída — nome `UNIFIQUE ONE`, slogan, logotipo, favicon PNG oficial (`favicon-32x32-01e518e661.png` em `theming.favicon` e `apple-touch-icon-c435f4f4da.png` em `theming.icon`), cor e fonte oficiais conferidos; aplicativos habilitados verificados. Detalhes em `branding/integrations/nextcloud/README.md`.
- Página de status: verificação concluída — usa os tokens oficiais de `pt/unione.md` e o favicon PNG oficial, sem cores ou ativos inventados. Detalhes em `branding/integrations/services/README.md`.
- Favicon: E-01 resolvida em 2026-11-27 — arquivos oficiais baixados de `https://unifique.com.br/` por `scripts/branding/fetch-official-icons.py` em `branding/assets/favicons/`; `favicon.svg` é apenas fallback legado. Detalhes em `branding/assets/favicons/README.md` e `docs/branding/exceptions.md`.

## Versionamento

Repositório: https://github.com/Unifique-One/unione_v2.git. Identidade autorizada: `rsdenck <piptr@protonmail.com>`. Use obrigatoriamente o GitHub CLI (`gh`); o envio está bloqueado até que `gh auth status` mostre esse login. Somente containers com o padrão de nome e branding (`unione-*`, conforme `pt/container.md`) devem ser versionados. Nunca versionar segredos, tokens, `cert.pem`, credenciais do tunnel, backups ou `pt/domain.md`.
