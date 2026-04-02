# CliSkills

A marketplace of CLI-based Claude Code skills — each skill is a self-contained folder with a `SKILL.md` and supporting scripts.

## What is a Claude Code skill?

A [Claude Code skill](https://docs.anthropic.com/en/docs/claude-code/skills) is a Markdown file that instructs Claude Code how to use a specific tool or script. Skills are invoked via `/skill-name` in Claude Code.

## Structure

```
CliSkills/
├── README.md          # this file
├── CLAUDE.md          # repo-level Claude Code instructions
└── <skill-name>/
    ├── SKILL.md       # skill definition (loaded by Claude Code)
    ├── requirements.txt
    ├── setup.sh
    └── *.py / *.sh    # supporting scripts
```

## Available skills

| Skill | Description |
|-------|-------------|
| [screenshot](screenshot/) | Take full-page or element screenshots via Playwright (Python) |

## Usage

Copy a skill folder into your project's `.claude/` directory, or reference the `SKILL.md` path in your Claude Code settings.

## Adding a skill

1. Create a new folder: `mkdir my-skill`
2. Add `SKILL.md` describing what Claude should do and how to invoke the scripts
3. Add scripts, `requirements.txt`, and `setup.sh`
4. Submit a PR
