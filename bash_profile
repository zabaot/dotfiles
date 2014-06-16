[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
ENV=$(uname -s | awk '{print $1}' | sed -e "s/_.*//g")
if [ $ENV = "CYGWIN" ] ; then
  alias lv="TERM=cygwin lv"
  export PAGER=lv
  PS1='[ \[\e[1;36m\]\w \[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
  alias ls="ls --color=yes -F"
#elif [ $ENV="darwin" ] || [ $ENV="Linux" ] ; then
else
#  screen -xR
  PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
  alias ls="ls -GF"
fi

#tmux256色強制対応エイリアス
alias tmux="tmux -2"

#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoreboth

export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# MacPorts Bash shell command completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

#GitPrompt
if [ -f /opt/local/share/git/git-prompt.sh ]; then
  . /opt/local/share/git/git-prompt.sh
fi


