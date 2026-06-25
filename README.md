# dotfiles

zsh / vim / tmux / bash の設定ファイル。Mac (Apple Silicon) と Ubuntu Linux で共通利用できる。

## ファイル構成

| ファイル | 用途 |
| ------- | ---- |
| `vimrc` | Vim 設定（vim-plug でプラグイン管理） |
| `zshrc` | Zsh 設定 |
| `tmux.conf` | tmux 設定（Mac / Linux 自動判別） |
| `bashrc` | Bash 設定（zsh が使えない環境向け） |
| `install.sh` | シンボリックリンク作成 + vim-plug インストール |

## セットアップ

```bash
git clone <このリポジトリのURL> ~/dotfiles
cd ~/dotfiles
bash install.sh
```

### install.sh が行うこと

1. `~/.vimrc`, `~/.zshrc`, `~/.tmux.conf`, `~/.bashrc` → リポジトリ内ファイルへのシンボリックリンクを作成
   - 既存ファイルは `.bak.YYYYMMDDHHMMSS` にバックアップ
2. vim-plug (`~/.vim/autoload/plug.vim`) を自動インストール

### Vim プラグインのインストール

```bash
vim +PlugInstall +qall
```

## Vim プラグイン一覧

| プラグイン | 用途 |
| --------- | ---- |
| [tomasr/molokai](https://github.com/tomasr/molokai) | カラースキーム |
| [junegunn/fzf](https://github.com/junegunn/fzf) | ファジーファインダー本体 |
| [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) | Vim 統合（`<C-p>` でファイル検索） |
| [prabirshrestha/vim-lsp](https://github.com/prabirshrestha/vim-lsp) | LSP クライアント（コード補完・定義ジャンプ） |
| [mattn/vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) | 言語サーバーの自動セットアップ |
| [prabirshrestha/asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) | 非同期補完エンジン |
| [prabirshrestha/asyncomplete-lsp.vim](https://github.com/prabirshrestha/asyncomplete-lsp.vim) | LSP と asyncomplete の接続 |

## 動作確認環境

- macOS (Apple Silicon) + Vim 9.x
- Ubuntu 26.04 LTS + Vim 9.x
