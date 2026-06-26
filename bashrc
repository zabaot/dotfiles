# File    : bashrc
# Author  : Yasaka
# Repo    : https://github.com/zabaot/dotfiles
# License : Apache License 2.0
# About   : Ubuntu 向け bash の設定ファイル
#           Ubuntu 26.04 LTS のデフォルト ~/.bashrc をベースに個人設定を追加
#           [個人設定] と記載のある箇所がデフォルトからの変更・追加

# インタラクティブシェルでなければ何もしない
case $- in
    *i*) ;;
      *) return;;
esac

# ─── 履歴 ────────────────────────────────────────────────────────────────────
# 重複コマンドと先頭スペース付きコマンドを履歴に残さない
HISTCONTROL=ignoreboth
# シェル終了時に履歴ファイルを上書きせず追記する（複数セッションで履歴を保全）
shopt -s histappend
# 保存件数 [個人設定: デフォルト 1000/2000 より多く保存]
HISTSIZE=100000
HISTFILESIZE=200000

# ─── シェルオプション ─────────────────────────────────────────────────────────
# コマンド実行後にターミナルのウィンドウサイズ（LINES・COLUMNS）を再確認する
shopt -s checkwinsize
# ** を再帰的なワイルドカードとして使えるようにする（bash 4.0 以降）
# 例: ls **/*.py → サブディレクトリも含めて全 .py ファイルを列挙
# [個人設定: Ubuntu デフォルトはコメントアウト。bash 5.x では有効化する]
shopt -s globstar

# ─── less 拡張 ────────────────────────────────────────────────────────────────
# 非テキストファイル（zip・PDF など）を less で開けるようにする
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ─── カラー設定・エイリアス ───────────────────────────────────────────────────
# dircolors で ls の色設定を読み込み、ls・grep をカラー表示にする
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

alias ll='ls -alF'  # 詳細一覧（隠しファイル含む）
alias la='ls -A'    # 隠しファイルも表示
alias l='ls -CF'    # 種別記号付き一覧

# ─── 環境変数 ─────────────────────────────────────────────────────────────────
# ~/.local/bin を PATH に追加（Ubuntu 26.04 デフォルト）
# pip install --user や pipx でインストールしたコマンドの配置先
export PATH="$HOME/.local/bin:$PATH"
# [個人設定]
export EDITOR=vim
export LANG=ja_JP.UTF-8

# ─── bash 補完 ────────────────────────────────────────────────────────────────
if ! shopt -oq posix; then
    if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
        # [個人設定] Homebrew bash-completion@2（Apple Silicon Mac 向け）
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    elif [ -f /usr/share/bash-completion/bash_completion ]; then
        # Ubuntu 標準インストール
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ─── プロンプト ───────────────────────────────────────────────────────────────
# [個人設定] デフォルト PS1 を git ブランチ・変更状態付きプロンプトに置き換え
# git-prompt.sh が見つかった場合のみ有効。見つからない場合は Ubuntu デフォルト相当にフォールバック
_git_prompt_candidates=(
    /opt/homebrew/share/git-core/contrib/completion/git-prompt.sh  # Homebrew git (Mac)
    /usr/lib/git-core/git-sh-prompt                                 # Ubuntu apt git
    /usr/share/git-core/contrib/completion/git-prompt.sh            # Ubuntu 新パス
    ~/.git-prompt.sh                                                 # 手動配置
)
_loaded_git_prompt=0
for _f in "${_git_prompt_candidates[@]}"; do
    if [ -f "$_f" ]; then
        GIT_PS1_SHOWDIRTYSTATE=1  # 未コミットの変更がある場合に * を表示
        . "$_f"
        PS1='[\[\e[1;32m\]\u@\h \[\e[1;36m\]\w\[\e[1;31m\]$(__git_ps1 " (%s)")\[\e[0m\]]\$ '
        _loaded_git_prompt=1
        break
    fi
done
if [ "$_loaded_git_prompt" -eq 0 ]; then
    # フォールバック: Ubuntu デフォルト相当のカラープロンプト
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi
unset _git_prompt_candidates _f _loaded_git_prompt

# xterm 系ターミナルのタイトルバーに user@host: dir を表示する
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
esac

# [個人設定] 複数ターミナルセッション間でコマンド履歴をリアルタイムに共有する
# history -a: 現在のセッションの履歴をファイルに書き出す
# history -r: ファイルから最新の履歴を読み込む
export PROMPT_COMMAND='history -a; history -r'
