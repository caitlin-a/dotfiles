# dotfiles

Personal config for macOS dev env. Designed to bootstrap a fresh mac without having to fiddle around myself. Heavily relies on symlinks to point the system at this repo from the normal config homes, so not really something that will work on windows.

Changes are auto-committed and pushed daily via `dotfiles/sync.sh`.

Thanks to [Jamie for the inspo](https://github.com/jmemich/dotfiles) (both of the git repo and the configs).

## Layout

```
dotfiles/
├── setup.sh                 # install + symlink entry point
├── sync.sh                  # daily auto-commit + push (runs via launchd)
├── com.caitlinadams.dotfiles-sync.plist  # launchd job definition (installed by setup.sh)
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

## Syncing

`sync.sh` runs daily via launchd and auto-commits + pushes any uncommitted changes. Runs on next wake if the machine was closed at the scheduled time. Logs to `sync.log` (gitignored).

## Conventions

- `~/.zshrc.local` is gitignored - machine-specific shell config goes here
- `~/.claude/AGENTS.personal.md` is gitignored - personal context for AI agents (see ai-config)
- `~/.claude/settings.local.json` is gitignored - machine-specific Claude Code permissions
