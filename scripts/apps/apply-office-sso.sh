#!/usr/bin/env bash
# UNIFIQUE ONE — instala/configura o editor de documentos (richdocuments +
# Collabora) e o SSO/SAML. Nenhum arquivo do core do Nextcloud é alterado.
#
# Uso:
#   bash /opt/unione/scripts/apps/apply-office-sso.sh
#   SAML_METADATA_URL=https://idp.exemplo.com/metadata.xml \
#     bash /opt/unione/scripts/apps/apply-office-sso.sh
set -euo pipefail

NC_CONTAINER="unione-nextcloud"
COLLABORA_URL_INTERNAL="http://collabora:9980"
COLLABORA_URL_PUBLIC="https://office.csphere.cloud"
WOPI_CALLBACK="https://cloud.csphere.cloud"
SP_ENTITY_ID="https://id.csphere.cloud/apps/user_saml/saml/metadata"

log() { printf '[unione] %s\n' "$*"; }
die() { printf '[unione] ERRO: %s\n' "$*" >&2; exit 1; }

occ() { podman exec -u www-data "$NC_CONTAINER" php occ "$@"; }

podman ps --format '{{.Names}}' | grep -qx "$NC_CONTAINER" || die "container $NC_CONTAINER não está rodando"

install_if_missing() {
	local app="$1"
	if occ app:list 2>/dev/null | grep -qE "^  - ${app}( |$| \()"; then
		log "app já instalado: $app"
	else
		log "instalando $app"
		occ app:install --keep-disabled "$app"
	fi
}

install_if_missing richdocuments
install_if_missing user_saml

# richdocuments: o navegador fala com office.csphere.cloud; o Nextcloud fala
# com o alias interno collabora:9980. O callback volta sempre ao host canônico.
occ config:app:set richdocuments wopi_url --value="$COLLABORA_URL_INTERNAL" >/dev/null
occ config:app:set richdocuments public_wopi_url --value="$COLLABORA_URL_PUBLIC" >/dev/null
occ config:app:set richdocuments wopi_callback_url --value="$WOPI_CALLBACK" >/dev/null
occ app:enable richdocuments >/dev/null
log "richdocuments ativo (${COLLABORA_URL_PUBLIC})"

if [[ -z "${SAML_METADATA_URL:-}" ]]; then
	occ app:disable user_saml >/dev/null 2>&1 || true
	log "user_saml instalado, mas desativado: URL de metadata do IdP ainda não fornecida"
	exit 0
fi

log "importando metadata SAML de $SAML_METADATA_URL"
metadata="$(python3 - "$SAML_METADATA_URL" <<'PY'
import sys, urllib.request, xml.etree.ElementTree as ET
url = sys.argv[1]
req = urllib.request.Request(url, headers={'User-Agent': 'UNIFIQUE ONE/1.0'})
with urllib.request.urlopen(req, timeout=30) as response:
    raw = response.read()
root = ET.fromstring(raw)
ns = {'md': 'urn:oasis:names:tc:SAML:2.0:metadata', 'ds': 'http://www.w3.org/2000/09/xmldsig#'}
entity = root.attrib.get('entityID', '')
sso = root.find('.//md:SingleSignOnService[@Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"]', ns)
if sso is None:
    sso = root.find('.//md:SingleSignOnService', ns)
slo = root.find('.//md:SingleLogoutService[@Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"]', ns)
if slo is None:
    slo = root.find('.//md:SingleLogoutService', ns)
cert = root.find('.//ds:X509Certificate', ns)
values = {
    'entity': entity,
    'sso': sso.attrib.get('Location', '') if sso is not None else '',
    'slo': slo.attrib.get('Location', '') if slo is not None else '',
    'cert': ''.join((cert.text or '').split()) if cert is not None else '',
}
if not values['entity'] or not values['sso'] or not values['cert']:
    sys.exit('metadata incompleto: entityID, SSO e certificado são obrigatórios')
for key, value in values.items():
    print('%s=%s' % (key, value))
PY
)"
entity="$(printf '%s\n' "$metadata" | sed -n 's/^entity=//p')"
sso="$(printf '%s\n' "$metadata" | sed -n 's/^sso=//p')"
slo="$(printf '%s\n' "$metadata" | sed -n 's/^slo=//p')"
cert="$(printf '%s\n' "$metadata" | sed -n 's/^cert=//p')"

occ app:enable user_saml >/dev/null
provider="$(occ saml:config:create 2>/dev/null | tr -d '[:space:]')"
[[ -n "$provider" ]] || die "falha ao criar configuração SAML"
occ saml:config:set "$provider" \
	"--general-idp0_display_name=UNIFIQUE ONE" \
	"--idp-entityId=$entity" \
	"--idp-singleSignOnService.url=$sso" \
	"--idp-x509cert=$cert" \
	"--sp-entityId=$SP_ENTITY_ID" >/dev/null
if [[ -n "$slo" ]]; then
	occ saml:config:set "$provider" "--idp-singleLogoutService.url=$slo" >/dev/null
fi
occ app:enable user_saml >/dev/null
log "user_saml ativo (provider $provider, SP $SP_ENTITY_ID)"
