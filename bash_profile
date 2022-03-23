##############################
# Debug Echo
##############################

echo_debug() {
  if [ ! -z "${DEBUG}" ]; then
    echo "$@" >&2
  fi
}

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
  [[ ! -d "$1" ]] && return 1
  [[ ":$PATH:" = *":$1:"* ]] && return 0

  export PATH="$1:$PATH"
}

__add_path "${HOME}/bin"
__add_path "${HOME}/local/bin"
__add_path "${HOME}/.local/bin"


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
if __add_path "${RBENV_ROOT}/bin"; then
  if [[ ":$PATH:" != *":${RBENV_ROOT}/shims:"* ]]
  then
    eval "$(rbenv init - --no-rehash)"
  fi

  [ -f "${RBENV_ROOT}/completions/rbenv.bash" ] && source "${RBENV_ROOT}/completions/rbenv.bash"

  up-rbenv () {
    for repo in "$RBENV_ROOT" "$RBENV_ROOT"/plugins/*; do
      echo $( basename $repo )
      ( git -C $repo pull --ff-only )
    done
  }
else
  cat <<-EOF
	rbenv missing!
	  git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
	  mkdir -p "$RBENV_ROOT/plugins"
	  git clone https://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"
	EOF
fi

# pyenv - Python
export PYENV_ROOT="${HOME}/.pyenv"
if __add_path "${PYENV_ROOT}/bin" && __add_path "${PYENV_ROOT}/shims"
then
  eval "$(pyenv init - --no-rehash)"

  up-pyenv () {
    for repo in "$PYENV_ROOT" "$PYENV_ROOT"/plugins/*; do
      echo $( basename $repo )
      ( git -C $repo pull --ff-only )
    done
  }

  each_python () 
  { 
      for version_path in $PYENV_ROOT/versions/*
      do
        local version=$(basename $version_path)
        echo $version;
        PYENV_VERSION=$version "$@";
      done
  }
else
  cat <<-EOF
	pyenv missing!
	 git clone https://github.com/pyenv/pyenv.git ~/.pyenv
	EOF
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
export NVM_ROOT="${HOME}/.nvm"
if [[ -s "${NVM_ROOT}/nvm.sh" ]]; then
  . "$NVM_ROOT/nvm.sh" && . $NVM_ROOT/bash_completion

  up-nvm () {
    (
      cd "${NVM_ROOT}"
      git fetch --tags origin
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git  rev-list --tags --max-count=1)`
    ) && . "$NVM_ROOT/nvm.sh" && . $NVM_ROOT/bash_completion
  }
else
  cat <<-EOF
	nvm missing!
	  git clone https://github.com/nvm-sh/nvm.git "$NVM_ROOT"
	  cd "$NVM_ROOT"
	  git checkout \`git describe --abbrev=0 --tags --match "v[0-9]*" \$(git rev-list --tags --max-count=1)\`
	EOF
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


##############################
# SSH-AGENT
##############################
start_agent() {
  DEBUG=

  : Ignore GNOME Keyring - SSH
  if [[ "${SSH_AUTH_SOCK}" = "/run/user/$UID/keyring/ssh" ]]; then
    echo_debug "unsetting SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
    unset SSH_AUTH_SOCK
  fi

  : Return if SSH_AUTH_SOCK is set and the socket exists
  if [[ ! -z "${SSH_AUTH_SOCK}" && -S ${SSH_AUTH_SOCK} ]]; then
    echo_debug "found SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
    echo_debug "$(ls -halF $SSH_AUTH_SOCK)"
    return
  fi

  : Return if HOME is unset
  if [ -z "$HOME" ]; then
    echo_debug "HOME is unset."
    return
  fi
  local ssh_env="$HOME/.ssh/env"

  : Check if $ssh_env exists
  if [ -f "${ssh_env}" ]; then
    echo_debug "sourcing: $ssh_env"
    . "${ssh_env}" > /dev/null

    : verify that $SSH_AGENT_PID is running
    if [[ ! -z "${SSH_AGENT_PID}" ]]; then
      if ps -ef | grep ${SSH_AGENT_PID}'.*[s]sh-agent' > /dev/null; then
        echo_debug "$SSH_AGENT_PID is running."
        return
      fi
    fi
  fi

  : If not, start a new ssh-agent
  echo_debug "Initialising new SSH agent..."
  ssh-agent -t 1d | sed '/^echo/d' > "${ssh_env}"
  chmod 600 "${ssh_env}"
  . "${ssh_env}" > /dev/null

  echo_debug "SSH_AUTH_SOCK: $SSH_AUTH_SOCK"
  echo_debug "SSH_AGENT_PID: $SSH_AGENT_PID"
  ssh-add;
}
start_agent


shopt -s nullglob
for profile in $HOME/.bash_profile.*
do
  source $profile
done
shopt -u nullglob

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
