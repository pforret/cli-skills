---
description: Convert local files (PDF, DOCX, PPTX, XLSX, etc.) to Markdown
---

# markdown-file

Convert local files to Markdown using [markitdown](https://github.com/microsoft/markitdown) by Microsoft.

> **Plugin root**: this SKILL.md is at `skills/markdown-file/SKILL.md` inside the plugin. All paths below are relative to the plugin root (two directories up from this file). Resolve them from this file's location before running.

## Setup

Run once before first use:

```bash
bash <plugin-root>/setup.sh
```

## Supported formats

PDF, Word (.docx), PowerPoint (.pptx), Excel (.xlsx), HTML, CSV, JSON, XML, images (EXIF/OCR), audio (transcription), EPUB, ZIP archives.

## Usage

```bash
<plugin-root>/.venv/bin/markitdown <input-file> -o <output.md>
```

Or pipe to stdout:

```bash
<plugin-root>/.venv/bin/markitdown <input-file>
```

### Examples

```bash
<plugin-root>/.venv/bin/markitdown report.pdf -o report.md
<plugin-root>/.venv/bin/markitdown slides.pptx -o slides.md
<plugin-root>/.venv/bin/markitdown data.xlsx -o data.md
<plugin-root>/.venv/bin/markitdown photo.jpg -o photo.md
```

## Docker alternative

No Python/venv needed — just Docker:

```bash
bash <plugin-root>/run.sh report.pdf -o report.md
```

The `run.sh` wrapper auto-detects: uses Docker if available (builds image on first run), falls back to venv. You can also run Docker directly:

```bash
docker run --rm -v "$(pwd):/work" cliskills/markdown-file report.pdf -o report.md
```

Build the image once with: `docker build -t cliskills/markdown-file <plugin-root>/`

## How Claude Code should use this skill

1. Determine `PLUGIN_ROOT` by resolving `../..` from this SKILL.md file's path
2. **Preferred**: use `bash $PLUGIN_ROOT/run.sh <input> [options]` — auto-detects Docker or venv
3. **Fallback**: ensure setup has been run (`bash $PLUGIN_ROOT/setup.sh`) and use `$PLUGIN_ROOT/.venv/bin/markitdown` directly
4. Read the resulting `.md` if the user wants to see the content

**Do NOT use this skill for URLs** — use `markdown-web` instead.

Requires Python 3.10+ (venv mode) or Docker.
