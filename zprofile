# zprezto 本家の zprofile は EDITOR / VISUAL が未設定のときだけ nano を設定するため、
# 読み込む前に設定しておくことで vim を使わせる
export EDITOR='vim'
export VISUAL='vim'

# zprezto 本家の zprofile を読み込む（本家の更新をそのまま取り込むため、コピーせず source する）
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi
