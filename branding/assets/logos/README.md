# Logos — UNIFIQUE ONE

## Origem (fonte única)

Ambos os arquivos são derivados **exclusivamente** do wordmark SVG inline oficial publicado em
`/opt/unione/pt/unione.md` (bloco do `<svg ... aria-label="unifique">`, com o texto `unıfıque` e as
duas circunferências). Nenhum símbolo foi redesenhado e nenhuma marca de terceiros foi utilizada.

Elementos preservados do SVG oficial:

| Elemento | Valor oficial |
| --- | --- |
| `viewBox` do wordmark | `0 0 164 42` |
| Texto | `unıfıque` (dois `ı` sem ponto; os pontos são as circunferências) |
| Fonte | `'Plus Jakarta Sans', 'Inter', sans-serif`, peso `800`, tamanho `29`, `letter-spacing: -0.04em` |
| Ponto 1 | `cx=44.2 cy=8.5 r=3.2`, `#F5EC5A` |
| Ponto 2 | `cx=71.2 cy=8.5 r=3.2`, `#00AEEF` |

O rótulo `ONE` não é um novo símbolo: ele reaproveita o componente `.brand-badge` documentado no
mesmo `unione.md` (pílula amarela `#F5EC5A`, texto `#161869`, Plus Jakarta Sans 800, 11px,
`letter-spacing: 0.05em`) com o rótulo trocado de `Cloud` para o nome oficial do produto.

## Arquivos

| Arquivo | Uso | Cor do wordmark |
| --- | --- | --- |
| `unifique-one-light.svg` | Cabeçalho escuro, login, toast, sobreposições sobre royal/marinho | `#FFFFFF` |
| `unifique-one-royal.svg` | Fundos claros: sidebar, painéis, documentos, e-mails | `#212492` |

## Regras de uso

1. Nomeie o produto sempre como **UNIFIQUE ONE** em textos, `alt`, `title` e `aria-label`.
2. Nunca altere as cores das duas circunferências (`#F5EC5A` e `#00AEEF`) nem troque sua posição.
3. Nunca substitua o wordmark por ícones de qualquer outra ferramenta (inclusive Nextcloud).
4. Não redesenhe as letras, não use outra fonte que não Plus Jakarta Sans / Inter e não remova o
   `letter-spacing` oficial.
5. Preserve a proporção; não estique, não rotacione e não aplique sombra ao wordmark.
6. Em fundos com contraste insuficiente, use a variante `light` sobre uma superfície royal, nunca
   uma terceira cor.
7. O domínio canônico do produto é `csphere.cloud`; não use domínios de implementações anteriores
   em textos de marca.
