if [[ "${OSTYPE}" = "darwin"* ]]; then
  PATH=""
  . /etc/profile
fi

if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

## Virtual Managers

# rbenv - Ruby
export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
  export RBENV_BIN="${RBENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${RBENV_BIN}:"* ]] && \
    export PATH="${RBENV_BIN}:${PATH}" && \
    eval "$(rbenv init -)"
fi

# pyenv - Python
export PYENV_ROOT="${HOME}/.pyenv"
if [[ -d "${PYENV_ROOT}" ]]; then
  export PYENV_BIN="${PYENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${PYENV_BIN}:"* ]] && \
    export PATH="${PYENV_BIN}:${PATH}" && \
    eval "$(pyenv init -)"
fi

# nvm - Node
export NVM_DIR="${HOME}/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  . "$NVM_DIR/nvm.sh" && . $NVM_DIR/bash_completion
fi
