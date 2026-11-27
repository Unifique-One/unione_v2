# UNIFIQUE ONE — Design System centralizado

Camada única de identidade visual da plataforma **UNIFIQUE ONE**, construída sobre Nextcloud e
serviços complementares.

- **Produto:** UNIFIQUE ONE (nome obrigatório em todas as interfaces destinadas ao usuário)
- **Domínio canônico:** `csphere.cloud` (portal: `cloud.csphere.cloud`)
- **Fonte oficial e exclusiva dos tokens:** `/opt/unione/pt/unione.md`
- **Especificação de rebranding:** `/opt/unione/pt/domain.md`

Nextcloud permanece como tecnologia interna/infraestrutura. A identidade visual exibida ao usuário
é exclusivamente UNIFIQUE ONE.

## Índice

```text
branding/
├── README.md                          ← este arquivo
├── assets/
│   ├── logos/
│   │   ├── README.md                  ← procedência e regras do wordmark
│   │   ├── unifique-one-light.svg     ← wordmark branco (header/login escuros)
│   │   └── unifique-one-royal.svg     ← wordmark royal (fundos claros)
│   ├── favicons/
│   │   ├── README.md                  ← E-01 RESOLVIDA: proveniência dos ícones oficiais
│   │   ├── favicon-16x16-b64f3020dd.png
│   │   ├── favicon-32x32-01e518e661.png ← favicon canônico (rel=icon / theming.favicon)
│   │   ├── apple-touch-icon-c435f4f4da.png ← theming.icon / apple-touch-icon
│   │   ├── favicon-cd754f5597.ico     ← formato ICO
│   │   └── favicon.svg                ← legado: fallback apenas (não canônico)
│   ├── icons/README.md                ← Lucide (conjunto oficial)
│   ├── fonts/README.md                ← Google Fonts (Plus Jakarta Sans + Inter)
│   └── images/README.md               ← sem raster de conteúdo oficial; favicons PNG/ICO em ../favicons/
├── tokens/
│   ├── colors.css                     ← paleta institucional, neutros, semânticos
│   ├── typography.css                 ← famílias, pesos, escala, tracking
│   ├── spacing.css                    ← raios, sombras, espaçamento, dimensões
│   └── design-tokens.css              ← ponto único de importação
├── themes/
│   ├── global.css                     ← reset + overrides nativos do Nextcloud
│   ├── login.css                      ← autenticação
│   ├── navigation.css                 ← header, apps, sidebar, breadcrumbs, drawer
│   ├── components.css                 ← botões, cards, tabelas, tags, modais, toasts
│   └── responsive.css                 ← breakpoints oficiais (importar por último)
└── integrations/
    ├── nextcloud/README.md            ← como o Nextcloud consome os tokens
    └── services/README.md             ← como os demais serviços consomem os tokens
```

## Uso básico

```html
<link rel="icon" type="image/png" sizes="32x32" href="/branding/assets/favicons/favicon-32x32-01e518e661.png" />
<link rel="apple-touch-icon" href="/branding/assets/favicons/apple-touch-icon-c435f4f4da.png" />
<meta name="theme-color" content="#212492" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>
<link rel="stylesheet" href="/branding/themes/global.css" />
<link rel="stylesheet" href="/branding/themes/navigation.css" />
<link rel="stylesheet" href="/branding/themes/components.css" />
<link rel="stylesheet" href="/branding/themes/responsive.css" />
```

Para a tela de login: `themes/login.css`.

## Tokens oficiais (resumo)

| Grupo | Tokens |
| --- | --- |
| Azuis | `#212492`, `#161869`, `#3539B8` |
| Energia | `#00AEEF`, `#F5EC5A`, `#FFD500`, `#E6007E`, `#45B649`, `#743BBD` |
| Neutros | `#FFFFFF`, `#111111`, `#F6F8FC`, `#EEF2F9`, `#DCE3F0`, `#C2CCE0`, `#5E6882`, `#2A324B`, `#0F1429` |
| Fontes | Plus Jakarta Sans (display), Inter (texto) |
| Raios | `6px`, `10px`, `16px`, `22px`, `9999px` |
| Sombras | `0 2px 6px rgba(33,36,146,.06)`, `0 6px 18px rgba(33,36,146,.10)`, `0 14px 36px rgba(22,24,105,.16)` |

