# Integração — Serviços complementares

Serviços com GUI própria consomem a mesma camada centralizada de identidade. Cada consumidor
referencia os arquivos desta árvore; **não duplique** tokens, logotipos ou fontes dentro do
serviço.

## Domínio canônico

O domínio canônico do **UNIFIQUE ONE** é `csphere.cloud`:

| Subdomínio | Função |
| --- | --- |
| `cloud.csphere.cloud` | Portal principal |
| `drive.csphere.cloud` | Arquivos e armazenamento |
| `office.csphere.cloud` | Documentos e planilhas |
| `meet.csphere.cloud` | Videoconferência e chat |
| `calendar.csphere.cloud` | Calendário |
| `contacts.csphere.cloud` | Contatos |
| `forms.csphere.cloud` | Formulários |
| `board.csphere.cloud` | Quadros e colaboração |
| `ai.csphere.cloud` | Serviços de IA |
| `id.csphere.cloud` | Identidade e SSO |
| `status.csphere.cloud` | Status dos serviços |
| `admin.csphere.cloud` | Administração restrita |

Credenciais e identificadores de provedores de infraestrutura presentes no documento de domínio
**não fazem parte** deste design system e não devem ser copiados para arquivos de frontend.

## Consumo mínimo

```html
<link rel="icon" type="image/png" sizes="32x32" href="/branding/assets/favicons/favicon-32x32-01e518e661.png" />
<link rel="apple-touch-icon" href="/branding/assets/favicons/apple-touch-icon-c435f4f4da.png" />
<meta name="theme-color" content="#212492" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>
<link rel="stylesheet" href="/branding/themes/global.css" />
<link rel="stylesheet" href="/branding/themes/components.css" />
<link rel="stylesheet" href="/branding/themes/responsive.css" />
```

O componente de marca do serviço:

```html
<a class="brand-logo" href="https://cloud.csphere.cloud" aria-label="UNIFIQUE ONE">
  <img src="/branding/assets/logos/unifique-one-light.svg" alt="UNIFIQUE ONE" width="134" height="34" />
</a>
```

Em fundos claros, troque por `unifique-one-royal.svg`. O nome apresentado é sempre
**UNIFIQUE ONE**, mesmo que o serviço tenha nome funcional próprio (por exemplo, "Arquivos" em
`drive.csphere.cloud`).

## Regras para cada serviço

1. Use `tokens/design-tokens.css` (ou `themes/global.css`) como única origem de cores, fontes,
   raios e sombras. Nunca defina hexadécimal local.
2. Use Lucide conforme `assets/icons/README.md`; não introduza outro conjunto de ícones.
3. Use os SVGs derivados do wordmark para logotipos e os arquivos PNG/ICO oficiais para favicon
   (`favicon-32x32-01e518e661.png` e `apple-touch-icon-c435f4f4da.png`); o `favicon.svg` é fallback
   legado. Não use ícones da marca original do serviço como identidade do produto.
4. Aplique `themes/login.css` em qualquer tela de autenticação; aplique `themes/navigation.css`
   quando houver cabeçalho.
5. Preserve licenças, créditos e avisos legais exigidos pelo componente.
6. Se a ferramenta não aceitar CSS externo, use o mecanismo oficial de white-label da ferramenta e
   registre a limitação em `docs/branding/exceptions.md` (fora desta árvore de design system).
7. Teste cada serviço individualmente em desktop e mobile antes de considerar concluído.

## Verificação concluída — página de status

A verificação de branding da página de status (`status.csphere.cloud`) passou: ela usa os tokens
oficiais de cores e tipografia definidos em `/opt/unione/pt/unione.md` (royal `#212492`, amarelo
`#F5EC5A`, Plus Jakarta Sans e Inter) e o favicon PNG oficial
`favicon-32x32-01e518e661.png`, sem introduzir cores ou ativos inventados. As informações
de serviços e incidentes foram mantidas.

A identidade é servida pelo container `unione-status`; ingress do Tunnel via `unione-traefik`
(alias de rede `traefik`, destino `http://traefik:80`).

## Favicon — E-01 resolvida (2026-11-27)

Os favicons canônicos foram baixados do site oficial `https://unifique.com.br/` por
`scripts/branding/fetch-official-icons.py` e copiados para `assets/favicons/`: PNG 16×16, PNG 32×32,
`apple-touch-icon` e ICO. O `favicon.svg` derivado do wordmark permanece apenas como fallback legado.
Ver `assets/favicons/README.md` e `/opt/unione/docs/branding/exceptions.md`.
