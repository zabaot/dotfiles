# File    : bashrc
# Author  : Yasaka
# Repo    : https://github.com/zabaot/dotfiles
# License : Apache License 2.0
# About   : Ubuntu 向け bash の設定ファイル

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

# ** を再帰的なワイルドカードとして使えるようにする（bash 4.0 以降）
# 例: ls **/*.py → サブディレクトリも含めて全 .py ファイルを列挙
shopt -s globstar

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
    if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
        # Homebrew bash-completion@2（bash 4.2 以降対応・Apple Silicon）
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
        # Ubuntu/Debian 標準インストール
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# git プロンプト（システムインストール済みのものを優先、なければスキップ）
_git_prompt_candidates=(
    /opt/homebrew/share/git-core/contrib/completion/git-prompt.sh
    /usr/lib/git-core/git-sh-prompt
    /usr/share/git-core/contrib/completion/git-prompt.sh
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

# ~/.local/bin を PATH に追加（Ubuntu 26.04 以降のデフォルト）
# pip install --user や pipx でインストールしたコマンドの配置先
export PATH="$HOME/.local/bin:$PATH"
