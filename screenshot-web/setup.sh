#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"

# Create virtual environment if it doesn't exist
if [[ ! -d "$VENV_DIR" ]]; then
    echo "==> Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

echo "==> Installing shot-scraper..."
"${VENV_DIR}/bin/pip" install -q shot-scraper

echo "==> Installing Playwright browser (Chromium)..."
"${VENV_DIR}/bin/shot-scraper" install

echo "==> Setup complete. Test with:"
echo "    ${VENV_DIR}/bin/shot-scraper https://example.com -o test.png"
