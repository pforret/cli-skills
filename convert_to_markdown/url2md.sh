#!/usr/bin/env bash
set -euo pipefail
#
# url2md.sh — Convert a URL to Markdown
#
# Usage:
#   bash convert_to_markdown/url2md.sh <url> [-o output.md] [--js]
#
# Modes:
#   Default:  curl + markitdown (fast, works for most sites)
#   --js:     Playwright renders the page first (for JS-heavy SPAs)
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"
MARKITDOWN="${VENV_DIR}/bin/markitdown"
SHOT_SCRAPER="${SCRIPT_DIR}/../screenshot/.venv/bin/shot-scraper"

usage() {
    echo "Usage: $0 <url> [-o output.md] [--js] [--wait MS]"
    echo ""
    echo "  <url>         URL to convert to Markdown"
    echo "  -o FILE       Output file (default: stdout)"
    echo "  --js          Use Playwright to render JS-heavy pages"
    echo "  --wait MS     Wait milliseconds after page load (only with --js)"
    exit 1
}

# Parse arguments
URL=""
OUTPUT=""
USE_JS=false
WAIT_MS=2000

while [[ $# -gt 0 ]]; do
    case "$1" in
        -o)       OUTPUT="$2"; shift 2 ;;
        --js)     USE_JS=true; shift ;;
        --wait)   WAIT_MS="$2"; shift 2 ;;
        -h|--help) usage ;;
        -*)       echo "Unknown option: $1" >&2; usage ;;
        *)        URL="$1"; shift ;;
    esac
done

[[ -z "$URL" ]] && { echo "error: URL required" >&2; usage; }

# Check markitdown is installed
if [[ ! -x "$MARKITDOWN" ]]; then
    echo "error: markitdown not found. Run: bash convert_to_markdown/setup.sh" >&2
    exit 1
fi

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

if $USE_JS; then
    # Use Playwright via shot-scraper to get rendered HTML
    if [[ ! -x "$SHOT_SCRAPER" ]]; then
        # Fall back to playwright in own venv
        if "${VENV_DIR}/bin/python" -c "import playwright" 2>/dev/null; then
            echo "==> Rendering with Playwright..." >&2
            "${VENV_DIR}/bin/python" -c "
from playwright.sync_api import sync_playwright
import sys

with sync_playwright() as p:
    browser = p.chromium.launch(headless=True)
    page = browser.new_page()
    page.goto('${URL}', wait_until='networkidle', timeout=30000)
    page.wait_for_timeout(${WAIT_MS})
    html = page.content()
    browser.close()

with open('${TMPDIR}/page.html', 'w') as f:
    f.write(html)
"
        else
            echo "error: --js requires playwright or shot-scraper. Install the screenshot skill or: pip install playwright" >&2
            exit 1
        fi
    else
        echo "==> Rendering with shot-scraper (Playwright)..." >&2
        "$SHOT_SCRAPER" html "$URL" --wait "$WAIT_MS" > "${TMPDIR}/page.html"
    fi
    HTML_FILE="${TMPDIR}/page.html"
else
    # Simple curl fetch
    echo "==> Fetching with curl..." >&2
    curl -sL --max-time 30 \
        -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
        "$URL" > "${TMPDIR}/page.html"
    HTML_FILE="${TMPDIR}/page.html"
fi

# Convert HTML to Markdown
if [[ -n "$OUTPUT" ]]; then
    "$MARKITDOWN" "$HTML_FILE" -o "$OUTPUT"
    echo "saved: $OUTPUT" >&2
else
    "$MARKITDOWN" "$HTML_FILE"
fi
