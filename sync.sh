#!/usr/bin/env bash
# Auto-syncs dotfiles and ai-config to GitHub.
# Commits any uncommitted changes with a datestamped message and pushes.
# Safe to run when there's nothing to commit - just exits quietly.

set -euo pipefail

DOTFILES="$HOME/dotfiles"
DATE="$(date +%Y-%m-%d)"

# Load SSH key from macOS keychain so this works without an agent running
ssh-add --apple-load-keychain 2>/dev/null || true

sync_repo() {
    local dir="$1"
    cd "$dir"
    if [[ -n "$(git status --porcelain)" ]]; then
        git add -A
        git commit -m "auto: sync $DATE"
        git push
        echo "synced: $dir"
    fi
}

# ai-config first (submodule), then dotfiles parent
sync_repo "$DOTFILES/ai-config"
sync_repo "$DOTFILES"
