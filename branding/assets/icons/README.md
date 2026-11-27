# Ícones — UNIFIQUE ONE

## Conjunto oficial

O `unione.md` define **Lucide** como conjunto de ícones da interface:

```html
<script src="https://unpkg.com/lucide@latest"></script>
<i data-lucide="folder-closed" style="width:17px;height:17px;"></i>
<script>lucide.createIcons();</script>
```

Não substituir por outro conjunto (inclusive o conjunto de ícones embutido do Nextcloud) nas
interfaces destinadas ao usuário. Ícones técnicos exigidos por licença ou pela própria aplicação
podem permanecer, mas não devem ser apresentados como identidade visual do produto.

## Ícones documentados em `unione.md`

Os seguintes nomes aparecem no documento oficial e constituem o vocabulário inicial:

`folder-closed`, `file-spreadsheet`, `video`, `shield-check`, `calendar`, `search`, `bell`,
`palette`, `chevron-down`, `hard-drive`, `clock`, `star`, `users`, `trash-2`, `home`, `list`,
`layout-grid`, `folder-plus`, `upload-cloud`, `cloud`, `file-text`, `lock`, `folder`, `x`, `send`,
`link`, `file-code`, `folder-open`, `presentation`, `share-2`, `rotate-ccw`, `check-circle-2`.

## Regras de estilo

1. Cor padrão: `var(--unifique-text-muted)`; cor ativa/selecionada: `var(--unifique-royal)`;
   destaque sobre fundo escuro: `var(--unifique-yellow)`.
2. Tamanhos documentados: 11px, 14px, 15px, 16px, 17px, 18px, 20px, 22px, 36px (estado vazio).
3. Traço consistente com Lucide; não aplicar preenchimento arbitrário. A estrela favorita do
   documento original usa um âmbar que não pertence à paleta oficial; use
   `var(--unifique-yellow-bright)` como preenchimento.
4. Ícones nunca substituem o wordmark. O logotipo oficial está em `../logos/`.
5. Ícones de produtos (Drive, Office, Meet, Cofre) usam as cores oficiais documentadas: royal,
   ciano, amarelo e verde, respectivamente.

## Carregamento

Preferir o script oficial do Lucide quando a aplicação permitir CDN. Em ambientes sem acesso a CDN,
o consumidor deve servir o Lucide localmente a partir de seu próprio bundle, preservando os mesmos
nomes de ícone.
