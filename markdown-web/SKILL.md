# Skill: markdown-web

Convert web pages, YouTube videos, and RSS/Atom feeds to Markdown using [markitdown](https://github.com/microsoft/markitdown) and Playwright.

## Setup

Run once before first use:

```bash
bash markdown-web/setup.sh
```

## Usage: URLs

```bash
bash markdown-web/url2md.sh <url> [-o output.md] [--js] [--wait MS]
```

| Option      | Description                                                            |
|-------------|------------------------------------------------------------------------|
| `<url>`     | URL to convert (required)                                              |
| `-o FILE`   | Output file (default: stdout)                                          |
| `--js`      | Use Playwright to render JS-heavy pages (SPAs, dynamic content)        |
| `--wait MS` | Milliseconds to wait after page load, only with `--js` (default: 2000) |

### URL examples

Static site (fast, uses curl):
```bash
bash markdown-web/url2md.sh https://example.com -o example.md
```

JS-heavy SPA (uses Playwright to render):
```bash
bash markdown-web/url2md.sh https://app.example.com -o app.md --js
```

JS-heavy with extra wait for lazy content:
```bash
bash markdown-web/url2md.sh https://dashboard.example.com -o dash.md --js --wait 5000
```

## Usage: YouTube

Pass a YouTube URL directly to markitdown (extracts title, metadata, and full transcript):
```bash
markdown-web/.venv/bin/markitdown "https://www.youtube.com/watch?v=VIDEO_ID" -o transcript.md
```

## Usage: RSS/Atom feeds

Pass a feed URL directly to markitdown (extracts all entries as structured Markdown):
```bash
markdown-web/.venv/bin/markitdown "https://feeds.bbci.co.uk/news/world/rss.xml" -o bbc-feed.md
```

## How Claude Code should use this skill

**For URL conversion:**

1. Ensure setup has been run (`bash markdown-web/setup.sh`)
2. Choose the right mode:
   - Most sites: `bash markdown-web/url2md.sh <url> -o output.md` (uses curl, fast)
   - JS-heavy SPAs, dashboards, React/Vue/Angular apps: add `--js` (uses Playwright, slower but accurate)
3. If default mode returns mostly empty or broken content, retry with `--js`

**For YouTube videos:**

1. Pass the YouTube URL directly to markitdown:
   `markdown-web/.venv/bin/markitdown "https://www.youtube.com/watch?v=..." -o transcript.md`
2. Extracts title, description, metadata, and full transcript/captions

**For RSS/Atom feeds:**

1. Pass the feed URL directly to markitdown:
   `markdown-web/.venv/bin/markitdown "https://example.com/feed.xml" -o feed.md`
2. Each entry becomes a Markdown section with title, link, date, and summary

**When to use which mode:**
- Static HTML, blogs, docs, Wikipedia → default (curl)
- React/Vue/Angular apps, SPAs, pages requiring login/JS rendering → `--js`
- YouTube videos → markitdown directly
- RSS/Atom feeds → markitdown directly
- If default mode returns mostly empty or broken content → retry with `--js`

**Do NOT use this skill for local files** -- use `markdown-file` instead.

Note: Requires Python 3.10+.
