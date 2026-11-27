# Favicon — UNIFIQUE ONE

## E-01 RESOLVIDA (2026-11-27)

O favicon institucional original foi obtido do **site oficial** `https://unifique.com.br/` pelo script
`scripts/branding/fetch-official-icons.py` e copiado para `/opt/unione/branding/assets/favicons/`.
Não é mais um ativo derivado do wordmark inline de `/opt/unione/pt/unione.md`: o SVG legado permanece
apenas como fallback. Ver `/opt/unione/docs/branding/exceptions.md`.

### Arquivos canônicos

| Arquivo | Uso |
| --- | --- |
| `favicon-16x16-b64f3020dd.png` | Ícone PNG 16×16 (favicons pequenos). |
| `favicon-32x32-01e518e661.png` | Ícone PNG 32×32 — **favicon canônico** para `rel=icon` e `theming.favicon`. |
| `apple-touch-icon-c435f4f4da.png` | Ícone para `apple-touch-icon` e `theming.icon` do Nextcloud. |
| `favicon-cd754f5597.ico` | Formato ICO para consumidores que o exigem. |

`favicon.svg` foi **derivado do wordmark SVG oficial** (`unıfıque` com as circunferências `#F5EC5A` e
`#00AEEF`) antes da entrega dos arquivos originais. É mantido somente como **fallback legado**: não é
o favicon canônico e não deve ser usado em `rel=icon`, `theming.favicon` ou `theming.icon` quando os
arquivos oficiais estiverem disponíveis.

### Nextcloud

- `theming.favicon` = `/mnt/branding/assets/favicons/favicon-32x32-01e518e661.png`
- `theming.icon` = `/mnt/branding/assets/favicons/apple-touch-icon-c435f4f4da.png`

### Página de status

`status.csphere.cloud` usa o favicon PNG oficial `favicon-32x32-01e518e661.png`, sem ativo
inventado ou derivado.

## Uso

```html
<link rel="icon" type="image/png" sizes="32x32" href="/branding/assets/favicons/favicon-32x32-01e518e661.png" />
<link rel="icon" type="image/png" sizes="16x16" href="/branding/assets/favicons/favicon-16x16-b64f3020dd.png" />
<link rel="apple-touch-icon" href="/branding/assets/favicons/apple-touch-icon-c435f4f4da.png" />
<link rel="shortcut icon" href="/branding/assets/favicons/favicon-cd754f5597.ico" />
<meta name="theme-color" content="#212492" />
```

Regras:

1. Nunca usar favicon do Nextcloud ou de qualquer outro serviço como identidade do produto.
2. Preservar os arquivos oficiais baixados de `https://unifique.com.br/`; não redesenhar, recolorir
   nem substituir por aproximações.
3. Manter o nome `UNIFIQUE ONE` no `title`/`aria-label` da página e nos textos alternativos.
4. O domínio canônico é `csphere.cloud`.
5. Usar `favicon.svg` somente como fallback legado quando o consumidor não aceitar PNG/ICO, sem
   apresentá-lo como ativo canônico.
