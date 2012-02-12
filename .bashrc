# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Config
export PS1='\u@\h:\w\$ '
export EDITOR="vim"
export PATH=$PATH:/usr/sbin:/usr/src/google_appengine/:~/bin/
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Make bash check its window size after a process completes
shopt -s checkwinsize

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
if [ -f "/usr/bin/virtualenvwrapper.sh" ]; then
    source /usr/bin/virtualenvwrapper.sh
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
    ;;
    laptop|air)
        ssh sam
    ;;
esac

if [ `hostname -s` != "laptop" ]; then
    . ~/bin/z.sh
    source ~/.autoenv/activate.sh
fi

#alias sudo='sudo -E env PATH=$PATH'

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

