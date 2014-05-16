# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Append history
shopt -s histappend
# And, commit previous command to history
PROMPT_COMMAND='history -a'

# User specific aliases and functions
