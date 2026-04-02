# CliSkills — Claude Code instructions

## Project overview

This repo contains CLI-based Claude Code skills. Each subfolder is one skill.

## Conventions

- Each skill lives in its own folder named after the skill (lowercase, no spaces)
- Every skill folder must contain a `SKILL.md`
- Supporting scripts: Python preferred, Bash acceptable
- Dependencies declared in `requirements.txt` (Python) or the script header (Bash)
- `setup.sh` installs all dependencies for the skill

## When adding or editing a skill

1. Keep `SKILL.md` concise — it is loaded into Claude's context on every invocation
2. Scripts must be executable (`chmod +x`)
3. Update `README.md` skill table when adding a new skill
4. Test with `setup.sh` before committing

## Style

- Python scripts: use `argparse`, exit non-zero on error, print errors to stderr
- Bash scripts: `set -euo pipefail`, quote all variables
