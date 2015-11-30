#tmux256色強制対応エイリアス
#alias tmux="tmux -2"

export LSCOLORS=gxfxcxdxbxegedabagacad
#export HISTCONTROL=ignoreboth
alias ls="ls -GF"

export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'

#GitPrompt
if [ -f /opt/local/share/git/git-prompt.sh ]; then
  . /opt/local/share/git/git-prompt.sh
fi

PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

# MacPorts Installer addition on 2015-09-07_at_13:45:39: adding an appropriate P
#PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

#pyenv environment
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

