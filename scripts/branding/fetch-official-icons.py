#!/usr/bin/env python3

import hashlib
import json
import re
import urllib.request
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urljoin, urlparse, unquote

BASE_URL = "https://unifique.com.br/"
DOMAIN = "unifique.com.br"

ROOT = Path("/opt/unione/branding/assets")
FAVICONS = ROOT / "favicons"
ICONS = ROOT / "icons"

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (X11; Linux x86_64) "
        "AppleWebKit/537.36 Chrome/130.0.0.0 Safari/537.36"
    ),
    "Referer": BASE_URL,
}

KEYWORDS = re.compile(
    r"favicon|apple-touch|touch-icon|mask-icon|"
    r"(^|[/_-])icon([/_\-.]|$)|msapplication",
    re.I,
)

class AssetParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.assets = set()
        self.stylesheets = set()
        self.manifests = set()

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)

        if tag == "link":
            href = attrs.get("href", "")
            rel = attrs.get("rel", "").lower()

            if href and "icon" in rel:
                self.assets.add(href)

            if href and "stylesheet" in rel:
                self.stylesheets.add(href)

            if href and "manifest" in rel:
                self.manifests.add(href)

        if tag in ("img", "source"):
            src = attrs.get("src", "")
            alt = attrs.get("alt", "")
            if src and (KEYWORDS.search(src) or KEYWORDS.search(alt)):
                self.assets.add(src)

        if tag == "meta":
            name = attrs.get("name", "").lower()
            content = attrs.get("content", "")

            if name in (
                "msapplication-tileimage",
                "msapplication-config",
            ) and content:
                self.assets.add(content)


def fetch(url):
    request = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read(), response.headers.get("Content-Type", "")


def resolve(url):
    absolute = urljoin(BASE_URL, url)
    parsed = urlparse(absolute)

    if parsed.scheme not in ("http", "https"):
        return None

    if parsed.hostname != DOMAIN:
        return None

    return absolute


def save_asset(url, category):
    parsed = urlparse(url)
    filename = Path(unquote(parsed.path)).name or "asset"

    digest = hashlib.sha256(url.encode()).hexdigest()[:10]
    filename = f"{Path(filename).stem}-{digest}{Path(filename).suffix}"

    directory = FAVICONS if category == "favicon" else ICONS
    destination = directory / filename

    try:
        content, content_type = fetch(url)

        if not content:
            raise ValueError("Arquivo vazio")

        destination.write_bytes(content)

        print(f"[OK] {category}: {destination} ({len(content)} bytes)")
        return True

    except Exception as error:
        print(f"[ERRO] {url}: {error}")
        return False


def main():
    FAVICONS.mkdir(parents=True, exist_ok=True)
    ICONS.mkdir(parents=True, exist_ok=True)

    html, _ = fetch(BASE_URL)
    parser = AssetParser()
    parser.feed(html.decode("utf-8", errors="replace"))

    assets = set(parser.assets)

    for stylesheet in parser.stylesheets:
        css_url = resolve(stylesheet)
        if not css_url:
            continue

        try:
            css, _ = fetch(css_url)
            css = css.decode("utf-8", errors="replace")

            for reference in re.findall(
                r"url\(['\"]?([^'\")]+)",
                css,
                flags=re.I,
            ):
                if KEYWORDS.search(reference):
                    assets.add(urljoin(css_url, reference))

        except Exception as error:
            print(f"[CSS] Não foi possível ler {css_url}: {error}")

    for manifest in parser.manifests:
        manifest_url = resolve(manifest)
        if not manifest_url:
            continue

        try:
            content, _ = fetch(manifest_url)
            data = json.loads(content)

            for item in data.get("icons", []):
                if item.get("src"):
                    assets.add(urljoin(manifest_url, item["src"]))

        except Exception as error:
            print(f"[MANIFEST] {manifest_url}: {error}")

    downloaded = 0

    for asset in sorted(assets):
        url = resolve(asset)

        if not url:
            continue

        path = urlparse(url).path.lower()

        category = (
            "favicon"
            if "favicon" in path
            or "apple-touch" in path
            or "touch-icon" in path
            or "mask-icon" in path
            else "icon"
        )

        if save_asset(url, category):
            downloaded += 1

    print()
    print(f"Total de arquivos baixados: {downloaded}")
    print(f"Diretório: {ROOT}")


if __name__ == "__main__":
    main()
