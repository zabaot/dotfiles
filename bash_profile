#tmux256色強制対応エイリアス
#alias tmux="tmux -2"

export LSCOLORS=gxfxcxdxbxegedabagacad
#export HISTCONTROL=ignoreboth
alias ls="ls -GF"

#GitPrompt
if [ -f /opt/local/share/git/git-prompt.sh ]; then
  . /opt/local/share/git/git-prompt.sh
fi

PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '

# MacPorts Installer addition on 2015-09-07_at_13:45:39: adding an appropriate P
ATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
