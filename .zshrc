# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export ZSH_THEME="blinks"

# Homebrew
export PATH="/usr/local/bin:$PATH"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  aws
  brew
  django
  docker
  docker-compose
  extract
  fzf
  git
  github
  gpg-agent
  heroku
  history
  mercurial
  node
  npm
  # causing hanging on latest node
  #npx
  osx
  pip
  postgres
  python
  ripgrep
  safe-paste
  yarn
  z
)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"
export PATH=$PATH:/usr/sbin:/usr/local/sbin:/usr/src/google_appengine:~/bin:/usr/local/share/npm/bin
export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1

if [ -f /usr/bin/dircolors ]; then
    eval `dircolors ~/.dir_colors`
fi

# SSH agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

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

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}${ZSH_THEME_GIT_PROMPT_CLEAN}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

export GOPATH=~/go
export PATH="$GOPATH/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi

# https://yarnpkg.com/en/docs/install
export PATH="$PATH:`yarn global bin`"

# Use Homebrew's /usr/local/bin/python2 as python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

alias fig=docker-compose

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
