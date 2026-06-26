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
