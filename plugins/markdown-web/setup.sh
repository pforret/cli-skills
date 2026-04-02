#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"
IMAGE_NAME="cliskills/markdown-web"

# Check for --docker flag
if [[ "${1:-}" == "--docker" ]]; then
    echo "==> Building Docker image..."
    docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
    echo "==> Done. Test with:"
    echo "    bash ${SCRIPT_DIR}/run.sh https://example.com -o test.md"
    exit 0
fi

# Default: venv setup
if [[ ! -d "$VENV_DIR" ]]; then
    echo "==> Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

echo "==> Installing markitdown with all format support..."
"${VENV_DIR}/bin/pip" install -q 'markitdown[all]'

echo "==> Setup complete. Test with:"
echo "    bash ${SCRIPT_DIR}/run.sh https://example.com -o test.md"
echo ""
echo "    Tip: run 'bash setup.sh --docker' to use Docker instead of venv"
