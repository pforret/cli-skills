# Skill: screenshot-desktop

Capture desktop/screen screenshots using native OS tools. Supports macOS, Linux, and Windows.

Based on [openai/skills/screenshot](https://github.com/openai/skills/tree/main/skills/.curated/screenshot) (Apache 2.0).

## Setup

Run once before first use:

```bash
bash screenshot-desktop/setup.sh
```

On macOS, also run the permission preflight:

```bash
bash screenshot-desktop/scripts/ensure_macos_permissions.sh
```

## Usage

```bash
python3 screenshot-desktop/scripts/take_screenshot.py [options]
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

Full screen:
```bash
python3 screenshot-desktop/scripts/take_screenshot.py --path screen.png
```

Active window:
```bash
python3 screenshot-desktop/scripts/take_screenshot.py --path window.png --active-window
```

Pixel region:
```bash
python3 screenshot-desktop/scripts/take_screenshot.py --path region.png --region 100,200,800,600
```

macOS app capture:
```bash
python3 screenshot-desktop/scripts/take_screenshot.py --path safari.png --app Safari
```

Save to temp dir (for inspection):
```bash
python3 screenshot-desktop/scripts/take_screenshot.py --mode temp
```

### Windows

Use the PowerShell script directly:
```powershell
powershell -ExecutionPolicy Bypass -File screenshot-desktop/scripts/take_screenshot.ps1 -Path screen.png
```

## How Claude Code should use this skill

When the user asks to capture their screen, a window, or an app:

1. Ensure macOS permissions if on macOS (`bash screenshot-desktop/scripts/ensure_macos_permissions.sh`)
2. Determine output path (default to `screenshot.png` in current dir if not specified)
3. Build the `take_screenshot.py` command from user-specified options
4. Run via Bash
5. Report the saved file path

**Do NOT use this skill for web page URLs** -- use `screenshot-web` instead.
This skill is for capturing what is visible on the physical display.

## Platform details

- **macOS**: Uses `screencapture` + Swift helpers. Full-screen captures produce one file per display.
- **Linux**: Auto-selects from `scrot`, `gnome-screenshot`, or ImageMagick `import`.
- **Windows**: Uses PowerShell with .NET System.Drawing/Windows.Forms APIs.
