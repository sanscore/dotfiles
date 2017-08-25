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
  eval "$(rbenv init -)"
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

  eval "$(pyenv init -)"
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
  . "$NVM_DIR/nvm.sh" && . $NVM_DIR/bash_completion
else
  echo 'nvm (Node) is not installed.'
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

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

##############################
# SOURCE .bashrc
##############################

if [ -f "${HOME}"/.bashrc ]; then
  . "${HOME}"/.bashrc
fi
