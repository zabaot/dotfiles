PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# 基本設定
# ----------------------------
# 言語設定
export LANG=ja_JP.UTF-8

# エディタはvim
export EDITOR=vim

# PCRE 互換の正規表現を使う
setopt re_match_pcre

# ビープ音を消す
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# もしかして機能
setopt correct

# Ctrl + a とかやりたい
bindkey -e

# Ctrl + r で履歴さかのぼり
bindkey "^R" history-incremental-search-backward

# 補完機能
# ----------------------------
# 補完機能をON
autoload -U compinit; compinit

# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete

# 補完候補を省スペースに
setopt list_packed

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# ディレクトリ名だけでcdする
setopt auto_cd

# cdの履歴を記録
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# タイポを訂正
setopt correct

# 履歴関連
# ----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# 重複する履歴は無視
setopt hist_ignore_dups

# 履歴を共有
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

 # ヒストリに保存するときに余分なスペースを削除する
 setopt hist_reduce_blanks


# 色の設定
# ----------------------------
# 色の定義
DEFAULT=$"%{\e[0;0m%}"
RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
MAGENTA="%{${fg[magenta]}%}"
WHITE="%{${fg[white]}%}"

autoload -Uz colors; colors
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ZLS_COLORS？
export ZLS_COLORS=$LS_COLORS

# lsコマンド時、自動で色がつく
export CLICOLOR=true

# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# プロンプトの設定
# ----------------------------
# Gitの情報とか
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '[%s: %b]'
zstyle ':vcs_info:*' actionformats '[%s: %b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
      zstyle ':vcs_info:git:*' stagedstr "+"
        zstyle ':vcs_info:git:*' unstagedstr "-"
          zstyle ':vcs_info:git:*' formats '[%s: %b] %c%u'
            zstyle ':vcs_info:git:*' actionformats '[%s: %b|%a] %c%u'
            fi

            function _update_vcs_info_msg() {
                psvar=()
                  LANG=en_US.UTF-8 vcs_info
                    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
            }
            add-zsh-hook precmd _update_vcs_info_msg

# コマンドを実行するときに右プロンプトを消す
setopt transient_rprompt

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

PROMPT="[%n] %{${fg[yellow]}%}%~%{${reset_color}%}
%{$fg[blue]%}$%{${reset_color}%} "

# プロンプト指定(コマンドの続き)
PROMPT2='[%n]> '

# もしかして時のプロンプト指定
SPROMPT="%{$fg[red]%}%{$suggest%}もしかして %B%r%b %{$fg[red]%}? [y,n,a,e]:${reset_color} "

RPROMPT="%1(v|%F{green}%1v%f|)"
