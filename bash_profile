if [[ "${OSTYPE}" = "darwin"* ]]; then
  PATH=""
  source /etc/profile
fi

if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

# rbenv
export RBENV_ROOT="${HOME}/.rbenv"
if [[ -d "${RBENV_ROOT}" ]]; then
  export RBENV_BIN="${RBENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${RBENV_BIN}:"* ]] && \
    export PATH="${RBENV_BIN}:${PATH}" && \
    eval "$(rbenv init -)"
fi

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [[ -d "${PYENV_ROOT}" ]]; then
  export PYENV_BIN="${PYENV_ROOT}/bin"
  [[ ":${PATH}:" != *":${PYENV_BIN}:"* ]] && \
    export PATH="${PYENV_BIN}:${PATH}" && \
    eval "$(pyenv init -)" && \
    eval "$(pyenv virtualenv-init -)"
fi
