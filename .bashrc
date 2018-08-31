# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Config
export PS1='\u@\h:\w\$ '
export EDITOR="vim"
export PATH=$PATH:/usr/sbin:/usr/src/google_appengine:~/bin
export NODE_PATH=/usr/local/lib/node_modules
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Make bash check its window size after a process completes
shopt -s checkwinsize

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
if [ -f "/etc/bash_completion.d/virtualenvwrapper" ]; then
    source /etc/bash_completion.d/virtualenvwrapper
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

#alias sudo='sudo -E env PATH=$PATH'

GRC=`which grc`
if [ "$TERM" != dumb ] && [ -n GRC ]
then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
fi

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
