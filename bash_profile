if [[ "${OSTYPE}" = "darwin"* ]]; then
  PATH=""
  . /etc/profile
fi

if [ -f "${HOME}"/.bashrc ]; then
  . "${HOME}"/.bashrc
fi

# Bigger History File
export HISTFILESIZE=400000000
export HISTSIZE=10000

# Ignore lines prepended with a space
export HISTCONTROL=ignoreboth:erasedups

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

# Useful timestamp format
export HISTTIMEFORMAT='%F %T '

## Virtual Managers
# rbenv - Ruby
export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
  export RBENV_BIN="${RBENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${RBENV_BIN}:"* ]] \
    && export PATH="${RBENV_BIN}:${PATH}" \
    && eval "$(rbenv init -)"
else
  echo 'rbenv is not installed.'
fi

# pyenv - Python
export PYENV_ROOT="${HOME}/.pyenv"
if [[ -d "${PYENV_ROOT}" ]]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PYENV_BIN="${PYENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${PYENV_BIN}:"* ]] \
    && export PATH="${PYENV_BIN}:${PATH}" \
    && eval "$(pyenv init -)" \
    && eval "$(pyenv virtualenv-init -)"
else
  echo 'pyenv is not installed.'
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
export NVM_DIR="${HOME}/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh" && . $NVM_DIR/bash_completion
else
  echo 'nvm (Node) is not installed.'
fi

# dvm - Docker
export DVM_DIR="${HOME}/.dvm"
if [[ -s "$DVM_DIR/dvm.sh" ]]; then
  . "$DVM_DIR/dvm.sh" \
    && . $DVM_DIR/bash_completion
fi
