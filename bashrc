# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Append history
shopt -s histappend
# And, commit previous command to history
PROMPT_COMMAND='history -a'

# Ignore lines prepended with a space
HISTCONTROL=ignorespace

# PS1: username@hostname:directory[history_number]$ 
export PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\\$ \[\e[0m\]"

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

