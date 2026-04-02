---
description: Convert URLs, YouTube videos, and RSS feeds to Markdown
---

# markdown-web

Convert web pages, YouTube videos, and RSS/Atom feeds to Markdown using [markitdown](https://github.com/microsoft/markitdown) and Playwright.

> **Plugin root**: this SKILL.md is at `skills/markdown-web/SKILL.md` inside the plugin. All paths below are relative to the plugin root (two directories up from this file). Resolve them from this file's location before running.

## Setup

Run once before first use:

```bash
bash <plugin-root>/setup.sh
```

## Usage: URLs

```bash
bash <plugin-root>/url2md.sh <url> [-o output.md] [--js] [--wait MS]
```

| Option      | Description                                                            |
|-------------|------------------------------------------------------------------------|
| `<url>`     | URL to convert (required)                                              |
| `-o FILE`   | Output file (default: stdout)                                          |
| `--js`      | Use Playwright to render JS-heavy pages (SPAs, dynamic content)        |
| `--wait MS` | Milliseconds to wait after page load, only with `--js` (default: 2000) |

### URL examples

```bash
bash <plugin-root>/url2md.sh https://example.com -o example.md
bash <plugin-root>/url2md.sh https://app.example.com -o app.md --js
bash <plugin-root>/url2md.sh https://dashboard.example.com -o dash.md --js --wait 5000
```

## Usage: YouTube

Pass a YouTube URL directly to markitdown (extracts title, metadata, and full transcript):

```bash
<plugin-root>/.venv/bin/markitdown "https://www.youtube.com/watch?v=VIDEO_ID" -o transcript.md
```

## Usage: RSS/Atom feeds

Pass a feed URL directly to markitdown (extracts all entries as structured Markdown):

```bash
<plugin-root>/.venv/bin/markitdown "https://feeds.bbci.co.uk/news/world/rss.xml" -o bbc-feed.md
```

## How Claude Code should use this skill

1. Determine `PLUGIN_ROOT` by resolving `../..` from this SKILL.md file's path
2. Ensure setup has been run (`bash $PLUGIN_ROOT/setup.sh`)
3. Choose the right mode:
   - Most sites: `bash $PLUGIN_ROOT/url2md.sh <url> -o output.md` (uses curl, fast)
   - JS-heavy SPAs: add `--js` (uses Playwright, slower but accurate)
   - YouTube videos: `$PLUGIN_ROOT/.venv/bin/markitdown "<youtube-url>" -o transcript.md`
   - RSS/Atom feeds: `$PLUGIN_ROOT/.venv/bin/markitdown "<feed-url>" -o feed.md`
4. If default mode returns mostly empty or broken content, retry with `--js`

**Do NOT use this skill for local files** — use `markdown-file` instead.

Requires Python 3.10+.
