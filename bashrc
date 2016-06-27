# .bashrc
#Disable Flow Control for interactive sessions
if [[ $- == *i* ]]; then
  stty ixoff -ixon
  stty ixany
fi

for rc in $HOME/.bashrc.*
do
  source $rc
done

if [[ -d "${HOME}/bin/" && ":${PATH}:" != *":${HOME}/bin:"* ]]; then
  export PATH="${HOME}/bin/:${PATH}"
fi

# Enable extended globstar '**'
shopt -s globstar

# update window size
shopt -s checkwinsize

# multiline cmds saved as one in history
shopt -s cmdhist

# Append history, and
#   commit previous command to history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Bigger History File
HISTFILESIZE=400000000
HISTSIZE=10000

# Ignore lines prepended with a space
HISTCONTROL=ignoreboth:erasedups

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

# trim path in prompt
PROMPT_DIRTRIM=2

function env_darwin {
  alias ls='ls -G'
  alias l.='ls -dG .*'

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
}

# Aliases

alias ..='cd ..'

alias sl=ls
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -lha'
alias l1='ls -1'

alias mkdir='mkdir -pv'

alias df='df -H'
alias du='du -ch'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias wget='wget -c'

alias groot='cd $(git rev-parse --show-toplevel)'
alias vim-up='vim +PluginClean! +PluginInstall! +qall && vim'

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

# Python
export PYTHONDONTWRITEBYTECODE=1
