#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
