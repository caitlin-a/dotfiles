# dotfiles

My macOS dotfiles. Inspired by [Jamie's setup](https://github.com/jmemich/dotfiles).

## What's here

| Directory | Config for |
|---|---|
| `zsh/` | `.zshrc`, `.zprofile` |
| `tmux/` | `.tmux.conf` |
| `git/` | `.gitconfig`, global `.gitignore` |
| `ghostty/` | Ghostty terminal config |
| `starship/` | Starship prompt |
| `vim/` | `.vimrc` |
| `Brewfile` | All Homebrew packages |
| `ai-config/` | AI agent config (submodule) |

## Fresh machine setup

```bash
git clone --recurse-submodules git@github.com:caitlin-a/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
gh auth login
```

`setup.sh` installs Homebrew (if absent), runs `brew bundle`, and symlinks everything into place. It's idempotent - safe to re-run.

## Machine-specific config

Shell overrides that shouldn't be tracked go in `~/.zshrc.local` - this file is sourced by `.zshrc` if it exists.

Claude personal context goes in `~/.claude/AGENTS.personal.md` - loaded by `ai-config/AGENTS.md` but never committed.
