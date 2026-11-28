#!/usr/bin/env bash
# UNIFIQUE ONE — verificação do editor de documentos, do branding do Collabora
# e do estado do SSO/SAML. Não altera nenhum serviço.
set -uo pipefail

NC="unione-nextcloud"
COLLABORA="unione-collabora"
COLLABORA_DIR="/opt/unione/stack/config/collabora"
THEME_ID="unifique"
failed=0

ok()   { printf '  [OK]   %s\n' "$*"; }
bad()  { printf '  [FAIL] %s\n' "$*"; failed=$((failed + 1)); }

occ() { podman exec -u www-data "$NC" php occ "$@" 2>/dev/null; }

printf 'UNIFIQUE ONE - Office/SSO verification\n\n'

for c in "$NC" "$COLLABORA"; do
	if podman ps --format '{{.Names}}' | grep -qx "$c"; then
		ok "container ativo: $c"
	else
		bad "container inativo: $c"
	fi
done

printf '\nNextcloud apps:\n'
app_list="$(occ app:list || true)"
if printf '%s\n' "$app_list" | grep -qE '^  - richdocuments:'; then
	ok 'richdocuments instalado'
else
	bad 'richdocuments não instalado'
fi
if printf '%s\n' "$app_list" | grep -qE '^  - office:'; then
	ok 'office (visão geral) instalado'
else
	bad 'office (visão geral) não instalado'
fi
if printf '%s\n' "$app_list" | grep -qE '^  - user_saml:'; then
	ok 'user_saml instalado'
else
	bad 'user_saml não instalado'
fi

printf '\nWOPI configuration:\n'
for pair in "wopi_url:http://collabora:9980" \
            "public_wopi_url:https://office.csphere.cloud" \
            "wopi_callback_url:https://cloud.csphere.cloud"; do
	key="${pair%%:*}"
	expected="${pair#*:}"
	actual="$(occ config:app:get richdocuments "$key" | tr -d '[:space:]')"
	if [[ "$actual" == "$expected" ]]; then
		ok "$key = $expected"
	else
		bad "$key = '$actual' (esperado '$expected')"
	fi
done

printf '\nCollabora discovery and branding:\n'
discovery="$(podman exec "$NC" sh -c 'curl -sS http://collabora:9980/hosting/discovery' 2>/dev/null || true)"
if printf '%s' "$discovery" | grep -q '<wopi-discovery>'; then
	ok 'WOPI discovery responde'
else
	bad 'WOPI discovery não responde'
fi
hash="$(printf '%s' "$discovery" | grep -oE '/browser/[a-f0-9]+/' | head -1 | sed -e 's|^/browser/||' -e 's|/$||')"
if [[ -n "$hash" ]]; then
	ok "versão do browser: $hash"
	for asset in "branding.js:application/javascript" "branding.css:text/css" \
	             "images/unione-symbol-light.png:image/png" \
	             "images/unione-symbol-dark.png:image/png"; do
		path="${asset%%:*}"
		mime="${asset#*:}"
		result="$(podman exec "$NC" sh -c "curl -sS -o /dev/null -w '%{http_code} %{content_type}' http://collabora:9980/browser/$hash/$path" 2>/dev/null || true)"
		if [[ "$result" == "200 $mime" ]]; then
			ok "asset do tema: $path"
		else
			bad "asset do tema: $path ($result)"
		fi
	done
else
	bad ' não foi possível determinar o hash dos assets do editor'
fi

for f in coolwsd.xml branding.js branding.css unione-symbol-light.png unione-symbol-dark.png; do
	[[ -f "$COLLABORA_DIR/$f" ]] && ok "arquivo local: $f" || bad "arquivo local ausente: $f"
done
config="$(cat "$COLLABORA_DIR/coolwsd.xml" 2>/dev/null || true)"
if grep -q '<brandProductName[^>]*>UNIFIQUE ONE</brandProductName>' <<<"$config" && \
   grep -q '>https://unifique.com.br</brandProductURL>' <<<"$config" && \
   grep -q '>https://unifique.com.br</help_url>' <<<"$config"; then
	ok 'config do editor usa UNIFIQUE ONE e unifique.com.br'
else
	bad 'config do editor não está com o branding UNIFIQUE ONE'
fi
if cmp -s "$COLLABORA_DIR/unione-symbol-light.png" \
         "/opt/unione/branding/assets/logos/unione-symbol-light.png" && \
   cmp -s "$COLLABORA_DIR/unione-symbol-dark.png" \
         "/opt/unione/branding/assets/logos/unione-symbol-dark.png"; then
	ok 'logos do editor são as oficiais do tema'
else
	bad 'logos do editor divergem das oficiais do tema'
fi

printf '\nSSO/SAML:\n'
if [[ -n "$(occ config:app:get user_saml type 2>/dev/null)" ]]; then
	# Qualquer configuração salva pelo app também aparece em config:list.
	:
fi
saml_config="$(occ config:list user_saml 2>/dev/null || true)"
if printf '%s' "$saml_config" | grep -q 'idp-entityId'; then
	if printf '%s\n' "$app_list" | grep -qE '^  - user_saml: (installed )?$'; then
		bad 'SAML configurado, mas app desativado'
	else
		ok 'SAML configurado e app ativo'
	fi
else
	if printf '%s\n' "$app_list" | grep -qE '^  - user_saml:'; then
		ok 'SAML sem IdP: app instalado e desativado (aguardando metadata)'
	else
		bad 'user_saml não instalado'
	fi
fi

printf '\nLogin (identidade visual):\n'
login_html="$(podman exec "$NC" sh -c 'curl -sS http://127.0.0.1/login' 2>/dev/null || true)"
if printf '%s' "$login_html" | grep -qi 'nextcloud\|AGPL\|licenciado sob'; then
	bad 'login contém termos proibidos'
else
	ok 'login sem Nextcloud/AGPL/licença'
fi
for icon in contact-whatsapp.svg contact-telegram.svg contact-email.svg contact-area-cliente.png; do
	printf '%s' "$login_html" | grep -Fq "$icon" && ok "ícone no rodapé: $icon" || bad "ícone ausente: $icon"
done

printf '\nSummary: %d failed check(s)\n' "$failed"
[[ "$failed" -eq 0 ]] && { echo 'Result: PASS'; exit 0; }
echo 'Result: FAIL'
exit 1
