# claude-skills

A personal library of [Claude Code](https://claude.ai/code) slash-command skills.

## Available skills

| Skill | Command | Description |
|-------|---------|-------------|
| [create-react-app](skills/create-react-app/SKILL.md) | `/create-react-app <name>` | Scaffold a React app with Yarn Berry, Vite, TypeScript, Vitest, and ESLint a11y |

## Installation

### Global (available in every project)

Symlink the skills you want into `~/.claude/skills/`:

```bash
# All skills at once
for skill in skills/*/; do
  skill_name=$(basename "$skill")
  ln -sf "$(pwd)/$skill" ~/.claude/skills/"$skill_name"
done

# Or a single skill
ln -sf "$(pwd)/skills/create-react-app" ~/.claude/skills/create-react-app
```

Or run the included setup script:

```bash
./setup.sh
```

### Per-project

Copy or symlink a skill into the project's `.claude/skills/` directory:

```bash
mkdir -p .claude/skills
ln -sf ~/Desktop/code/claude-skills/skills/create-react-app .claude/skills/create-react-app
```

## Adding new skills

1. Create a directory under `skills/`: `skills/<skill-name>/`
2. Add a `SKILL.md` file following the format in the existing skills
3. Link it globally with `./setup.sh` or per-project as above

### SKILL.md frontmatter

```markdown
---
name: skill-name
description: Short description shown in /help
argument-hint: <required-arg> [optional-arg]
allowed-tools: [Bash, Read, Write, Edit]
---
```
