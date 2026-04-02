# Skill: markdown-file

Convert local files to Markdown using [markitdown](https://github.com/microsoft/markitdown) by Microsoft.

## Setup

Run once before first use:

```bash
bash markdown-file/setup.sh
```

## Supported formats

PDF, Word (.docx), PowerPoint (.pptx), Excel (.xlsx), HTML, CSV, JSON, XML, images (EXIF/OCR), audio (transcription), EPUB, ZIP archives.

## Usage

```bash
markdown-file/.venv/bin/markitdown <input-file> -o <output.md>
```

Or pipe to stdout:
```bash
markdown-file/.venv/bin/markitdown <input-file>
```

### Examples

```bash
markdown-file/.venv/bin/markitdown report.pdf -o report.md
markdown-file/.venv/bin/markitdown slides.pptx -o slides.md
markdown-file/.venv/bin/markitdown data.xlsx -o data.md
markdown-file/.venv/bin/markitdown photo.jpg -o photo.md
```

## How Claude Code should use this skill

1. Ensure setup has been run (`bash markdown-file/setup.sh`)
2. Run `markdown-file/.venv/bin/markitdown <input> -o <output>`
3. Read the resulting `.md` if the user wants to see the content

**Do NOT use this skill for URLs** -- use `markdown-web` instead.

Note: Requires Python 3.10+.
