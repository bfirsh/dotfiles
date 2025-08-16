# Homebrew, before everything else so plugins work
eval $(/opt/homebrew/bin/brew shellenv)

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# pure
autoload -U promptinit; promptinit
prompt pure

export EDITOR="vim"
export CLICOLOR=1

# Tab complete hidden files
setopt globdots

## Paths
export PATH=$PATH:/usr/sbin:/usr/local/sbin:~/bin
export GOPATH=~/go
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"


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
if command -v rmtrash >/dev/null 2>&1; then
    alias rm='rmtrash'
    alias sudo='sudo '
fi

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

alias python=python3
alias pip=pip3

source <(fzf --zsh)
eval "$(zoxide init zsh)"

ulimit -n 65536 200000
# started happening on bug sur?
ulimit -f unlimited

# last
if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi


