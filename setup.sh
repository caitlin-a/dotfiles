#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

blue()   { printf '\033[34m%s\033[0m\n' "$*"; }
yellow() { printf '\033[33m%s\033[0m\n' "$*"; }

link() {
    local src="$1"
    local dst="$2"

    if [[ ! -e "$src" ]]; then
        yellow "skip: $src does not exist"
        return
    fi

    mkdir -p "$(dirname "$dst")"

    if [[ -L "$dst" ]]; then
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        yellow "warn: $dst already exists and is not a symlink — skipping (move it out of the way first)"
        return
    fi

    ln -s "$src" "$dst"
    blue "linked: $dst -> $src"
}

# ---------------------------------------------------------------------------
# Submodules
# ---------------------------------------------------------------------------
git -C "$DOTFILES" submodule update --init --recursive

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    blue "installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

blue "running brew bundle..."
brew bundle --file="$DOTFILES/Brewfile"

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------
link "$DOTFILES/zsh/.zshrc"            "$HOME/.zshrc"
link "$DOTFILES/zsh/.zprofile"         "$HOME/.zprofile"
link "$DOTFILES/tmux/.tmux.conf"       "$HOME/.tmux.conf"
link "$DOTFILES/git/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES/git/ignore"            "$HOME/.config/git/ignore"
link "$DOTFILES/ghostty/config"        "$HOME/.config/ghostty/config"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/vim/.vimrc"            "$HOME/.vimrc"
link "$DOTFILES/Brewfile"              "$HOME/Brewfile"

# ---------------------------------------------------------------------------
# AI config
# ---------------------------------------------------------------------------
if [[ -f "$DOTFILES/ai-config/setup.sh" ]]; then
    blue "running ai-config/setup.sh..."
    bash "$DOTFILES/ai-config/setup.sh"
fi

blue "dotfiles setup complete."
