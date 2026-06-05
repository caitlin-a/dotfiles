# dotfiles

macOS dotfiles. Structure nicked from [Jamie's dotfiles](https://github.com/jmemich/dotfiles).

`setup.sh` installs Homebrew (if absent), runs `brew bundle`, and symlinks everything from this repo into `~`. Idempotent - safe to re-run.

## What's here

| | |
|---|---|
| `zsh/` | `.zshrc`, `.zprofile` |
| `tmux/` | `.tmux.conf` |
| `git/` | `.gitconfig`, global gitignore |
| `ghostty/` | Terminal config |
| `starship/` | Prompt config |
| `vim/` | `.vimrc` |
| `Brewfile` | All Homebrew packages |
| `ai-config/` | AI agent config (submodule - [caitlin-a/ai-config](https://github.com/caitlin-a/ai-config)) |

## Fresh machine setup

```bash
git clone --recurse-submodules git@github.com:caitlin-a/dotfiles.git ~/dotfiles
bash ~/dotfiles/setup.sh
gh auth login
```

## Machine-specific stuff (not tracked)

- `~/.zshrc.local` - sourced by `.zshrc` if it exists; machine-specific shell overrides go here
- `~/.claude/AGENTS.personal.md` - personal context for AI agents (see ai-config)
- `~/.claude/settings.local.json` - machine-specific Claude Code permissions
