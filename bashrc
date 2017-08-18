# .bashrc
#Disable Flow Control for interactive sessions
if [[ $- == *i* ]]; then
  stty ixoff -ixon
  stty ixany
fi

shopt -s nullglob
for rc in $HOME/.bashrc.*
do
  source $rc
done
shopt -u nullglob

if [[ -d "${HOME}/bin" && ":${PATH}:" != *":${HOME}/bin:"* ]]; then
  export PATH="${HOME}/bin:${PATH}"
fi

# Enable extended globstar '**'
shopt -s globstar

# Restore multiline commands from history
shopt -s lithist

# update window size
shopt -s checkwinsize

# multiline cmds saved as one in history
shopt -s cmdhist

# Append history, and
#   commit previous command to history
shopt -s histappend
export PROMPT_COMMAND='history -a'

# trim path in prompt
export PROMPT_DIRTRIM=2

function env_darwin {
  [[ -f /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh ]] \
    && source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh \
    && source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash

  alias ls='ls -G'
  alias l.='ls -dG .*'

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
  
  # (brew) /usr/local/bin
  if [[ -d "/usr/local/bin" && ":${PATH}:" != *":${HOME}/bin:"* ]]; then
    export PATH="${HOME}/bin:${PATH}"
  fi

  # (brew) /usr/local/sbin
  if [[ -d "/usr/local/sbin" && ":${PATH}:" != *":/usr/local/sbin:"* ]]; then
    export PATH="/usr/local/sbin:${PATH}"
  fi
}

function env_fedora {
  [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]] \
    && source /usr/share/git-core/contrib/completion/git-prompt.sh
  [[ -f /usr/share/bash-completion/bash_completion ]] \
    && source /usr/share/bash-completion/bash_completion

  alias vim='vimx'
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

alias digs='dig +noall +answer +short'

alias groot='cd $(git rev-parse --show-toplevel)'

## SSL Testing
# Remote - Check Trust Chain
ssl_scerts() {
  # split certs into different files, use awk instead of sed.
  #  gsed -nEe '/-----BEGIN/,/----END/wfoo'
  openssl s_client -showcerts -connect $* </dev/null 2> /dev/null \
    | tee /dev/tty \
    | openssl x509 -noout -text -subject -issuer -email -purpose
}

ssl_strust() {
  openssl s_client -connect $1 </dev/null 2> /dev/null \
    | sed -n '/Acceptable/,/Client/p'
}

# Client - Check Trust Chain
ssl_ctrust() {
  keytool -printcert -v -file $1
}

# Client - Cert Signature
ssl_ccert() {
  openssl x509 -inform PEM -in $1 -noout -text -issuer -email -purpose
}

# OS Corrections
case $OSTYPE in
  solaris*) ;;
  darwin*) env_darwin;;
  linux*)
    # Fedora
    [[ -f /etc/fedora-release ]] && env_fedora

    # Ubuntu
    [[ -f /usr/lib/git-core/git-sh-prompt ]] \
      && source /usr/lib/git-core/git-sh-prompt
    ;;
  cygwin*) ;;
  bsd*) ;;
  *) echo '***** OSTYPE='$OSTYPE '*****' ;;
esac

# Use VIM as editor
export EDITOR=vim

# __timestamp="\[\e[01;32m\][\[\e[00;37m\]"'$(history 1)'"\[\e[01;32m\]]\[\e[0m\]\n"
# export PS0="$__timestamp"
if [[ __git_ps1 ]]; then
  # PS1: username@hostname:directory[history_number](git_branch)$
  export PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\$(__git_ps1 \"(%s)\")\\$ \[\e[0m\]"
else
  # PS1: username@hostname:directory[history_number]$
  export PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\\$ \[\e[0m\]"
fi

# Python
export PYTHONDONTWRITEBYTECODE=1
