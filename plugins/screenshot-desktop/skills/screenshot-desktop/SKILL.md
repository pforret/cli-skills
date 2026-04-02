---
description: Capture desktop, window, or screen region screenshots using native OS tools
---

# screenshot-desktop

Capture desktop/screen screenshots using native OS tools. Supports macOS, Linux, and Windows.

Based on [openai/skills/screenshot](https://github.com/openai/skills/tree/main/skills/.curated/screenshot) (Apache 2.0).

> **Plugin root**: this SKILL.md is at `skills/screenshot-desktop/SKILL.md` inside the plugin. All paths below are relative to the plugin root (two directories up from this file). Resolve them from this file's location before running.

## Setup

Run once before first use:

```bash
bash <plugin-root>/setup.sh
```

On macOS, also run the permission preflight:

```bash
bash <plugin-root>/scripts/ensure_macos_permissions.sh
```

## Usage

```bash
python3 <plugin-root>/scripts/take_screenshot.py [options]
```

### Key options

| Option | Description |
|---|---|
| `--path FILE` | Output file path or directory |
| `--mode default\|temp` | Save to OS default location or temp dir |
| `--format png\|jpg\|bmp` | Image format (default: png) |
| `--region x,y,w,h` | Capture a pixel region |
| `--active-window` | Capture the focused window only |
| `--window-id ID` | Capture a specific window by ID |
| `--app NAME` | macOS: capture windows for an app |
| `--window-name TEXT` | macOS: match window title substring |
| `--list-windows` | macOS: list matching window IDs |
| `--interactive` | Interactive selection (where supported) |

### Examples

```bash
python3 <plugin-root>/scripts/take_screenshot.py --path screen.png
python3 <plugin-root>/scripts/take_screenshot.py --path window.png --active-window
python3 <plugin-root>/scripts/take_screenshot.py --path region.png --region 100,200,800,600
python3 <plugin-root>/scripts/take_screenshot.py --path safari.png --app Safari
python3 <plugin-root>/scripts/take_screenshot.py --mode temp
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File <plugin-root>/scripts/take_screenshot.ps1 -Path screen.png
```

## How Claude Code should use this skill

When the user asks to capture their screen, a window, or an app:

1. Determine `PLUGIN_ROOT` by resolving `../..` from this SKILL.md file's path
2. Ensure macOS permissions if on macOS (`bash $PLUGIN_ROOT/scripts/ensure_macos_permissions.sh`)
3. Determine output path (default to `screenshot.png` in cwd if not specified)
4. Build the `python3 $PLUGIN_ROOT/scripts/take_screenshot.py` command from user-specified options
5. Run via Bash and report the saved file path

**Do NOT use this skill for web page URLs** — use `screenshot-web` instead.

## Platform details

- **macOS**: Uses `screencapture` + Swift helpers. Full-screen captures produce one file per display.
- **Linux**: Auto-selects from `scrot`, `gnome-screenshot`, or ImageMagick `import`.
- **Windows**: Uses PowerShell with .NET System.Drawing/Windows.Forms APIs.
