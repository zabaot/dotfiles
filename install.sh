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

link vimrc   .vimrc
link zshrc   .zshrc
link tmux.conf .tmux.conf
link bashrc  .bashrc

# vim-plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "vim-plug installed."
fi

echo ""
echo "Done. Next steps:"
echo "  1. Start Vim and run :PlugInstall"
echo "  2. Restart your shell or run: source ~/.zshrc"
