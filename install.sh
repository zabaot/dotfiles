#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME/$2"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$dst" "$backup"
        echo "Backed up: $dst -> $backup"
    fi
    ln -sf "$src" "$dst"
    echo "Linked: $dst -> $src"
}

# zshrc / bashrc は直接シンボリックリンクにしない。
# Claude Code や grok など各種インストーラーが `~/.zshrc` / `~/.bashrc` に
# 直接 `>>` で追記するため、シンボリックリンクだとリポジトリ内の実体ファイルが
# 汚れて git diff に無関係な変更が出続けてしまう。
# 代わりにホーム側を「source するだけの実ファイル」にして、インストーラーの
# 追記先をリポジトリの外（git 管理外）に逃がす。
link_via_source() {
    local src="$DOTFILES_DIR/$1"
    local dst="$HOME/$2"
    local loader_line="[[ -f \"$src\" ]] && source \"$src\""

    if [ -L "$dst" ]; then
        rm "$dst"
    fi

    if [ -f "$dst" ] && grep -qF "$loader_line" "$dst"; then
        echo "Already set up: $dst -> source $src"
        return
    fi

    if [ -e "$dst" ]; then
        local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
        mv "$dst" "$backup"
        echo "Backed up: $dst -> $backup"
    fi

    echo "$loader_line" > "$dst"
    echo "Set up loader: $dst -> source $src (installer が追記してもリポジトリは汚れない)"
}

echo "=== dotfiles install ==="

# --- 全環境共通 ---
link vimrc     .vimrc
link tmux.conf .tmux.conf

# --- シェル設定: OS のデフォルトシェルに応じて分岐 ---
if [ -d "$HOME/.zprezto" ]; then
    # Mac: zsh + zprezto
    link_via_source zshrc .zshrc
    link zpreztorc .zpreztorc
    link prompt_mysorin_setup .zprezto/modules/prompt/functions/prompt_mysorin_setup
else
    # Ubuntu: bash
    link_via_source bashrc .bashrc
fi

# --- vim-plug ---
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "vim-plug installed."
fi

echo ""
echo "Done. Next steps:"
echo "  1. Start Vim and run :PlugInstall"
if [ -d "$HOME/.zprezto" ]; then
    echo "  2. Restart your shell or run: source ~/.zshrc"
else
    echo "  2. Restart your shell or run: source ~/.bashrc"
fi
