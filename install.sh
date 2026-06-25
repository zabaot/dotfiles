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

echo "=== dotfiles install ==="

# --- 全環境共通 ---
link vimrc     .vimrc
link tmux.conf .tmux.conf

# --- シェル設定: OS のデフォルトシェルに応じて分岐 ---
if [ -d "$HOME/.zprezto" ]; then
    # Mac: zsh + zprezto
    # .zshrc は zprezto が管理するためリンクしない
    link zpreztorc .zpreztorc
    link prompt_mysorin_setup .zprezto/modules/prompt/functions/prompt_mysorin_setup
    echo "Note: .zshrc is managed by zprezto, skipped."
else
    # Ubuntu: bash
    link bashrc .bashrc
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
