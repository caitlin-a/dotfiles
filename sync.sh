#!/usr/bin/env bash
# Auto-syncs dotfiles and ai-config to GitHub.
# Commits any uncommitted changes to the auto-sync branch and pushes.
# Merge auto-sync to main manually whenever you're happy with it.
# Safe to run when there's nothing to commit - exits quietly.
#
# Note: uses git plumbing (write-tree/commit-tree) to commit without switching
# branches, so live symlinked config files are never touched.

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
        git fetch --quiet

        # Parent is tip of auto-sync if it exists, otherwise main HEAD
        local parent
        if git rev-parse --verify "origin/auto-sync" &>/dev/null; then
            parent=$(git rev-parse "origin/auto-sync")
        else
            parent=$(git rev-parse HEAD)
        fi

        # Commit to branch without switching (switching would revert live symlinked files)
        local tree commit
        tree=$(git write-tree)
        commit=$(git commit-tree "$tree" -p "$parent" -m "auto: sync $DATE")
        git branch -f auto-sync "$commit"
        git push -u origin auto-sync

        # Unstage - working tree is unchanged throughout
        git reset HEAD

        echo "synced: $dir -> auto-sync"
    fi
}

# ai-config first (submodule), then dotfiles parent
sync_repo "$DOTFILES/ai-config"
sync_repo "$DOTFILES"
