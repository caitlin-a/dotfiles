# dotfiles

macOS dev environment config. Structure nicked from [Jamie's dotfiles](https://github.com/jmemich/dotfiles).

`setup.sh` symlinks everything from this repo into `~`, so configs live here and the rest of the system finds them at the paths it expects. Idempotent - safe to re-run.

## Layout

```
dotfiles/
├── setup.sh                 # install + symlink entry point
├── Brewfile                 # all Homebrew packages (brew bundle)
│
├── zsh/                     # .zshrc, .zprofile
├── tmux/                    # .tmux.conf
├── git/                     # .gitconfig, global gitignore
├── ghostty/                 # terminal emulator config
├── starship/                # prompt config
├── vim/                     # .vimrc
└── ai-config/               # SUBMODULE — AI agent config (Claude, Cursor)
```

One folder per tool, mirroring where the tool expects its config under `$HOME`.

## Setup

```bash
git clone --recurse-submodules git@github.com:caitlin-a/dotfiles.git ~/dotfiles
bash ~/dotfiles/setup.sh
gh auth login
```

## Conventions

- `~/.zshrc.local` is gitignored - machine-specific shell config goes here
- `~/.claude/AGENTS.personal.md` is gitignored - personal context for AI agents (see ai-config)
- `~/.claude/settings.local.json` is gitignored - machine-specific Claude Code permissions
