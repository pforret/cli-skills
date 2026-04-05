# pforret/cli-skills

A plugin marketplace for Claude Code — CLI-based skills wrapping popular tools.

## Installation

### Step 1: Add the marketplace

```bash
/plugin marketplace add pforret/cli-skills
```

### Step 2: Install a plugin

```bash
/plugin install screenshot-web@cli-skills
/plugin install screenshot-desktop@cli-skills
/plugin install markdown-web@cli-skills
/plugin install markdown-file@cli-skills
```

### Step 3: Run setup

Each plugin has a `setup.sh` that installs dependencies. Run it once before first use. Claude will do this automatically when the skill is invoked.

**Option A — Python venv** (default):
```bash
bash setup.sh
```

**Option B — Docker** (no Python/venv needed):
```bash
bash setup.sh --docker
```

Each plugin also has a `run.sh` wrapper that auto-detects whether to use Docker or venv, so you don't need to remember which mode you installed with.

## Available plugins

| Plugin                                            | Description                                             | Wraps                                                  |
|---------------------------------------------------|---------------------------------------------------------|--------------------------------------------------------|
| [screenshot-web](plugins/screenshot-web/)         | Take web page screenshots (by URL)                      | [shot-scraper](https://github.com/simonw/shot-scraper) |
| [screenshot-desktop](plugins/screenshot-desktop/) | Capture desktop/screen/window screenshots               | Native OS tools                                        |
| [markdown-web](plugins/markdown-web/)             | Convert URLs, YouTube, RSS feeds to Markdown            | [markitdown](https://github.com/microsoft/markitdown)  |
| [markdown-file](plugins/markdown-file/)           | Convert local files (PDF, DOCX, PPTX, etc.) to Markdown | [markitdown](https://github.com/microsoft/markitdown)  |

## Structure

```
cli-skills/
├── .claude-plugin/
│   └── marketplace.json       # marketplace catalog
├── plugins/
│   └── <plugin-name>/
│       ├── .claude-plugin/
│       │   └── plugin.json    # plugin manifest
│       ├── skills/
│       │   └── <skill-name>/
│       │       └── SKILL.md   # skill definition (loaded by Claude Code)
│       ├── setup.sh           # one-time dependency install
│       └── ...                # scripts, requirements.txt, etc.
├── CLAUDE.md
└── README.md
```

## Adding a plugin

1. Create `plugins/my-plugin/` with the structure above
2. Add `SKILL.md` with YAML frontmatter (`description` field required)
3. Add `.claude-plugin/plugin.json` with `name`, `description`, `version`
4. Add scripts, `requirements.txt`, and `setup.sh`
5. Add the plugin to `.claude-plugin/marketplace.json`
6. Update the plugin table in this README
