# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export ZSH_THEME="blinks"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autopep8 bower bundler brew coffee docker docker-compose django emoji-clock extract fabric git github heroku lein node npm nyan osx pip postgres python rbenv safe-paste vagrant)

source $ZSH/oh-my-zsh.sh

export HISTFILE=/tmp/zsh_history
export EDITOR="vim"
export PATH=$PATH:/usr/sbin:/usr/src/google_appengine:~/bin:/usr/local/share/npm/bin:/usr/local/packer
export NODE_PATH=/usr/local/lib/node_modules
export CLICOLOR=1

if [ -f /usr/bin/dircolors ]; then
    eval `dircolors ~/.dir_colors`
fi

# virtualenvwrapper on linux
if [ -f "/etc/bash_completion.d/virtualenvwrapper" ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /etc/bash_completion.d/virtualenvwrapper
fi
# virtualenvwrapper on mac
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export WORKON_HOME=$HOME/.virtualenvs-osx
    source /usr/local/bin/virtualenvwrapper.sh
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

# Host specific configs
case `hostname -s` in
    'sam')
        # http://hints.macworld.com/article.php?story=20060410092629437
        export XAUTHORITY=/tmp/.Xauthority.$USER
        alias ls="ls --color"
        # Source SSH settings, if applicable
        if [ -f "${SSH_ENV}" ]; then
            . "${SSH_ENV}" > /dev/null
            #ps ${SSH_AGENT_PID} doesn't work under cywgin
            ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
        else
            start_agent;
        fi
        
        # z
        . ~/bin/z.sh
        function precmd () {
            _z --add "$(pwd -P)"
        }

    ;;
    laptop|air|Macintosh|macintosh|computer)
        ssh sam
    ;;
esac


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

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}${ZSH_THEME_GIT_PROMPT_CLEAN}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

if [[ -e $HOME/.zshrc-private ]]; then
    source $HOME/.zshrc-private
fi

