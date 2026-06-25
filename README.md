# dotfiles

Vim / tmux / Bash / Zsh の個人設定ファイル集。
**macOS (Apple Silicon)** と **Ubuntu Linux** の両環境で動作します。

シェルはそれぞれの OS のデフォルトを使用します。
macOS: zsh（zprezto）、Ubuntu: bash

## 動作確認環境

| 環境 | バージョン |
| ---- | ---------- |
| macOS (Apple Silicon) | Sequoia 以降 |
| Ubuntu Linux | 26.04 LTS |
| Vim | 9.x |
| tmux | 3.x |
| Zsh | 5.x（macOS のみ） |
| Bash | 5.x（Ubuntu のみ） |

---

## ファイル構成

| ファイル | 説明 |
| -------- | ---- |
| `vimrc` | Vim の設定ファイル。vim-plug でプラグインを管理 |
| `zpreztorc` | zprezto のモジュール・プロンプト・キーバインド設定（Mac 向け） |
| `tmux.conf` | tmux の設定ファイル。Mac / Linux を自動判別 |
| `bashrc` | Bash の設定ファイル（Ubuntu 向け） |
| `install.sh` | シンボリックリンクの作成と vim-plug のインストールを自動化するスクリプト |
| `LICENSE` | Apache License 2.0 |

---

## 事前準備

### Mac

以下のツールが必要です。[Homebrew](https://brew.sh) でインストールできます。

```zsh
# Vim・tmux・Git のインストール
brew install vim tmux git

# zprezto のインストール（zsh フレームワーク）
# 公式手順: https://github.com/sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
```

### Ubuntu

```bash
sudo apt update
sudo apt install vim tmux git ncurses-term
```

> `ncurses-term` は tmux の `tmux-256color` ターミナルタイプに必要です。

---

## セットアップ

```zsh
git clone https://github.com/zabaot/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

> `./install.sh` はシェバン行 `#!/usr/bin/env bash` により、
> zsh から実行しても自動的に bash で動作します。

### install.sh が行うこと

#### Mac（zprezto インストール済みの場合）

1. `~/.vimrc` → `~/dotfiles/vimrc` へのシンボリックリンクを作成
2. `~/.tmux.conf` → `~/dotfiles/tmux.conf` へのシンボリックリンクを作成
3. `~/.bashrc` → `~/dotfiles/bashrc` へのシンボリックリンクを作成
4. `~/.zpreztorc` → `~/dotfiles/zpreztorc` へのシンボリックリンクを作成
   - `.zshrc` と `.zprofile` は zprezto が管理するため変更しません
5. vim-plug（Vim のプラグインマネージャー）を自動インストール

#### Ubuntu（bash）

1. `~/.vimrc` → `~/dotfiles/vimrc`
2. `~/.tmux.conf` → `~/dotfiles/tmux.conf`
3. `~/.bashrc` → `~/dotfiles/bashrc`
4. vim-plug を自動インストール

> 既存のファイルは上書きされず、`.bak.YYYYMMDDHHMMSS` という名前でバックアップされます。

### Vim プラグインのインストール

`install.sh` 実行後、Vim を起動して以下のコマンドを実行してください。

```bash
vim +PlugInstall +qall
```

---

## Vim の主な機能・キー操作

### プラグイン一覧

| プラグイン | 用途 |
| ---------- | ---- |
| [tomasr/molokai](https://github.com/tomasr/molokai) | カラースキーム |
| [junegunn/fzf](https://github.com/junegunn/fzf) + [fzf.vim](https://github.com/junegunn/fzf.vim) | ファイル・バッファのあいまい検索 |
| [prabirshrestha/vim-lsp](https://github.com/prabirshrestha/vim-lsp) | LSP クライアント（コード補完・定義ジャンプ・エラー表示） |
| [mattn/vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) | 言語サーバーの自動セットアップ |
| [prabirshrestha/asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) | 非同期補完エンジン |

### キー操作一覧

| キー | モード | 動作 |
| ---- | ------ | ---- |
| `Ctrl+P` | ノーマル | プロジェクト内のファイルをあいまい検索して開く |
| `Ctrl+B` | ノーマル | 開いているバッファ（ファイル）の一覧を表示 |
| `gd` | ノーマル | カーソル下のシンボルの定義元へジャンプ |
| `gr` | ノーマル | カーソル下のシンボルの参照箇所を一覧表示 |
| `K` | ノーマル | カーソル下のシンボルのドキュメントをポップアップ表示 |
| `Tab` | 入力 | 補完候補を次へ進む（候補がないときは通常のタブ） |
| `Shift+Tab` | 入力 | 補完候補を前へ戻る |
| `Enter` | 入力 | 補完候補を確定する（候補がないときは通常の改行） |
| `Ctrl+L` | ノーマル | 検索ハイライトを消去して画面を再描画 |

---

## ライセンス

[Apache License 2.0](LICENSE)
