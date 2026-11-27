# Padronização dos containers
- Considerando os serviços que você já executou, esta seria minha nomenclatura oficial:
+---------------------------+---------------------------+--------------------------------------+
| CONTAINER                 | STATUS                    | FUNCAO                               |
+---------------------------+---------------------------+--------------------------------------+
| unione-postgres           | ATIVO                     | Banco de dados                       |
| unione-redis              | ATIVO                     | Cache e sessoes                      |
| unione-nextcloud          | ATIVO                     | Plataforma principal                 |
| unione-collabora          | ATIVO                     | Editor de documentos                 |
| unione-coturn             | ATIVO                     | Servico STUN/TURN                    |
| unione-status             | ATIVO                     | Pagina de status                     |
| unione-cloudflared        | RENOMEAR                  | Cloudflare Tunnel                    |
| unione-traefik            | RENOMEAR                  | Reverse Proxy                        |
+---------------------------+---------------------------+--------------------------------------+
| CONTAINERS FUTUROS        |                           |                                      |
+---------------------------+---------------------------+--------------------------------------+
| unione-nextcloud-cron     | PLANEJADO                 | Tarefas agendadas                    |
| unione-nextcloud-preview  | PLANEJADO                 | Geracao de previews                  |
| unione-notify-push        | PLANEJADO                 | Notificacoes push                    |
| unione-portal             | PLANEJADO                 | Portal institucional                 |
| unione-auth               | PLANEJADO                 | Identidade e autenticacao            |
| unione-monitoring         | PLANEJADO                 | Monitoramento                        |
+---------------------------+---------------------------+--------------------------------------+

- os container serão dedicados da unifique (projeto: unione)
- somente containers com o padrão de nome e branding devem ser versionados para: https://github.com/Unifique-One/unione_v2.git
- versionados somente com:rsdenck | piptr@protonmail.com
- usando gh (github cli)
gh auth status
