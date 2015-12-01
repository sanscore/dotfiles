# .bashrc
#Disable Flow Control for interactive sessions
if [[ $- == *i* ]]; then
  stty ixoff -ixon
  stty ixany
fi

if [ -f $HOME/.bashrc.work ]; then
  source $HOME/.bashrc.work
fi

if [[ -d "${HOME}/bin/" && ":${PATH}:" != *":${HOME}/bin/:"* ]]; then
  export PATH="${HOME}/bin/:${PATH}"
fi

# Bigger History File
HISTFILESIZE=400000000
HISTSIZE=10000

# Ignore lines prepended with a space
HISTCONTROL=ignoreboth:erasedups

# Append history
shopt -s histappend

# And, commit previous command to history
PROMPT_COMMAND='history -a'

# Enable extended globstar '**'
shopt -s globstar

# Functions
function p {
  python -m SimpleHTTPServer ${1:-8010}
}

function env_darwin {
  alias ls='ls -G'
  alias l.='ls -dG .*'
}

# Aliases

alias ..='cd ..'

alias sl=ls
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -lha'

alias mkdir='mkdir -pv'

alias df='df -H'
alias du='du -ch'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias p10="p 8010"
alias p20="p 8020"
alias p30="p 8030"

alias wget='wget -c'

# OS Corrections
case $OSTYPE in
  solaris*) ;;
  darwin*) env_darwin;;
  linux*) ;;
  cygwin*) ;;
  bsd*) ;;
  *) echo '***** OSTYPE='$OSTYPE '*****' ;;
esac

# Use VIM as editor
export EDITOR=vim

# source bash completions for __git_ps1
# OS X
[[ -f /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh ]] && \
  source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh && \
  source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
# Ubuntu
[[ -f /usr/lib/git-core/git-sh-prompt ]] && \
  source /usr/lib/git-core/git-sh-prompt
# Fedora
[[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]] && \
  source /usr/share/git-core/contrib/completion/git-prompt.sh

if [[ __git_ps1 ]]; then
  # PS1: username@hostname:directory[history_number](git_branch)$
  export PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\$(__git_ps1 \"(%s)\")\\$ \[\e[0m\]"
else
  # PS1: username@hostname:directory[history_number]$
  export PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\\$ \[\e[0m\]"
fi
