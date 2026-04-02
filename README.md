# pforret/CliSkills

A marketplace of CLI-based Claude Code skills — each skill is a self-contained folder with a `SKILL.md` and supporting scripts.

## Installation

### Step 1: Add the marketplace

Register this repo as a skill marketplace in Claude Code:

```bash
/plugin marketplace add pforret/CliSkills
```

### Step 2: Install a skill

Install individual skills into your current project:

```bash
/plugin install screenshot@CliSkills
/plugin install convert_to_markdown@CliSkills
```

### Step 3: Run setup

Each skill has its own `setup.sh` that creates a Python virtual environment and installs dependencies. Run it once before first use:

```bash
bash screenshot/setup.sh
bash convert_to_markdown/setup.sh
```

### Manual installation

If you prefer, you can clone the repo and copy skill folders manually:

```bash
git clone https://github.com/pforret/CliSkills.git
cp -r CliSkills/screenshot .claude/skills/
cp -r CliSkills/convert_to_markdown .claude/skills/
```

## Available skills

| Skill | Description | Wraps |
|-------|-------------|-------|
| [screenshot](screenshot/) | Take web page screenshots | [shot-scraper](https://github.com/simonw/shot-scraper) |
| [convert_to_markdown](convert_to_markdown/) | Convert documents, URLs, YouTube, RSS to Markdown | [markitdown](https://github.com/microsoft/markitdown) |

## What is a Claude Code skill?

A [Claude Code skill](https://docs.anthropic.com/en/docs/claude-code/skills) is a Markdown file that instructs Claude Code how to use a specific tool or script. Each skill folder contains a `SKILL.md` that Claude reads to understand the tool's capabilities, options, and when to use it.

## Structure

```
CliSkills/
├── README.md          # this file
├── CLAUDE.md          # repo-level Claude Code instructions
└── <skill-name>/
    ├── SKILL.md       # skill definition (loaded by Claude Code)
    ├── requirements.txt
    ├── setup.sh       # one-time setup (creates .venv, installs deps)
    └── *.sh           # supporting scripts
```

## Adding a skill

1. Create a new folder: `mkdir my-skill`
2. Add `SKILL.md` describing what Claude should do and how to invoke the scripts
3. Add scripts, `requirements.txt`, and `setup.sh`
4. Update the skill table in this README
5. Submit a PR
