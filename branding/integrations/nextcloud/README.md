# Integração — Nextcloud

**Nextcloud é tecnologia interna.** A identidade apresentada ao usuário é exclusivamente
**UNIFIQUE ONE**. Não usar logotipo, favicon, paleta ou tipografia do Nextcloud como identidade do
produto; não substituir textualmente todas as ocorrências da palavra "Nextcloud" no sistema
(avisos técnicos, licenças, créditos e informações de versão devem ser preservados).

## Como o Nextcloud consome os tokens

1. Carregue a base uma única vez:

   ```html
   <link rel="stylesheet" href="/branding/themes/global.css" />
   <!-- global.css já importa tokens/design-tokens.css -->
   <link rel="stylesheet" href="/branding/themes/navigation.css" />
   <link rel="stylesheet" href="/branding/themes/components.css" />
   <link rel="stylesheet" href="/branding/themes/responsive.css" />
   ```

   Para a tela de autenticação, carregue `themes/login.css` no lugar de `navigation.css`.

2. `themes/global.css` publica os overrides nativos do Nextcloud, sempre apontando para tokens
   oficiais:

   | Variável Nextcloud | Valor UNIFIQUE ONE |
   | --- | --- |
   | `--color-primary` | `--unifique-royal` (`#212492`) |
   | `--color-primary-element` | `--unifique-royal` |
   | `--color-primary-element-hover` | `--unifique-royal-dark` (`#161869`) |
   | `--color-primary-element-text` | `--unifique-white` |
   | `--color-main-background` | `--unifique-background` |
   | `--color-background-hover` | `--unifique-gray-100` |
   | `--color-main-text` | `--unifique-text` |
   | `--color-text-maxcontrast` | `--unifique-text-muted` |
   | `--color-border` | `--unifique-border` |

3. Quando o painel de temas do Nextcloud estiver disponível, configure os valores equivalentes:
   nome do produto `UNIFIQUE ONE`, cor primária `#212492`, cor de fundo `#FFFFFF`, cor de texto
   `#0F1429`, logotipo `assets/logos/unifique-one-light.svg` no cabeçalho e favicon
   `assets/favicons/favicon-32x32-01e518e661.png` (`theming.favicon`), além de
   `assets/favicons/apple-touch-icon-c435f4f4da.png` (`theming.icon`). Alternativas oficiais de
   configuração (por exemplo, definir o nome via `occ theming:config name "UNIFIQUE ONE"`) devem ser
   usadas em vez de editar o core.

4. Persista os arquivos por meio de volume, tema/custom CSS ou aplicativo de extensão oficial.
   Não modifique imagens de containers em execução; atualizações não devem apagar o branding.

## Logotipos e favicon

- Cabeçalho escuro e login: `assets/logos/unifique-one-light.svg` (texto `#FFFFFF`).
- Sidebar, painéis e fundos claros: `assets/logos/unifique-one-royal.svg` (texto `#212492`).
- Favicon: `assets/favicons/favicon-32x32-01e518e661.png` (PNG oficial) e ícone
  `assets/favicons/apple-touch-icon-c435f4f4da.png`. **E-01 resolvida em 2026-11-27:** os arquivos
  vêm do site oficial `https://unifique.com.br/`, baixados por
  `scripts/branding/fetch-official-icons.py`. O `assets/favicons/favicon.svg` é **fallback legado**,
  derivado do wordmark, e não é o favicon canônico. Ver `assets/favicons/README.md`.

## Tipografia e ícones

Inclua os links oficiais do Google Fonts (Plus Jakarta Sans + Inter) e o script Lucide descritos
em `assets/fonts/README.md` e `assets/icons/README.md`. Não use os ícones embutidos do Nextcloud
como identidade nas interfaces destinadas ao usuário.

## Verificação por aplicativo

O tema principal não cobre automaticamente todos os aplicativos. Verifique individualmente:

- Files, Photos, Calendar, Contacts, Talk, Deck, Notes, Tasks, Forms, Whiteboard, Office e demais
  aplicativos habilitados.
- Em cada um: nome exibido, logotipo, favicon, tela de login (quando houver), cabeçalho, menu,
  botões, formulários, cards, notificações, mensagens de erro, telas vazias e versão mobile.
- Onde a aplicação não aceitar CSS externo, use apenas os mecanismos de white-label suportados e
  registre a limitação como exceção documentada.

## Verificação concluída

A verificação de branding do Nextcloud passou: nome do produto `UNIFIQUE ONE`, slogan aprovado,
logotipo (wordmark oficial), favicon PNG oficial (`favicon-32x32-01e518e661.png`) e ícone oficial
(`apple-touch-icon-c435f4f4da.png`), cor primária royal `#212492` e tipografia Plus Jakarta
Sans/Inter conferidos nos mecanismos oficiais de theming. Os aplicativos
habilitados foram verificados individualmente com os mesmos tokens. Avisos técnicos, licenças,
créditos e informações de versão foram preservados.

## Regras

1. Nenhuma cor fora dos tokens oficiais.
2. Nenhum símbolo novo: logotipos derivados somente do wordmark oficial; favicons e ícones devem ser
   os arquivos oficiais PNG/ICO.
3. Preserve avisos de segurança, licenças, créditos e números de versão exigidos.
4. Não altere APIs ou serviços backend sem necessidade.
5. Aplique mudanças de forma idempotente e com backup prévio.
