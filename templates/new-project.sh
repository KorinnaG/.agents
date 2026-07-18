#!/usr/bin/env bash
# Scaffold a new web project wired to the shared AI blueprint (git submodule) in one command.
#
# ONE-TIME SETUP: publish the blueprint contents (this .agents/ folder) as its own GitHub repo,
# then set BLUEPRINT_URL below (or export BLUEPRINT_URL=... before running).
#
# Usage:  ./new-project.sh my-site
set -euo pipefail

BLUEPRINT_URL="${BLUEPRINT_URL:-https://github.com/CHANGE-ME/agents-blueprint.git}"

name="${1:-}"
[ -z "$name" ] && { echo "Usage: new-project.sh <project-name>"; exit 1; }
case "$BLUEPRINT_URL" in *CHANGE-ME*) echo "ERROR: set BLUEPRINT_URL to your published blueprint repo URL."; exit 1;; esac
command -v git >/dev/null 2>&1 || { echo "ERROR: git not found."; exit 1; }
[ -e "$name" ] && { echo "ERROR: '$name' already exists."; exit 1; }

echo "Creating $name ..."
mkdir "$name" && cd "$name"

git init -q
git submodule add "$BLUEPRINT_URL" .agents

cp .agents/templates/AGENTS.template.md AGENTS.md
[ -f .agents/templates/env.example ]        && cp .agents/templates/env.example .env.example
[ -f .agents/templates/gitignore.template ] && cp .agents/templates/gitignore.template .gitignore
mkdir -p decisions
printf '# Project Decisions (ADRs)\n\nProcess: .agents/docs/decisions.md - Template: .agents/templates/adr.template.md\n' > decisions/README.md

git add .
git commit -qm "Start project with AI blueprint submodule"

echo "Done. Open AGENTS.md and fill in the {{FIELDS}}, then start building."
