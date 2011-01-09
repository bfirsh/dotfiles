# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Config
export PS1='\u@\h:\w\$ '
export EDITOR="vim"
export PATH=$PATH:/usr/src/google_appengine/:~/bin/
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
    'zara')
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
    'laptop')
        ssh zara
    ;;
esac

if [ `hostname -s` != "laptop" ]; then
    . ~/bin/z.sh
fi

if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

