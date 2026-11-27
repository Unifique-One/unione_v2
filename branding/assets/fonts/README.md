# Tipografia — UNIFIQUE ONE

## Fontes oficiais

Plus Jakarta Sans (display) e Inter (texto), conforme `/opt/unione/pt/unione.md`.

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
```

Pesos solicitados: Inter `400, 500, 600, 700, 800`; Plus Jakarta Sans `500, 600, 700, 800`.

## Variáveis

Definidas em `../../tokens/typography.css`:

| Variável | Valor |
| --- | --- |
| `--unifique-font-display` | `"Plus Jakarta Sans", "Inter", sans-serif` |
| `--unifique-font-family` | `"Inter", "Plus Jakarta Sans", Arial, sans-serif` |

Usar `--unifique-font-display` em títulos, navegação, botões, badges, cabeçalhos de tabela e
números de logo. Usar `--unifique-font-family` em texto corrido, campos e descrições.

## Regras

1. Não substituir as fontes por system-ui, Roboto, Open Sans ou qualquer outra.
2. Não inventar pesos fora da faixa documentada.
3. O SVG oficial do wordmark declara a mesma pilha de fontes; para que as letras coincidam com o
   HTML, as fontes precisam estar carregadas antes da renderização do logotipo (o `display=swap`
   oficial é aceito).
4. Nenhum arquivo de fonte é distribuído neste diretório: as fontes vêm do Google Fonts, conforme
   o documento oficial. Consumidores sem CDN devem espelhar os mesmos arquivos das mesmas famílias.
5. Os favicons canônicos são arquivos PNG/ICO oficiais e não dependem do renderizador de texto.
   Apenas o `favicon.svg` legado (fallback, derivado do wordmark) usava a mesma pilha de fontes.
