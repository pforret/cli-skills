#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"
IMAGE_NAME="cliskills/screenshot-web"

# Check for --docker flag
if [[ "${1:-}" == "--docker" ]]; then
    echo "==> Building Docker image..."
    docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
    echo "==> Done. Test with:"
    echo "    bash ${SCRIPT_DIR}/run.sh https://example.com -o test.png"
    exit 0
fi

# Default: venv setup
if [[ ! -d "$VENV_DIR" ]]; then
    echo "==> Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

echo "==> Installing shot-scraper..."
"${VENV_DIR}/bin/pip" install -q shot-scraper

echo "==> Installing Playwright browser (Chromium)..."
"${VENV_DIR}/bin/shot-scraper" install

echo "==> Setup complete. Test with:"
echo "    bash ${SCRIPT_DIR}/run.sh https://example.com -o test.png"
echo ""
echo "    Tip: run 'bash setup.sh --docker' to use Docker instead of venv"