Os dois tons intermediários usados no gradiente do cabeçalho do documento original não foram
reproduzidos: o gradiente usa apenas os azuis institucionais documentados
(`#161869 → #212492 → #3539B8`), para não introduzir cores fora da paleta oficial.

## Regras de uso

1. **Nunca invente cor, logotipo, ícone ou imagem.** Se faltar ativo, registre a pendência antes de
   criar substituto.
2. **Use somente o wordmark oficial** como base de logos (elementos preservados: texto
   `unıfıque`, Plus Jakarta Sans/Inter 800, 29px, `-0.04em`, círculos `#F5EC5A` e `#00AEEF`).
   Os favicons canônicos são os arquivos PNG/ICO oficiais baixados de `https://unifique.com.br/`;
   o `favicon.svg` derivado do wordmark é **fallback legado**, não o favicon canônico.
3. **Não use branding do Nextcloud** como identidade do produto; preserve porém referências
   técnicas, licenças e créditos legalmente exigidos.
4. **Não substitua palavras indiscriminadamente**: termos técnicos, avisos e versões devem permanecer.
5. **Um único ponto de verdade:** consumidores importam `tokens/design-tokens.css` ou
   `themes/global.css`; não copiam valores para seus próprios arquivos.
6. **Nome e domínio:** `UNIFIQUE ONE` e `csphere.cloud` em textos, `alt`, `title`, `aria-label` e
   links. Nenhum domínio de implementações anteriores.
7. **Contraste:** variante `light` do wordmark sobre superfícies royal/marinho; variante `royal`
   sobre branco/neutros claros.
8. **Não modificar containers diretamente:** persistir por volume, tema ou mecanismo oficial de
   extensão; mudanças idempotentes, com backup e testes por aplicativo.
9. **Nomes de containers:** seguir `/opt/unione/pt/container.md` — `unione-traefik` (reverse proxy,
   não Caddy) e `unione-cloudflared` (tunnel), além dos seis containers `unione-*` já padronizados.
   O alias de rede `traefik` permanece porque o ingress do Tunnel aponta para `http://traefik:80`;
   o alias `cloudflared` pode permanecer. Ollama não faz parte do escopo.

## Verificação de branding

- **Nextcloud — aprovado:** nome `UNIFIQUE ONE`, slogan, logotipo, favicon PNG oficial, cor primária e
  tipografia oficiais verificados nos temas; aplicativos habilitados conferidos individualmente.
  Ver `integrations/nextcloud/README.md`.
- **Página de status — aprovado:** `status.csphere.cloud` usa os tokens oficiais de
  `/opt/unione/pt/unione.md`, sem cores ou ativos inventados. Ver
  `integrations/services/README.md`.

## Versionamento

Repositório: https://github.com/Unifique-One/unione_v2.git. Identidade autorizada:
`rsdenck <piptr@protonmail.com>`. Use obrigatoriamente `gh` (GitHub CLI); o envio está bloqueado
até que `gh auth status` mostre esse login. Nunca versionar segredos, tokens, `cert.pem`,
credenciais do tunnel, backups ou `pt/domain.md`.

## Dependência resolvida

- **E-01 — favicon oficial (2026-11-27):** os arquivos canônicos foram baixados do site oficial
  `https://unifique.com.br/` por `scripts/branding/fetch-official-icons.py` e copiados para
  `assets/favicons/`. O Nextcloud usa `favicon-32x32-01e518e661.png` em `theming.favicon` e
  `apple-touch-icon-c435f4f4da.png` em `theming.icon`; a página de status usa o PNG oficial.
  O `favicon.svg` derivado do wordmark permanece apenas como fallback legado. Detalhes em
  `assets/favicons/README.md` e `/opt/unione/docs/branding/exceptions.md`.

## Pendências registradas

1. **Imagens raster de conteúdo ausentes:** nenhuma imagem PNG/JPEG/WebP de conteúdo foi fornecida
   em `/opt/unione/pt/unione.md`; a pasta `assets/images/` está reservada e nenhum placeholder foi
   criado. Os PNGs em `assets/favicons/` são ícones oficiais, não imagens de conteúdo.

Credenciais e identificadores de provedores presentes em `domain.md` não são reproduzidos nesta
árvore e não devem ser usados em frontend.
