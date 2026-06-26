# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# [個人設定] ls のカラーを Ubuntu 標準（GNU ls）に合わせる
# 前提: brew install coreutils（gls・gdircolors が使用可能になる）
# zprezto の utility モジュールが gls を検出して ls にエイリアスするため、
# LS_COLORS を設定するだけで ls の色が Ubuntu と同じになる
if command -v gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors -b)"
fi
