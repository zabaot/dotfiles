# dotfiles

zsh / vim / tmux / bash の設定ファイル。Mac (Apple Silicon) と Ubuntu Linux で共通利用できる。

## ファイル構成

| ファイル | 用途 |
| ------- | ---- |
| `vimrc` | Vim 設定（vim-plug でプラグイン管理） |
| `zshrc` | Zsh 設定（zprezto がない Ubuntu 向け） |
| `zpreztorc` | zprezto モジュール・プロンプト・キーバインド設定（Mac 向け） |
| `tmux.conf` | tmux 設定（Mac / Linux 自動判別） |
| `bashrc` | Bash 設定（zsh が使えない環境向け） |
| `install.sh` | シンボリックリンク作成 + vim-plug インストール |

## セットアップ

```zsh
git clone <このリポジトリのURL> ~/dotfiles
cd ~/dotfiles
./install.sh
```

> `./install.sh` はシェバン行 `#!/usr/bin/env bash` により、
> zsh から実行しても自動的に bash で動作します。

### install.sh が行うこと

### Mac（zprezto あり）

1. `~/.vimrc`, `~/.tmux.conf`, `~/.bashrc` → シンボリックリンクを作成
2. `~/.zpreztorc` → dotfiles の `zpreztorc` へのシンボリックリンクを作成
   - `.zshrc` / `.zprofile` は zprezto が管理するため変更しない
3. vim-plug を自動インストール

### Ubuntu（zprezto なし）

1. `~/.vimrc`, `~/.zshrc`, `~/.tmux.conf`, `~/.bashrc` → シンボリックリンクを作成
2. vim-plug を自動インストール

既存ファイルは `.bak.YYYYMMDDHHMMSS` にバックアップされます。

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
