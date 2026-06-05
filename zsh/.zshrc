# ---------------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------------
# Homebrew (Apple Silicon first, then Intel fallback)
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f /usr/local/bin/brew ]]    && eval "$(/usr/local/bin/brew shellenv)"

export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

# ---------------------------------------------------------------------------
# pyenv
# ---------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv > /dev/null && eval "$(pyenv init -)"

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------
export EDITOR=vim
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# ---------------------------------------------------------------------------
# History
# ---------------------------------------------------------------------------
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
alias l='ls -lah'        # long list with hidden files, human-readable sizes
alias ..='cd ..'         # go up one directory
alias ...='cd ../..'     # go up two directories
alias md='glow'          # render markdown in terminal (requires glow)
alias stay='caffeinate'  # prevent Mac sleep during long runs
alias c='claude'         # open Claude Code

# ---------------------------------------------------------------------------
# Prompt & history (loaded if installed)
# ---------------------------------------------------------------------------
command -v starship > /dev/null && eval "$(starship init zsh)"
command -v atuin    > /dev/null && eval "$(atuin init zsh)"

# ---------------------------------------------------------------------------
# Local overrides (machine-specific, not tracked)
# ---------------------------------------------------------------------------
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
