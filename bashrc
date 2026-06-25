# インタラクティブシェルでなければ何もしない
case $- in
    *i*) ;;
      *) return;;
esac

# 履歴設定
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s histappend

# ウィンドウサイズを毎回チェック
shopt -s checkwinsize

# lesspipe（非テキストファイルを less で開けるようにする）
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# OS ごとの色設定と ls エイリアス
case "$(uname)" in
    Darwin)
        alias ls='ls -FG'
        ;;
    Linux)
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        fi
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        ;;
esac

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# エディタ
export EDITOR=vim
export LANG=ja_JP.UTF-8

# bash 補完
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    fi
fi

# git プロンプト（システムインストール済みのものを優先、なければスキップ）
_git_prompt_candidates=(
    /usr/lib/git-core/git-sh-prompt
    /usr/share/git-core/contrib/completion/git-prompt.sh
    /usr/local/etc/bash_completion.d/git-prompt.sh
    /opt/homebrew/etc/bash_completion.d/git-prompt.sh
    ~/.git-prompt.sh
)
for _f in "${_git_prompt_candidates[@]}"; do
    if [ -f "$_f" ]; then
        GIT_PS1_SHOWDIRTYSTATE=1
        . "$_f"
        PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;31m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
        break
    fi
done
unset _git_prompt_candidates _f

# 履歴をリアルタイムで共有
export PROMPT_COMMAND='history -a; history -r'
