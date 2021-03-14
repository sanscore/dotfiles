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

env_darwin() {
  # alias ls='ls -G'
  # alias l.='ls -dG .*'
  alias l@='/bin/ls -halF -@eO'

  # brew install bash-completion@2
  export BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] \
    && . "/usr/local/etc/profile.d/bash_completion.sh"

  [[ -f /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh ]] \
    && source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh \
    && source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
}

env_fedora() {
  command -v open &>/dev/null || { command -v xdg-open &>/dev/null && alias open='xdg-open' ; } || echo Cannot find 'open' or 'xdg-open'.
  command -v vim &>/dev/null || { command -v vimx &>/dev/null && alias vim='vimx' ; } || echo Cannot find 'vim' or 'vimx'.
  export EDITOR=vim
  [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]] \
    && source /usr/share/git-core/contrib/completion/git-prompt.sh
  [[ -f /usr/share/bash-completion/bash_completion ]] \
    && source /usr/share/bash-completion/bash_completion
}

# Aliases
alias ..='cd ..'

alias sl=ls
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -halF'
alias l1='ls -1'
alias lu='ls -ltu'

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
  local tmp=$(mktemp -d -t ssl_scerts)

  openssl s_client -showcerts -connect $* </dev/null 2>/dev/null \
    | awk -v tmp="$tmp/" '/-----BEGIN CERTIFICATE-----/{f=1; x=++i; buf=""} f{buf = buf $0 RS} /-----END CERTIFICATE-----/{print buf > tmp x ".cert"; f=0}'

  for cert in $tmp/*.cert; do
    echo
    openssl x509 -in $cert -out - -text
  done

  rm -rf "$tmp"
}

ssl_strust() {
  openssl s_client -connect $1 </dev/null 2> /dev/null \
    | sed -n '/Acceptable/,/Client/p'
}

# Client - Check Trust Chain
ssl_ctrust() {
  for cert in "$@"; do
    keytool -printcert -v -file "$cert"
  done
}

# Client - Cert Signature
ssl_ccert() {
  for cert in "$@"; do
    echo "$cert"
    openssl x509 -inform PEM -in "$cert" -noout -text -issuer -email -purpose
  done
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

ps1_hide() {
  PS1="\\$ "
  bind 'set show-mode-in-prompt off'
}
ps1_min() {
  PS1="\\W\\$ "
  bind 'set show-mode-in-prompt off'
}
ps1_show() {
  if declare -f __git_ps1 > /dev/null; then
    # PS1: username@hostname:directory[history_number](git_branch)$
    PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\$(__git_ps1 \"(%s)\")\\$ \[\e[0m\]"
  else
    # PS1: username@hostname:directory[history_number]$
    PS1="\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\]:\[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\][\\!]\\$ \[\e[0m\]"
  fi

  bind 'set show-mode-in-prompt on'
}
ps1_show

# Python
export PYTHONDONTWRITEBYTECODE=1

# curl - log SSL keyfile for inspecting https traffic
export ENABLE_SSLKEYLOGFILE=1
export SSLKEYLOGFILE="${HOME}/.ssh/tlskey"
