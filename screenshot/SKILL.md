# Skill: screenshot

Take screenshots of web pages using [shot-scraper](https://github.com/simonw/shot-scraper) (a Playwright-based CLI by Simon Willison).

## Setup

Run once before first use:

```bash
bash screenshot/setup.sh
```

## Usage

```bash
screenshot/.venv/bin/shot-scraper <url> [options]
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

Full-page screenshot (PNG):
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o example.png
```

Mobile viewport:
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o mobile.png -w 390 -h 844
```

Capture a specific element:
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o hero.png -s "#hero"
```

Viewport only (no scroll):
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o fold.png -w 1280 -h 800
```

Retina/HiDPI:
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o retina.png --retina
```

Execute JS before capture (e.g. dismiss a cookie banner):
```bash
screenshot/.venv/bin/shot-scraper https://example.com -o clean.png -j "document.querySelector('.cookie-banner')?.remove()"
```

## How Claude Code should use this skill

When the user asks to take a screenshot of a URL:

1. Ensure setup has been run (`bash screenshot/setup.sh`)
2. Determine output path (default to `screenshot.png` in current dir if not specified)
3. Build the `shot-scraper` command from user-specified options
4. Run via Bash
5. Report the saved file path

When the user specifies a device, map to viewport sizes:
- mobile: `-w 390 -h 844`
- tablet: `-w 768 -h 1024`
- desktop: `-w 1280` (omit `-h` for full page)

For retina/print quality, add `--retina`.
