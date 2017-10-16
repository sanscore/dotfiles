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

# Setup PATH
if [[ "${OSTYPE}" = "darwin"* ]]; then
  PATH=""
  . /etc/profile
fi

__check_path() {
  [[ -d "$1" && ":$PATH:" != *":$1:"* ]] || return 1
}

# /usr/local/bin
if __check_path "/usr/local/bin"; then
  export PATH="/usr/local/bin:${PATH}"
fi

# /usr/local/sbin
if __check_path "/usr/local/sbin"; then
  export PATH="/usr/local/sbin:${PATH}"
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
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1

  eval "$(pyenv init - --no-rehash)"
  eval "$(pyenv virtualenv-init -)"

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

# dvm - Docker
if [[ -s "${HOME}/.dvm/dvm.sh" ]]; then
  export DVM_DIR="${HOME}/.dvm"
  . "$DVM_DIR/dvm.sh" \
    && . $DVM_DIR/bash_completion
fi

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
  local ssh_env="$HOME/.ssh/env"

  # Check if $ssh_env exists, and if $SSH_AGENT_PID is running
  if [ -f "${ssh_env}" ]; then
      . "${ssh_env}" > /dev/null
      if ps -ef | grep ${SSH_AGENT_PID}'.*[s]sh-agent' > /dev/null; then
        return
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
