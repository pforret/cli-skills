#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="${SCRIPT_DIR}/.venv"

# Create virtual environment if it doesn't exist
if [[ ! -d "$VENV_DIR" ]]; then
    echo "==> Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

echo "==> Installing markitdown with all format support..."
"${VENV_DIR}/bin/pip" install -q 'markitdown[all]'

echo "==> Setup complete. Test with:"
echo "    ${VENV_DIR}/bin/markitdown --help"
