#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Python dependencies..."
pip install -r "${SCRIPT_DIR}/requirements.txt"

echo "==> Installing Playwright browsers (Chromium only)..."
playwright install chromium

echo "==> Installing Playwright system dependencies (may need sudo on Linux)..."
playwright install-deps chromium 2>/dev/null || true

chmod +x "${SCRIPT_DIR}/screenshot.py"

echo "==> Setup complete. Test with:"
echo "    python ${SCRIPT_DIR}/screenshot.py https://example.com out.png"
