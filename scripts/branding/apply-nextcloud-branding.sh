#!/usr/bin/env bash
# UNIFIQUE ONE - idempotent Nextcloud branding/application script.
#
# Source of truth for all visual values:
#   /opt/unione/pt/unione.md  (official identity: colors, typography, logo)
#   /opt/unione/pt/domain.md  (deployment/branding scope)
#   https://unifique.com.br/  (official favicon/icon set, via fetch-official-icons.py)
#
# Assumption: /opt/unione/branding is mounted read-only into the container at
# /mnt/branding, and the Nextcloud container is named "unione-nextcloud".
#
# This script NEVER edits Nextcloud core files and NEVER removes legal notices,
# license texts, security warnings or technical credits.
set -euo pipefail

NC_CONTAINER="unione-nextcloud"
LOG_FILE="/opt/unione/scripts/branding/apply.log"
BRANDING_MOUNT="/mnt/branding"
# Documented extension/staging location (NOT Nextcloud core):
CUSTOM_THEME_CSS_DIR="/var/www/html/custom_apps/unifique-theme/css"

NAME="UNIFIQUE ONE"
PRODUCT_NAME="UNIFIQUE ONE"
SLOGAN="Plataforma corporativa unificada"
LOGO="${BRANDING_MOUNT}/assets/logos/unifique-one-light.svg"
FAVICON="${BRANDING_MOUNT}/assets/favicons/favicon-cd754f5597.ico"
ICON="${BRANDING_MOUNT}/assets/favicons/apple-touch-icon-c435f4f4da.png"
BACKGROUND_COLOR="#F6F8FC"
COLOR="#212492"
FONT="Plus Jakarta Sans"

EXPECTED_APPS=(files photos calendar contacts spreed deck notes tasks forms whiteboard office mail assistant)

touch "$LOG_FILE"

log() {
  printf '%s [INFO] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*" | tee -a "$LOG_FILE"
}

warn() {
  printf '%s [WARN] %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*" | tee -a "$LOG_FILE" >&2
}

# All occ mutations go through the documented unprivileged-web-user form.
occ() {
  podman exec -u www-data "$NC_CONTAINER" php occ "$@" >>"$LOG_FILE" 2>&1
}

# Read-only occ call: stdout is captured, stderr is appended to the log.
occ_output() {
  podman exec -u www-data "$NC_CONTAINER" php occ "$@" 2>>"$LOG_FILE"
}

container_is_running() {
  local names
  names="$(podman ps --format '{{.Names}}' 2>>"$LOG_FILE")" || return 1
  printf '%s\n' "$names" | grep -Fxq "$NC_CONTAINER"
}

set_theming_value() {
  local key="$1" value="$2" current=""
  current="$(occ_output config:app:get theming "$key" || true)"
  if [ "$current" = "$value" ]; then
    log "theming.${key} already '${value}' (unchanged)"
    return 0
  fi
  if occ config:app:set theming "$key" --value="$value"; then
    log "theming.${key} set to '${value}'"
  else
    warn "could not set theming.${key} to '${value}' (details in ${LOG_FILE})"
  fi
}

# Nextcloud 34 stores uploaded theme images/colors through theming:config;
# config:app:set alone does not register the MIME type and is ignored by the UI.
theming_config_set() {
  local key="$1" value="$2"
  if occ theming:config "$key" "$value"; then
    log "theming:config ${key} set to '${value}'"
  else
    warn "could not set theming:config ${key} to '${value}' (details in ${LOG_FILE})"
  fi
}

app_list=""
app_is_enabled() {
  printf '%s\n' "$app_list" | awk -v app="$1" '
    /^[[:space:]]*Enabled:/  { in_enabled = 1; next }
    /^[[:space:]]*Disabled:/ { in_enabled = 0 }
    in_enabled && $1 == "-" && $2 == app ":" { found = 1 }
    END { exit(found ? 0 : 1) }
  '
}

app_is_known() {
  printf '%s\n' "$app_list" | awk -v app="$1" '
    $1 == "-" && $2 == app ":" { found = 1 }
    END { exit(found ? 0 : 1) }
  '
}

log "=== UNIFIQUE ONE Nextcloud branding apply: START ==="
log "Preserving all legal/license notices, security warnings and technical credits; no Nextcloud core file is edited."

if ! container_is_running; then
  warn "container '${NC_CONTAINER}' is not running; aborting"
  exit 1
fi
log "container '${NC_CONTAINER}' is running"

# --- Theming -----------------------------------------------------------------
log "Applying theming with: podman exec -u www-data ${NC_CONTAINER} php occ ..."
theming_config_set name "$NAME"
theming_config_set slogan "$SLOGAN"
theming_config_set primary_color "$COLOR"
theming_config_set color "$COLOR"
theming_config_set background_color "$BACKGROUND_COLOR"
theming_config_set background backgroundColor
theming_config_set logo "$LOGO"
theming_config_set logoheader "$LOGO"
theming_config_set favicon "$FAVICON"
# Keys not exposed by theming:config are set through the app configuration.
set_theming_value productName "$PRODUCT_NAME"
set_theming_value icon "$ICON"
set_theming_value font "$FONT"

# --- Apps --------------------------------------------------------------------
app_list="$(occ_output app:list || true)"
if [ -z "$app_list" ]; then
  warn "could not read 'occ app:list'; attempting each app:enable individually"
fi

for app in "${EXPECTED_APPS[@]}"; do
  if [ -n "$app_list" ] && app_is_enabled "$app"; then
    log "app '${app}' already enabled (unchanged)"
    continue
  fi
  if [ -n "$app_list" ] && ! app_is_known "$app"; then
    warn "app '${app}' is not installed in this Nextcloud instance; skipping"
    continue
  fi
  if occ app:enable "$app"; then
    log "app '${app}' enabled"
  else
    warn "app '${app}' could not be enabled; continuing with the remaining apps"
  fi
done

# --- Default application -----------------------------------------------------
default_app="$(occ_output config:system:get defaultapp || true)"
if [ "$default_app" = "files" ]; then
  log "defaultapp already 'files' (unchanged)"
elif occ config:system:set defaultapp --value=files; then
  log "defaultapp set to 'files'"
else
  warn "could not set defaultapp to 'files' (details in ${LOG_FILE})"
fi

# --- Custom theme CSS (staging only; core is never modified) -----------------
if podman exec -u www-data "$NC_CONTAINER" sh -c \
    'for f in /mnt/branding/themes/*.css; do [ -f "$f" ] && exit 0; done; exit 1' \
    >>"$LOG_FILE" 2>&1; then
  if podman exec "$NC_CONTAINER" sh -c \
      'mkdir -p "$1" && cp -f /mnt/branding/themes/*.css "$1"/' \
      sh "$CUSTOM_THEME_CSS_DIR" >>"$LOG_FILE" 2>&1; then
    log "custom theme CSS staged at ${CUSTOM_THEME_CSS_DIR} (container path); Nextcloud core untouched"
  else
    warn "could not stage custom theme CSS at ${CUSTOM_THEME_CSS_DIR}; continuing"
  fi
else
  warn "no CSS files found in ${BRANDING_MOUNT}/themes; skipping custom theme CSS staging"
fi

log "=== UNIFIQUE ONE Nextcloud branding apply: END ==="
