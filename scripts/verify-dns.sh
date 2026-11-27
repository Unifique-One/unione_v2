#!/usr/bin/env bash
set -euo pipefail

TOKEN_FILE=/opt/unione/secrets/cloudflare.token
ZONE=55be15abb8ba4040efd0ae0e88216c01
export HOSTS="cloud drive files office meet calendar contacts forms board whiteboard notes tasks projects ai id auth mail status admin api"

if [[ ! -s "$TOKEN_FILE" ]]; then
  echo "token file missing" >&2
  exit 1
fi

TOKEN=$(tr -d '\n' < "$TOKEN_FILE")
curl -sS -H "Authorization: Bearer $TOKEN" \
  "https://api.cloudflare.com/client/v4/zones/$ZONE/dns_records?per_page=200" \
  | python3 -c '
import json, os, sys
d = json.load(sys.stdin)
if not d.get("success"):
    print("API error:", d.get("errors"))
    sys.exit(1)
records = {r["name"]: r for r in d.get("result", [])}
hosts = os.environ["HOSTS"].split()
missing = []
for h in hosts:
    name = h + ".csphere.cloud"
    r = records.get(name)
    if not r:
        missing.append(name)
        continue
    rtype = r.get("type", "-")
    content = r.get("content", "-")
    proxied = r.get("proxied")
    print(f"{name:32} {rtype:5} {content:60} proxied={proxied}")
if missing:
    print("MISSING:", ", ".join(missing), file=sys.stderr)
    sys.exit(2)
'
