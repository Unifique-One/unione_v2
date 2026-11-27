#!/usr/bin/env bash
# UNIFIQUE ONE - read-only verification of Nextcloud branding.
# Does not change any configuration and does not write any file.
set -euo pipefail

NC_CONTAINER="unione-nextcloud"
BRANDING_MOUNT="/mnt/branding"

NAME="UNIFIQUE ONE"
SLOGAN="Plataforma corporativa unificada"
LOGO="${BRANDING_MOUNT}/assets/logos/unifique-one-light.svg"
FAVICON="${BRANDING_MOUNT}/assets/favicons/favicon-32x32-01e518e661.png"
ICON="${BRANDING_MOUNT}/assets/favicons/apple-touch-icon-c435f4f4da.png"
COLOR="#212492"
FONT="Plus Jakarta Sans"

EXPECTED_APPS=(files photos calendar contacts spreed deck notes tasks forms whiteboard office mail assistant)

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
check_theming name "$NAME"
check_theming slogan "$SLOGAN"
check_theming logo "$LOGO"
check_theming favicon "$FAVICON"
check_theming icon "$ICON"
check_theming color "$COLOR"
check_theming font "$FONT"

background_value="$(occ_read config:app:get theming background || true)"
if [ -z "$background_value" ]; then
  skip "theming.background is not configured (optional asset)"
else
  ok "theming.background = '${background_value}'"
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
