#!/usr/bin/env bash
# Auto-syncs dotfiles and ai-config to GitHub.
# Commits any uncommitted changes to a dated branch (auto/YYYY-MM-DD) and pushes.
# Does NOT commit to main — review the branch and merge manually when happy.
# Safe to run when there's nothing to commit - exits quietly.
#
# Note: uses git plumbing (write-tree/commit-tree) to commit without switching
# branches, so live symlinked config files are never touched.

set -euo pipefail

DOTFILES="$HOME/dotfiles"
DATE="$(date +%Y-%m-%d)"
BRANCH="auto/$DATE"

# Load SSH key from macOS keychain so this works without an agent running
ssh-add --apple-load-keychain 2>/dev/null || true

sync_repo() {
    local dir="$1"
    cd "$dir"

    if [[ -n "$(git status --porcelain)" ]]; then
        git add -A

        # Commit to branch without switching (switching would revert live symlinked files)
        local tree commit
        tree=$(git write-tree)
        commit=$(git commit-tree "$tree" -p "$(git rev-parse HEAD)" -m "auto: sync $DATE")
        git branch -f "$BRANCH" "$commit"
        git push -u origin "$BRANCH"

        # Unstage - working tree is unchanged throughout
        git reset HEAD

        echo "synced: $dir -> branch $BRANCH"
    fi
}

# ai-config first (submodule), then dotfiles parent
sync_repo "$DOTFILES/ai-config"
sync_repo "$DOTFILES"
