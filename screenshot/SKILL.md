# Skill: screenshot

Take screenshots of web pages using Playwright (headless Chromium).

## Setup

Run once before first use:

```bash
bash screenshot/setup.sh
```

## Usage

Invoke the screenshot script directly:

```bash
python screenshot/screenshot.py <url> <output> [options]
```

### Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| `url` | yes | URL to screenshot (include `https://`) |
| `output` | yes | Output PNG file path |
| `--width` | no | Viewport width in pixels (default: 1280) |
| `--height` | no | Viewport height in pixels (default: 800) |
| `--selector` | no | CSS selector — capture only that element |
| `--full-page` | no | Capture full scrollable page (default: true) |
| `--no-full-page` | no | Capture only the visible viewport |
| `--wait` | no | Extra milliseconds to wait after page load (default: 0) |
| `--timeout` | no | Navigation timeout in milliseconds (default: 30000) |

### Examples

Full-page screenshot:
```bash
python screenshot/screenshot.py https://example.com out.png
```

Mobile viewport:
```bash
python screenshot/screenshot.py https://example.com mobile.png --width 375 --height 812
```

Capture a specific element:
```bash
python screenshot/screenshot.py https://example.com hero.png --selector "#hero"
```

Viewport only (no scroll):
```bash
python screenshot/screenshot.py https://example.com fold.png --no-full-page
```

## How Claude Code should use this skill

When the user asks to take a screenshot of a URL:

1. Ensure setup has been run (`setup.sh`)
2. Determine output path (default to `screenshot.png` in current dir if not specified)
3. Build the command from user-specified options
4. Run the command via Bash
5. Report the saved file path

When the user specifies a device (e.g., "mobile", "tablet"), map to typical viewport sizes:
- mobile: `--width 390 --height 844`
- tablet: `--width 768 --height 1024`
- desktop: `--width 1280 --height 800` (default)
