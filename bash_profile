# .bashrc

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# Source bash_completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# User specific aliases and functions
alias ls='ls -F'

# Source git completion
if [ -f ~/.git-completion.bash ]; then
        . ~/.git-completion.bash
fi

# Source git prompt
if [ -f ~/.git-prompt.sh ]; then
# リポジトリの状態によって表示が変わる設定を有効にする
    GIT_PS1_SHOWDIRTYSTATE=1
    . ~/.git-prompt.sh
#    PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
    PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;31m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
fi

export PATH="/usr/local/opt/openssl/bin:$PATH"
