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

__check_path() {
  [[ -d "$1" && ":$PATH:" != *":$1:"* ]] || (echo "WARN: $1 is missing."; echo "PATH=$PATH"; return 1)
}

# Setup PATH
if [[ "${OSTYPE}" = "darwin"* ]]; then
  export PATH=""
  . /etc/profile

  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

  # Already added by /etc/profile
  # USR_LOCAL_BIN="/usr/local/bin"
  # __check_path "${USR_LOCAL_BIN}" && export PATH="${USR_LOCAL_BIN}:${PATH}"

  USR_LOCAL_SBIN="/usr/local/sbin"
  __check_path "${USR_LOCAL_SBIN}" && export PATH="${USR_LOCAL_SBIN}:${PATH}"

  COREUTILS_GNUBIN="/usr/local/opt/coreutils/libexec/gnubin/"
  __check_path "${COREUTILS_GNUBIN}" && export PATH="${COREUTILS_GNUBIN}:${PATH}"

  SED_GNUBIN="/usr/local/opt/gnu-sed/libexec/gnubin"
  __check_path "${SED_GNUBIN}" && export PATH="${SED_GNUBIN}:${PATH}"

  OPENSSL_BIN="/usr/local/opt/openssl/bin"
  __check_path "${OPENSSL_BIN}" && export PATH="${OPENSSL_BIN}:$PATH"

  CURL_OPENSSL_BIN="/usr/local/opt/curl-openssl/bin"
  __check_path "${CURL_OPENSSL_BIN}" && export PATH="${CURL_OPENSSL_BIN}:${PATH}"

  GETTEXT_BIN="/usr/local/opt/gettext/bin"
  __check_path "${GETTEXT_BIN}" && export PATH="${GETTEXT_BIN}:${PATH}"
fi

##############################
# VIRTUAL MANAGERS
##############################

# rbenv - Ruby
if __check_path "${HOME}/.rbenv/bin"; then
  export RBENV_ROOT="${HOME}/.rbenv"
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
  rbenv-up () {
    for repo in "$RBENV_ROOT" "$RBENV_ROOT"/plugins/*; do
      echo $( basename $repo )
      ( git -C $repo pull )
    done
  }
fi

# pyenv - Python
if __check_path "${HOME}/.pyenv/bin"; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"

  eval "$(pyenv init - --no-rehash)"

  pyenv-up () {
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
  . "$NVM_DIR/nvm.sh" --no-use && . $NVM_DIR/bash_completion

  nvm-up () {
    git -C "${HOME}/.nvm" pull
  }
fi

up-up() {
  for version_manager in rbenv pyenv nvm
  do
    echo ${version_manager}
    if type ${version_manager}-up &>/dev/null
    then 
      ${version_manager}-up
    else
      echo ${version_manager}-up not found
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
if __check_path "${HOME}/bin"; then
  export PATH="${HOME}/bin:${PATH}"
fi


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
