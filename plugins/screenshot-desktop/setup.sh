#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEM="$(uname)"

echo "==> Verifying screenshot-desktop dependencies..."

if [[ "$SYSTEM" == "Darwin" ]]; then
    if ! command -v swift >/dev/null 2>&1; then
        echo "ERROR: swift not found. Install Xcode command line tools: xcode-select --install" >&2
        exit 1
    fi
    if ! command -v screencapture >/dev/null 2>&1; then
        echo "ERROR: screencapture not found (expected on macOS)" >&2
        exit 1
    fi
    echo "    macOS: swift and screencapture found"
    echo "==> Run permission preflight with:"
    echo "    bash ${SCRIPT_DIR}/scripts/ensure_macos_permissions.sh"
elif [[ "$SYSTEM" == "Linux" ]]; then
    FOUND=""
    command -v scrot >/dev/null 2>&1 && FOUND="scrot"
    command -v gnome-screenshot >/dev/null 2>&1 && FOUND="${FOUND:+$FOUND, }gnome-screenshot"
    command -v import >/dev/null 2>&1 && FOUND="${FOUND:+$FOUND, }import (ImageMagick)"
    if [[ -z "$FOUND" ]]; then
        echo "ERROR: No screenshot tool found. Install one of: scrot, gnome-screenshot, imagemagick" >&2
        exit 1
    fi
    echo "    Linux: found $FOUND"
else
    echo "    Windows: use take_screenshot.ps1 via PowerShell"
fi

echo "==> Setup complete. Test with:"
echo "    python3 ${SCRIPT_DIR}/scripts/take_screenshot.py --path test.png"
