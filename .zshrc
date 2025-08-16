# =============================================================================
# PACKAGE MANAGERS & INITIALIZATION
# =============================================================================

# Homebrew, before everything else so plugins work
eval $(/opt/homebrew/bin/brew shellenv)

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit -u
fi

# =============================================================================
# SHELL CONFIGURATION
# =============================================================================

# vi mode
bindkey -v
export KEYTIMEOUT=10

# History settings
setopt HIST_VERIFY SHARE_HISTORY APPEND_HISTORY
export HISTSIZE=10000
export SAVEHIST=10000

# Completion settings
setopt complete_in_word
setopt always_to_end
setopt globdots
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

export EDITOR="vim"
export CLICOLOR=1

# Paths
export GOPATH=~/go
export PATH="$GOPATH/bin:/usr/local/heroku/bin:$PATH:/usr/sbin:/usr/local/sbin:~/bin"

# =============================================================================
# PROMPT
# =============================================================================

autoload -U promptinit; promptinit
prompt pure

# =============================================================================
# SSH AGENT
# =============================================================================

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add > /dev/null 2>&1
fi

# =============================================================================
# ALIASES & FUNCTIONS
# =============================================================================

# Docker
fig() {
  command docker compose "$@"
}

# Safety aliases
alias cp="cp -i"
alias mv="mv -i"

# Language shortcuts
alias python=python3
alias pip=pip3

# Tool replacements
if command -v rmtrash >/dev/null 2>&1; then
    alias rm='rmtrash'
    alias sudo='sudo '
fi

if command -v bat >/dev/null 2>&1; then
    alias cat="bat -p"
fi

# grc colorization
if command -v grc >/dev/null 2>&1 && [ "$TERM" != dumb ]; then
    alias colourify="grc -es --colour=auto"
    alias diff='colourify diff'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
fi

# =============================================================================
# EXTERNAL TOOLS
# =============================================================================

source <(fzf --zsh)
eval "$(zoxide init zsh)"

# =============================================================================
# SYSTEM LIMITS
# =============================================================================

ulimit -n 65536 200000
# started happening on bug sur?
ulimit -f unlimited

# =============================================================================
# PRIVATE CONFIGURATION
# =============================================================================

if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi