---
description: Take web page screenshots by URL using shot-scraper (Playwright)
---

# screenshot-web

Take screenshots of web pages using [shot-scraper](https://github.com/simonw/shot-scraper).

> **Plugin root**: this SKILL.md is at `skills/screenshot-web/SKILL.md` inside the plugin. All paths below (`setup.sh`, `.venv/`) are relative to the plugin root (two directories up from this file). Resolve them from this file's location before running.

## Setup

Run once before first use:

```bash
bash <plugin-root>/setup.sh
```

## Usage

```bash
<plugin-root>/.venv/bin/shot-scraper <url> [options]
```

### Key options

| Option               | Description                                     |
|----------------------|-------------------------------------------------|
| `<url>`              | URL to screenshot (required)                    |
| `-o FILE`            | Output file path (default: auto-named from URL) |
| `-w WIDTH`           | Viewport width in pixels (default: 1280)        |
| `-h HEIGHT`          | Viewport height — omit for full-page capture    |
| `-s SELECTOR`        | CSS selector — capture only that element        |
| `--selector-all SEL` | Capture all matching elements as separate files |
| `-j JS`              | JavaScript to execute before screenshot         |
| `--wait MS`          | Milliseconds to wait after page load            |
| `--retina`           | 2x pixel density (HiDPI)                        |
| `--quality N`        | JPEG quality 0-100 (use with `-o file.jpg`)     |

### Examples

```bash
<plugin-root>/.venv/bin/shot-scraper https://example.com -o example.png
<plugin-root>/.venv/bin/shot-scraper https://example.com -o mobile.png -w 390 -h 844
<plugin-root>/.venv/bin/shot-scraper https://example.com -o hero.png -s "#hero"
<plugin-root>/.venv/bin/shot-scraper https://example.com -o retina.png --retina
<plugin-root>/.venv/bin/shot-scraper https://example.com -o clean.png -j "document.querySelector('.cookie-banner')?.remove()"
```

## How Claude Code should use this skill

When the user asks to take a screenshot of a URL:

1. Determine `PLUGIN_ROOT` by resolving `../..` from this SKILL.md file's path
2. Ensure setup has been run (`bash $PLUGIN_ROOT/setup.sh`)
3. Determine output path (default to `screenshot.png` in cwd if not specified)
4. Build the `$PLUGIN_ROOT/.venv/bin/shot-scraper` command from user-specified options
5. Run via Bash and report the saved file path

Device viewport mappings:
- mobile: `-w 390 -h 844`
- tablet: `-w 768 -h 1024`
- desktop: `-w 1280` (omit `-h` for full page)

For retina/print quality, add `--retina`.
