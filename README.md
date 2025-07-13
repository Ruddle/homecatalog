# homecatalog

**homecatalog** is a catalog of Linux application files in home directories, helping users identify config/data/cache locations for scripting backups, cleanup, and migrations.

> **Note:** This format is a starting proposition. Community feedback and improvements are welcome!

---

## Format

Entries are stored in a simple, low-level, shell-friendly text file format:

`<binary-glob>|<tags>|<path-glob>`

Where:
- `binary-glob` — glob pattern matching the responsible binary or application (`firefox`, `code*`, etc.)
- `tags` — space-separated list of tags where ALL must apply:
  - `config` — user settings and preferences
  - `data` — application data or state
  - `cache` — non-essential, discardable files
  - `log` — application log files
  - `secret` — contains sensitive data (API keys, credentials, etc.)
- `path-glob` — a full or globbed path (e.g. `~/.config/app/*`)

---

## Example Entries

```text
bash|config|~/.bashrc
code*|config|~/.config/Code/User/*
idea*|cache|~/.cache/JetBrains/IdeaIC*
idea*|config|~/.config/JetBrains/IdeaIC*
idea*|data|~/.local/share/JetBrains/IdeaIC*
ssh|config secret|~/.ssh/
```

## Goals

- Let users write scripts like:
  - "Backup all config files"
  - "Delete all cache files"
  - "List all data paths used by apps matching code"
- Encourage open contributions from the community
- Keep it minimal and friendly to Bash, grep, and other standard tools


## Contributing

Open a pull request to add new entries or improve existing ones.

## Example scripts

### lstag.sh

Lists home files matching specified tags:

Usage examples:
```bash
# List all config files
./lstag.sh config

# List all cache files
./lstag.sh cache
```