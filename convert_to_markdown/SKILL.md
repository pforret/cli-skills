# Skill: convert_to_markdown

Convert documents and web pages to Markdown using [markitdown](https://github.com/microsoft/markitdown) by Microsoft.

## Setup

Run once before first use:

```bash
bash convert_to_markdown/setup.sh
```

## Supported inputs

**Files:** PDF, Word (.docx), PowerPoint (.pptx), Excel (.xlsx), HTML, CSV, JSON, XML, images (EXIF/OCR), audio (transcription), EPUB, ZIP archives.

**URLs:** Any web page — static sites via curl, JS-heavy SPAs via Playwright.

**YouTube:** Pass a YouTube URL directly to markitdown — it extracts the video title, metadata, and full transcript (captions) as Markdown. No download needed.

**RSS/Atom feeds:** Pass an RSS or Atom feed URL to markitdown — it converts each feed entry (title, link, date, summary) into structured Markdown. Useful for monitoring news sources or aggregating content.

## Usage: files

```bash
convert_to_markdown/.venv/bin/markitdown <input-file> -o <output.md>
```

Or pipe to stdout:
```bash
convert_to_markdown/.venv/bin/markitdown <input-file>
```

### File examples

```bash
convert_to_markdown/.venv/bin/markitdown report.pdf -o report.md
convert_to_markdown/.venv/bin/markitdown slides.pptx -o slides.md
convert_to_markdown/.venv/bin/markitdown data.xlsx -o data.md
```

YouTube video (extracts title, metadata, and full transcript):
```bash
convert_to_markdown/.venv/bin/markitdown "https://www.youtube.com/watch?v=VIDEO_ID" -o transcript.md
```

RSS/Atom feed (extracts all entries as structured Markdown):
```bash
convert_to_markdown/.venv/bin/markitdown "https://feeds.bbci.co.uk/news/world/rss.xml" -o bbc-feed.md
```

## Usage: URLs

```bash
bash convert_to_markdown/url2md.sh <url> [-o output.md] [--js] [--wait MS]
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
bash convert_to_markdown/url2md.sh https://example.com -o example.md
```

JS-heavy SPA (uses Playwright to render):
```bash
bash convert_to_markdown/url2md.sh https://app.example.com -o app.md --js
```

JS-heavy with extra wait for lazy content:
```bash
bash convert_to_markdown/url2md.sh https://dashboard.example.com -o dash.md --js --wait 5000
```

## How Claude Code should use this skill

**For file conversion:**

1. Ensure setup has been run (`bash convert_to_markdown/setup.sh`)
2. Run `convert_to_markdown/.venv/bin/markitdown <input> -o <output>`
3. Read the resulting `.md` if the user wants to see the content

**For URL conversion:**

1. Ensure setup has been run
2. Choose the right mode:
   - Most sites: `bash convert_to_markdown/url2md.sh <url> -o output.md` (uses curl, fast)
   - JS-heavy SPAs, dashboards, React/Vue/Angular apps: add `--js` (uses Playwright, slower but accurate)
3. If `--js` is used, the screenshot skill's Playwright install is reused when available; otherwise markitdown's own venv needs playwright installed

**For YouTube videos:**

1. Pass the YouTube URL directly to markitdown (no url2md.sh needed):
   `convert_to_markdown/.venv/bin/markitdown "https://www.youtube.com/watch?v=..." -o transcript.md`
2. This extracts the video title, description, metadata, and full transcript/captions
3. Useful for summarizing videos, extracting quotes, or analyzing video content

**For RSS/Atom feeds:**

1. Pass the feed URL directly to markitdown (no url2md.sh needed):
   `convert_to_markdown/.venv/bin/markitdown "https://example.com/feed.xml" -o feed.md`
2. Each entry becomes a Markdown section with title, link, date, and summary
3. Useful for news monitoring, content aggregation, or building digests

**When to use which mode:**
- Static HTML, blogs, docs, Wikipedia → default (curl)
- React/Vue/Angular apps, SPAs, pages requiring login/JS rendering → `--js`
- YouTube videos → markitdown directly (handles YouTube URLs natively)
- RSS/Atom feeds → markitdown directly (handles feed URLs natively)
- If default mode returns mostly empty or broken content → retry with `--js`

Note: Requires Python 3.10+.
