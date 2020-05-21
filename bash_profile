##############################
# READLINE HISTORY
##############################

export HISTFILESIZE=400000000
export HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
export HISTTIMEFORMAT='%F %T '

##############################
# SETUP PATH
##############################

__add_path() {
  [[ -d "$1" ]] || (echo "ERR: $1 directory does not exist."; return 1)
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Setup PATH
if [[ "${OSTYPE}" = "darwin"* ]]; then
  export PATH=""
  . /etc/profile

  # Already added by /etc/profile
  # USR_LOCAL_BIN="/usr/local/bin"
  # __add_path "${USR_LOCAL_BIN}"

  USR_LOCAL_SBIN="/usr/local/sbin"
  __add_path "${USR_LOCAL_SBIN}"

  COREUTILS_GNUBIN="/usr/local/opt/coreutils/libexec/gnubin/"
  __add_path "${COREUTILS_GNUBIN}"

  FINDUTILS_GNUBIN="/usr/local/opt/findutils/libexec/gnubin"
  __add_path "${FINDUTILS_GNUBIN}"

  TAR_GNUBIN="/usr/local/opt/gnu-tar/libexec/gnubin"
  __add_path "${TAR_GNUBIN}"

  GREP_GNUBIN="/usr/local/opt/grep/libexec/gnubin"
  __add_path "${GREP_GNUBIN}"

  SED_GNUBIN="/usr/local/opt/gnu-sed/libexec/gnubin"
  __add_path "${SED_GNUBIN}"

  OPENSSL_BIN="/usr/local/opt/openssl/bin"
  __add_path "${OPENSSL_BIN}"

  CURL_OPENSSL_BIN="/usr/local/opt/curl-openssl/bin"
  __add_path "${CURL_OPENSSL_BIN}"

  GETTEXT_BIN="/usr/local/opt/gettext/bin"
  __add_path "${GETTEXT_BIN}"
fi

##############################
# VIRTUAL MANAGERS
##############################

# rbenv - Ruby
export RBENV_ROOT="${HOME}/.rbenv"
if __add_path "${HOME}/.rbenv/bin"; then
  eval "$(rbenv init - --no-rehash)"
  up-rbenv () {
    for repo in "$RBENV_ROOT" "$RBENV_ROOT"/plugins/*; do
      echo $( basename $repo )
      ( git -C $repo pull )
    done
  }
fi

# pyenv - Python
export PYENV_ROOT="${HOME}/.pyenv"
if __add_path "${HOME}/.pyenv/bin"; then
  eval "$(pyenv init - --no-rehash)"

  up-pyenv () {
    for repo in "$PYENV_ROOT" "$PYENV_ROOT"/plugins/*; do
      echo $( basename $repo )
      ( git -C $repo pull )
    done
  }
fi

if command -v pip >/dev/null 2>&1; then
  _pip_completion()
  {
      COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                    COMP_CWORD=$COMP_CWORD \
                    PIP_AUTO_COMPLETE=1 $1 ) )
  }
  complete -o default -F _pip_completion pip
fi

# nvm - Node
if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  export NVM_DIR="${HOME}/.nvm"
  . "$NVM_DIR/nvm.sh" && . $NVM_DIR/bash_completion

  up-nvm () {
    git -C "${HOME}/.nvm" pull
  }
fi

up-up() {
  for version_manager in rbenv pyenv nvm
  do
    echo ${version_manager}
    if type up-${version_manager} &>/dev/null
    then
      up-${version_manager}
    else
      echo up-${version_manager} not found
    fi
    echo
  done
}

if [ -f "${HOME}/.google-cloud-sdk/path.bash.inc" ]; then
  export GCLOUD_DIR="${HOME}/.google-cloud-sdk"
  source "$GCLOUD_DIR/path.bash.inc"

  if [ -f "$GCLOUD_DIR/completion.bash.inc" ]; then
    source "$GCLOUD_DIR/completion.bash.inc"
  fi
fi

# ~/bin
__add_path "${HOME}/bin"


##############################
# SSH-AGENT
##############################

function start_agent {
  if [ -z "$HOME" ]; then
    return
  fi

  local ssh_env="$HOME/.ssh/env"

  # Check if $ssh_env exists, and if $SSH_AGENT_PID is running
  if [ -f "${ssh_env}" ]; then
      . "${ssh_env}" > /dev/null
      if [[ -n "${SSH_AGENT_PID}" ]]; then
        if ps -ef | grep ${SSH_AGENT_PID}'.*[s]sh-agent' > /dev/null; then
          return
        fi
      fi
  fi

  # If not, start a new ssh-agent
  echo "Initialising new SSH agent..."
  ssh-agent -t 3600 | sed '/^echo/d' > "${ssh_env}"
  echo succeeded
  chmod 600 "${ssh_env}"
  . "${ssh_env}" > /dev/null
  ssh-add;
}
start_agent


##############################
# SOURCE .bashrc
##############################

if [ -f "${HOME}"/.bashrc ]; then
  . "${HOME}"/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.gcloud/path.bash.inc" ]; then . "$HOME/.gcloud/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.gcloud/completion.bash.inc" ]; then . "$HOME/.gcloud/completion.bash.inc"; fi
