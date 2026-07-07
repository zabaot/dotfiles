# Homebrew の補完スクリプトを fpath に追加する
# compinit（zprezto の completion モジュールが呼び出す）より前に追加しないと補完が効かない
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# [個人設定] ls のカラーを Ubuntu 標準（GNU ls）に合わせる
# 前提: brew install coreutils
# zprezto の git モジュールが gls を git log のエイリアスに使っているため、
# GNU ls のバイナリはフルパスで指定する
if [[ -x /opt/homebrew/bin/gls ]]; then
    alias ls='/opt/homebrew/bin/gls --color=auto'
    eval "$(gdircolors -b)"
fi
