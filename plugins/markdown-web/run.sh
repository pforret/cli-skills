#!/usr/bin/env bash
set -euo pipefail
#
# run.sh — Run markitdown (for URLs/YouTube/RSS) via Docker or venv (auto-detects)
#
# Usage: bash run.sh <url> [-o output.md]
# Example: bash run.sh "https://www.youtube.com/watch?v=dQw4w9WgXcQ" -o video.md
#
# For web pages with --js flag, use url2md.sh instead (or docker run with url2md entrypoint)
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="cliskills/markdown-web"

# Prefer Docker if available and image exists (or can be built)
if command -v docker &>/dev/null && docker info &>/dev/null 2>&1; then
    if ! docker image inspect "$IMAGE_NAME" &>/dev/null; then
        echo "==> Building Docker image (first run only)..." >&2
        docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
    fi
    docker run --rm -v "$(pwd):/work" "$IMAGE_NAME" "$@"
elif [[ -x "${SCRIPT_DIR}/.venv/bin/markitdown" ]]; then
    "${SCRIPT_DIR}/.venv/bin/markitdown" "$@"
else
    echo "error: neither Docker nor venv found. Run 'bash setup.sh' first." >&2
    exit 1
fi
