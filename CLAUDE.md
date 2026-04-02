# CliSkills — Claude Code instructions

## Project overview

This repo is a Claude Code plugin marketplace. Each plugin lives under `plugins/<name>/` and contains skills, scripts, and a setup script.

## Conventions

- Each plugin lives in `plugins/<name>/` (lowercase, kebab-case)
- Every plugin must have `.claude-plugin/plugin.json` and `skills/<name>/SKILL.md`
- `SKILL.md` must have YAML frontmatter with a `description` field
- Supporting scripts: Python preferred, Bash acceptable
- Dependencies declared in `requirements.txt` (Python) or the script header (Bash)
- `setup.sh` installs all dependencies for the plugin

## When adding or editing a plugin

1. Keep `SKILL.md` concise — it is loaded into Claude's context on every invocation
2. Scripts must be executable (`chmod +x`)
3. Add the plugin to `.claude-plugin/marketplace.json`
4. Update `README.md` plugin table
5. Test with `setup.sh` before committing
6. Plugins are copied to a cache on install — do NOT use `../` paths to reference other plugins

## Style

- Python scripts: use `argparse`, exit non-zero on error, print errors to stderr
- Bash scripts: `set -euo pipefail`, quote all variables
