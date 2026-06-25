# 言語設定
export LANG=ja_JP.UTF-8

# エディタ
export EDITOR=vim

# ビープ音を消す
setopt nolistbeep

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# もしかして機能
setopt correct

# Emacs キーバインド
bindkey -e

# 補完
# -Uz: -U はエイリアス展開を抑制、-z は zsh スタイルのオートロード（公式推奨形式）
autoload -Uz compinit; compinit

# Shift-Tab で補完候補を逆順
bindkey "^[[Z" reverse-menu-complete

# 補完候補を省スペースに
setopt list_packed

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# 補完候補が複数あるとき自動で一覧表示
setopt auto_menu

# 高機能なワイルドカード展開
setopt extended_glob

# ディレクトリ名だけで cd
setopt auto_cd

# cd の履歴を記録
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space
setopt hist_reduce_blanks

# Ctrl+R で履歴検索
bindkey "^R" history-incremental-search-backward

# 色設定
autoload -Uz colors; colors

# LSCOLORS: macOS の BSD ls が参照する色設定（Linux では無視される）
export LSCOLORS=Exfxcxdxbxegedabagacad
# LS_COLORS: Linux の GNU ls・補完候補が参照する色設定（macOS では補完候補の色に使われる）
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
# CLICOLOR: macOS の BSD ls でカラー表示を有効にする（Linux では無視される）
export CLICOLOR=true

# ls・grep のカラー設定（BSD ls と GNU ls でオプションが異なるため OS で分岐）
case "$(uname)" in
    Darwin)
        # macOS: CLICOLOR=true だけで色が付くためエイリアス不要。-F で種別記号を付加
        alias ls='ls -F'
        ;;
    Linux)
        # Linux: GNU ls は --color=auto を明示しないとカラー表示されない
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        ;;
esac

# 補完候補の色を LS_COLORS に合わせる（Mac・Linux 共通）
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# プロンプト（vcs_info でブランチ表示）
autoload -Uz add-zsh-hook vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '[%b|%a] %c%u'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

setopt transient_rprompt
setopt prompt_subst

PROMPT="[%n] %{${fg[yellow]}%}%~%{${reset_color}%}
%{$fg[blue]%}$%{${reset_color}%} "
PROMPT2='[%n]> '
SPROMPT="%{$fg[red]%}もしかして %B%r%b%{$fg[red]%}? [y,n,a,e]: ${reset_color}"
RPROMPT="%1(v|%F{green}%1v%f|)"
