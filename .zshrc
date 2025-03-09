# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export ZSH_THEME="blinks"

# Homebrew, before everything else so plugins work
eval $(/opt/homebrew/bin/brew shellenv)

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  aws
  brew
  docker
  docker-compose
  extract
  fzf
  gcloud
  git
  github
  gpg-agent
  heroku
  history
  macos
  mercurial
  node
  npm
  # causing hanging on latest node
  #npx
  pip
  postgres
  python
  safe-paste
  yarn
  z
)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"
export CLICOLOR=1


## Paths
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/src/google_appengine:~/bin:/usr/local/share/npm/bin

export NODE_PATH=/usr/local/lib/node_modules

export GOPATH=~/go
export PATH="$GOPATH/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# Use Homebrew's Python as `python
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"


if [ -f /usr/bin/dircolors ]; then
    eval `dircolors ~/.dir_colors`
fi

## SSH agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

## Aliases

fig() {
  command docker compose "$@"
}

# https://github.com/PhrozenByte/rmtrash
#alias rm='rmtrash'
#alias rmdir='rmdirtrash'
#alias sudo='sudo '

GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n GRC ]
then
    alias colourify="$GRC -es --colour=auto"
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

if command -v bat >/dev/null 2>&1; then
    alias cat="bat -p"
fi

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}${ZSH_THEME_GIT_PROMPT_CLEAN}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


test -e /Users/ben/.iterm2_shell_integration.zsh && source /Users/ben/.iterm2_shell_integration.zsh || true

ulimit -n 65536 200000
# started happening on bug sur?
ulimit -f unlimited


# last
if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi


