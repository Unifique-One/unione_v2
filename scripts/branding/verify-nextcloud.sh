#!/usr/bin/env bash
# UNIFIQUE ONE - read-only verification of Nextcloud branding.
# Does not change any configuration and does not write any file.
set -euo pipefail

NC_CONTAINER="unione-nextcloud"
BRANDING_MOUNT="/mnt/branding"

NAME="UNIFIQUE ONE"
PRODUCT_NAME="UNIFIQUE ONE"
SLOGAN=""
LOGO="${BRANDING_MOUNT}/assets/logos/unifique-one-light.svg"
FAVICON="${BRANDING_MOUNT}/assets/favicons/favicon-cd754f5597.ico"
ICON="${BRANDING_MOUNT}/assets/favicons/apple-touch-icon-c435f4f4da.png"
COLOR="#212492"
BACKGROUND_COLOR="#F6F8FC"
FONT="Plus Jakarta Sans"
CALENDAR_USER="unione@csphere.cloud"
CALENDAR_USER_EMAIL="unione@csphere.cloud"

EXPECTED_APPS=(files photos calendar contacts spreed deck notes tasks forms whiteboard office mail assistant unifique_branding)
DISABLE_APPS=(firstrunwizard nextcloud_announcements support survey_client)
OFFICIAL_URL='https://unifique.com.br'
THEME_ID='unifique'

failures=0

ok()   { printf '  [OK]   %s\n' "$*"; }
bad()  { printf '  [FAIL] %s\n' "$*"; failures=$((failures + 1)); }
skip() { printf '  [SKIP] %s\n' "$*"; }

occ_read() {
  podman exec -u www-data "$NC_CONTAINER" php occ "$@" 2>/dev/null
}

check_theming() {
  local key="$1" expected="$2" actual
  actual="$(occ_read config:app:get theming "$key" || true)"
  if [ "$actual" = "$expected" ]; then
    ok "theming.${key} = '${expected}'"
  else
    bad "theming.${key}: expected '${expected}', got '${actual:-<unset>}'"
  fi
}

# Nextcloud 34 exposes uploaded images/colors only through theming:config.
theming_config_output="$(occ_read theming:config || true)"
check_theming_config() {
  local key="$1" expected="$2" actual
  actual="$(printf '%s\n' "$theming_config_output" | awk -v k="$key" '
    $1 == "-" && $2 == k ":" { $1=""; $2=""; sub(/^[[:space:]]+/, ""); print; exit }
  ')"
  if [ "$actual" = "$expected" ]; then
    ok "theming:config ${key} = '${expected}'"
  else
    bad "theming:config ${key}: expected '${expected}', got '${actual:-<unset>}'"
  fi
}

check_asset() {
  local path="$1"
  if podman exec "$NC_CONTAINER" sh -c '[ -f "$1" ]' sh "$path" 2>/dev/null; then
    ok "official asset present: ${path}"
  else
    bad "official asset missing: ${path}"
  fi
}

printf 'UNIFIQUE ONE - Nextcloud branding verification\n'
printf 'Container: %s\n' "$NC_CONTAINER"

printf '\nContainer and runtime:\n'
running_names="$(podman ps --format '{{.Names}}' 2>/dev/null || true)"
if printf '%s\n' "$running_names" | grep -Fxq "$NC_CONTAINER"; then
  ok "container is running"
else
  bad "container is not running"
  printf '\nResult: FAIL (container unavailable)\n'
  exit 1
fi

status_output="$(occ_read status || true)"
if [ -n "$status_output" ]; then
  ok "occ status succeeds"
  nc_version="$(printf '%s\n' "$status_output" | awk '/^[[:space:]]*-?[[:space:]]*version:/ {print $NF; exit}')"
  if [ -n "$nc_version" ]; then
    printf '         Nextcloud version: %s\n' "$nc_version"
  fi
else
  bad "occ status failed"
fi

printf '\nTheming:\n'
check_theming_config name "$NAME"
check_theming_config slogan "$SLOGAN"
check_theming_config primary_color "$COLOR"
check_theming_config color "$COLOR"
check_theming_config background_color "$BACKGROUND_COLOR"
check_theming_config background backgroundColor
check_theming_config logo 'image/svg+xml'
check_theming_config logoheader 'image/svg+xml'
check_theming_config favicon 'image/vnd.microsoft.icon'
check_theming productName "$PRODUCT_NAME"
check_theming icon "$ICON"
check_theming font "$FONT"

check_asset "$LOGO"
check_asset "$FAVICON"
check_asset "$ICON"

printf '\nExternal links and official theme:\n'
check_theming_config url "$OFFICIAL_URL"
check_theming_config imprintUrl "$OFFICIAL_URL"
check_theming_config privacyUrl "$OFFICIAL_URL"
check_theming docBaseUrl "$OFFICIAL_URL"
system_theme="$(occ_read config:system:get theme || true)"
if [ "$system_theme" = "$THEME_ID" ]; then
  ok "system theme = '${THEME_ID}' (light/dark selectable)"
else
  bad "system theme: expected '${THEME_ID}', got '${system_theme:-<unset>}'"
fi
for f in defaults.php core/css/server.css core/css/guest.css; do
  check_asset "/var/www/html/themes/${THEME_ID}/$f"
done
for f in appinfo/info.xml js/branding.js; do
  check_asset "/var/www/html/apps/unifique_branding/$f"
done

printf '\nCalendar identity:\n'
calendar_email="$(occ_read user:setting "$CALENDAR_USER" settings email || true)"
if [ "$calendar_email" = "$CALENDAR_USER_EMAIL" ]; then
  ok "calendar email for '${CALENDAR_USER}' = '${CALENDAR_USER_EMAIL}'"
else
  bad "calendar email for '${CALENDAR_USER}': expected '${CALENDAR_USER_EMAIL}', got '${calendar_email:-<unset>}'"
fi

printf '\nEnabled apps:\n'
app_list="$(occ_read app:list || true)"
enabled_apps="$(printf '%s\n' "$app_list" | awk '
  /^[[:space:]]*Enabled:/  { in_enabled = 1; next }
  /^[[:space:]]*Disabled:/ { in_enabled = 0 }
  in_enabled && $1 == "-" { sub(/:$/, "", $2); print $2 }
')"
for app in "${EXPECTED_APPS[@]}"; do
  if printf '%s\n' "$enabled_apps" | grep -Fxq "$app"; then
    ok "app '${app}' is enabled"
  else
    bad "app '${app}' is NOT enabled (missing or disabled)"
  fi
done

printf '\nDisabled marketing apps:\n'
for app in "${DISABLE_APPS[@]}"; do
  if printf '%s\n' "$app_list" | awk -v a="$app" '
    /^[[:space:]]*Disabled:/ { in_disabled = 1; next }
    /^[[:space:]]*Enabled:/  { in_disabled = 0 }
    in_disabled && $1 == "-" && $2 == a ":" { found = 1 }
    END { exit(found ? 0 : 1) }
  '; then
    ok "app '${app}' is disabled"
  else
    bad "app '${app}' is NOT disabled"
  fi
done

default_app="$(occ_read config:system:get defaultapp || true)"
printf '\nDefault application:\n'
if [ "$default_app" = "files" ]; then
  ok "defaultapp = 'files'"
else
  bad "defaultapp: expected 'files', got '${default_app:-<unset>}'"
fi

printf '\nSummary: %d failed check(s)\n' "$failures"
if [ "$failures" -eq 0 ]; then
  printf 'Result: PASS\n'
  exit 0
fi
printf 'Result: FAIL\n'
exit 1
