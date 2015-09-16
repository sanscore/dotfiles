if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"
