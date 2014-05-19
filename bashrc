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
