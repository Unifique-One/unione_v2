#!/usr/bin/env bash
set -uo pipefail

HOSTS="cloud drive files office meet calendar contacts forms board whiteboard notes tasks projects ai id auth mail status admin api"
CONTAINERS="unione-traefik unione-cloudflared unione-nextcloud unione-postgres unione-redis unione-collabora unione-coturn unione-status"
fail=0

echo "UNIFIQUE ONE - stack verification"
echo

echo "Containers:"
for c in $CONTAINERS; do
  if podman container exists "$c" && podman ps --format '{{.Names}}' | grep -Fxq "$c"; then
    printf '  [OK]   %s running\n' "$c"
  else
    printf '  [FAIL] %s not running\n' "$c"
    fail=$((fail + 1))
  fi
done

echo
echo "Local HTTP routes via Traefik (host header on 127.0.0.1:8080):"
for h in $HOSTS; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -H "Host: $h.csphere.cloud" http://127.0.0.1:8080/ 2>/dev/null || true)
  case "$code" in
    2??|3??|401|403)
      printf '  [OK]   %-24s HTTP %s\n' "$h.csphere.cloud" "$code"
      ;;
    404)
      if [[ "$h" == "api" ]]; then
        printf '  [OK]   %-24s HTTP %s (API root sem rota padrão)\n' "$h.csphere.cloud" "$code"
      else
        printf '  [FAIL] %-24s HTTP %s\n' "$h.csphere.cloud" "$code"
        fail=$((fail + 1))
      fi
      ;;
    *)
      printf '  [FAIL] %-24s HTTP %s\n' "$h.csphere.cloud" "${code:-000}"
      fail=$((fail + 1))
      ;;
  esac
done

echo
echo "Tunnel:"
if [[ -s /opt/unione/secrets/cloudflare.tunnel.id ]]; then
  id=$(tr -d '\n' < /opt/unione/secrets/cloudflare.tunnel.id)
  printf '  [OK]   tunnel id present: %s\n' "$id"
else
  printf '  [FAIL] tunnel id missing\n'
  fail=$((fail + 1))
fi
if [[ -s /root/.cloudflared/"$id".json ]]; then
  echo '  [OK]   tunnel credentials file present'
else
  echo '  [FAIL] tunnel credentials file missing'
  fail=$((fail + 1))
fi
if [[ -s /etc/unione/cloudflared/tunnel.env ]]; then
  echo '  [OK]   tunnel token env present'
else
  echo '  [FAIL] tunnel token env missing'
  fail=$((fail + 1))
fi

echo
echo "Failed checks: $fail"
exit "$fail"
