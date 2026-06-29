# dotfiles

macOS と Ubuntu Linux で同じ開発環境を素早く再現するための個人設定ファイル集です。
Vim・tmux・シェル（zsh / bash）の設定を一元管理し、新しいマシンでも `./install.sh` 一発でセットアップが完了します。

## 設計方針

- **シェルは OS のデフォルトを使う**: macOS は zsh（zprezto で管理）、Ubuntu は bash
- **フラット構成**: 設定ファイルをサブディレクトリに分けず、リポジトリ直下に並べる
- **レガシー排除**: 非推奨ツールは使わない。常に最新バージョンを前提とする
- **シンボリックリンク方式**: `install.sh` は設定ファイルをコピーせずシンボリックリンクを作成する。リポジトリ内のファイルを編集すれば即座に反映される

---

## 動作確認環境

| 環境 | バージョン |
| ---- | ---------- |
| macOS (Apple Silicon) | Sequoia 以降 |
| Ubuntu Linux | 26.04 LTS |
| Vim | 9.x |
| tmux | 3.x |
| Zsh | 5.9 以降（macOS のみ） |
| Bash | 5.x（Ubuntu のみ） |

---

## ファイル構成

| ファイル | 対象環境 | 説明 |
| -------- | -------- | ---- |
| `vimrc` | 共通 | Vim の設定。vim-plug でプラグインを管理 |
| `tmux.conf` | 共通 | tmux の設定。Mac / Linux を自動判別 |
| `zshrc` | Mac | Zsh の個人設定（ls カラーを Ubuntu 標準に合わせるなど） |
| `zpreztorc` | Mac | zprezto のモジュール・プロンプト・キーバインド設定 |
| `prompt_mysorin_setup` | Mac | zsh プロンプトのカスタムテーマ（zprezto の `sorin` テーマをベースに改変） |
| `bashrc` | Ubuntu | Bash の設定 |
| `install.sh` | 共通 | シンボリックリンクの作成と vim-plug の自動インストール |
| `LICENSE` | — | Apache License 2.0 |

---

## 事前準備

### Mac

[Homebrew](https://brew.sh) がインストール済みであることを前提とします。

```zsh
# 必要ツールのインストール
brew install vim tmux git

# GNU coreutils のインストール（ls のカラー表示を Ubuntu 標準に合わせるために必要）
# gls（GNU ls）と gdircolors が含まれる
# インストール後は ls コマンドが自動的に gls に切り替わり、Ubuntu と同じ色表示になる
brew install coreutils
```

次に、zsh フレームワーク [zprezto](https://github.com/sorin-ionescu/prezto) をインストールします。
zprezto は `.zshrc`・`.zprofile` などを管理するフレームワークです。

```zsh
# zprezto のインストール（公式手順）
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# zprezto が用意するデフォルトの設定ファイルをホームディレクトリにリンク
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```

> この時点では `.zpreztorc` が zprezto のデフォルトのものになっています。
> 後述の `install.sh` を実行すると、このリポジトリの `zpreztorc` に差し替えられます。

### Ubuntu

```bash
sudo apt update
sudo apt install vim tmux git ncurses-term
```

> `ncurses-term` は tmux の `tmux-256color` ターミナルタイプの定義ファイルを含むパッケージです。
> インストールしないと tmux 起動時に `unknown terminal: tmux-256color` エラーが発生します。

---

## セットアップ

clone 先のディレクトリはどこでも構いません。`install.sh` は自分のある場所を基準に動作します。

```bash
git clone https://github.com/zabaot/dotfiles.git ~/dotfiles  # 任意のパスに変更可
cd ~/dotfiles
./install.sh
```

> `install.sh` のシェバン行は `#!/usr/bin/env bash` です。zsh から実行しても bash で動作します。

### install.sh が行うこと

#### Mac（zsh + zprezto）

1. `~/.vimrc` → `<dotfiles>/vimrc` へのシンボリックリンクを作成
2. `~/.tmux.conf` → `<dotfiles>/tmux.conf` へのシンボリックリンクを作成
3. `~/.zshrc` → `<dotfiles>/zshrc` へのシンボリックリンクを作成
   - zprezto の初期化と ls カラー設定を含む（内部で zprezto の `init.zsh` を source している）
4. `~/.zpreztorc` → `<dotfiles>/zpreztorc` へのシンボリックリンクを作成
5. `~/.zprezto/modules/prompt/functions/prompt_mysorin_setup` → `<dotfiles>/prompt_mysorin_setup` へのシンボリックリンクを作成
6. vim-plug（Vim のプラグインマネージャー）を自動インストール

#### Ubuntu（bash）

1. `~/.vimrc` → `<dotfiles>/vimrc`
2. `~/.tmux.conf` → `<dotfiles>/tmux.conf`
3. `~/.bashrc` → `<dotfiles>/bashrc`
4. vim-plug を自動インストール

> `<dotfiles>` は clone 先の実際のパスに読み替えてください。
> 既存のファイルは上書きされず、`.bak.YYYYMMDDHHMMSS` という名前でバックアップされます。

### Vim プラグインのインストール

`install.sh` 実行後、Vim を起動して以下のコマンドを実行してください。

```vim
:PlugInstall
```

全プラグインのダウンロードと初期セットアップが行われます。

---

## Vim の設定詳細

### プラグイン一覧

| プラグイン | 用途 |
| ---------- | ---- |
| [tomasr/molokai](https://github.com/tomasr/molokai) | ダークカラースキーム |
| [junegunn/fzf](https://github.com/junegunn/fzf) + [fzf.vim](https://github.com/junegunn/fzf.vim) | ファイル・バッファのあいまい検索 |
| [prabirshrestha/vim-lsp](https://github.com/prabirshrestha/vim-lsp) | LSP クライアント（コード補完・定義ジャンプ・エラー表示） |
| [mattn/vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) | 言語サーバーの自動セットアップ |
| [prabirshrestha/asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) + [asyncomplete-lsp.vim](https://github.com/prabirshrestha/asyncomplete-lsp.vim) | 非同期補完エンジン（LSP と接続） |

### LSP（Language Server Protocol）について

LSP はコード補完・定義ジャンプ・エラー表示を提供する仕組みです。
`vim-lsp-settings` が言語サーバーの自動インストールを担当しており、対応ファイルを開くと次のメッセージが表示されます。

```text
Please do :LspInstallServer to enable Language Server <サーバー名>
```

その場で `:LspInstallServer` を実行すると、各言語のサーバーが自動でインストールされます。
インストール不要の言語は何もしなくて構いません。

対応言語の一覧は [vim-lsp-settings の README](https://github.com/mattn/vim-lsp-settings) を参照してください。

### キー操作一覧

| キー | モード | 動作 |
| ---- | ------ | ---- |
| `Ctrl+P` | ノーマル | プロジェクト内のファイルをあいまい検索して開く（fzf） |
| `Ctrl+B` | ノーマル | 開いているバッファ（ファイル）の一覧を表示（fzf） |
| `gd` | ノーマル | カーソル下のシンボルの定義元へジャンプ（LSP） |
| `gr` | ノーマル | カーソル下のシンボルの参照箇所を一覧表示（LSP） |
| `K` | ノーマル | カーソル下のシンボルのドキュメントをポップアップ表示（LSP） |
| `Tab` | 入力 | 補完候補を次へ進む（候補がないときは通常のタブ） |
| `Shift+Tab` | 入力 | 補完候補を前へ戻る |
| `Enter` | 入力 | 補完候補を確定する（候補がないときは通常の改行） |
| `Ctrl+L` | ノーマル | 検索ハイライトを消去して画面を再描画 |

---

## tmux の設定詳細

### 主な設定内容

| 設定 | 値 | 説明 |
| ---- | -- | ---- |
| `default-terminal` | `tmux-256color` | 24bit カラー対応のターミナルタイプ（tmux 3.x 推奨） |
| `escape-time` | 10ms | Esc キーの遅延を短縮（デフォルト 500ms だと Vim で誤動作） |
| `focus-events` | on | Vim の `autoread` を tmux 内でも正しく動作させる |
| `history-limit` | 50000 行 | スクロールバックの上限（デフォルト 2000 行から拡大） |
| `mouse` | on | マウスでのスクロール・ペイン選択を有効化 |
| `automatic-rename` | off | コマンド実行時にウィンドウ名が自動変更されるのを防ぐ |

ステータスバーの右側にはホスト名・ロードアベレージ・時刻を表示します（Mac は `sysctl`、Linux は `/proc/loadavg` を参照）。

### 基本操作

tmux の操作はすべて **プレフィックスキー `Ctrl+B`** を押してから行います。

| 操作 | キー |
| ---- | ---- |
| 新しいウィンドウを開く | `Ctrl+B` → `c` |
| 次のウィンドウへ移動 | `Ctrl+B` → `n` |
| 前のウィンドウへ移動 | `Ctrl+B` → `p` |
| ウィンドウ番号で移動 | `Ctrl+B` → `0`〜`9` |
| 画面を左右に分割 | `Ctrl+B` → `%` |
| 画面を上下に分割 | `Ctrl+B` → `"` |
| 分割ペイン間を移動 | `Ctrl+B` → 矢印キー |
| セッションをデタッチ | `Ctrl+B` → `d` |
| セッション一覧を表示 | `tmux ls` |
| セッションに再接続 | `tmux attach` |

---

## シェルの設定詳細

### macOS — zsh + zprezto

[zprezto](https://github.com/sorin-ionescu/prezto) は zsh のフレームワークです。
モジュールを組み合わせることで補完・シンタックスハイライト・履歴検索などの機能を提供します。

#### 有効にしているモジュール

| モジュール | 提供する機能 |
| ---------- | ------------ |
| `environment` | zsh の基本オプション設定 |
| `terminal` | ターミナルのウィンドウ・タブタイトル設定 |
| `editor` | キーバインド設定（Emacs モード） |
| `history` | コマンド履歴の設定（重複排除・共有など） |
| `directory` | ディレクトリ移動の拡張（`cd` の履歴管理など） |
| `spectrum` | シェルスクリプト用の色変数を定義 |
| `utility` | `ls`・`grep` のカラー化などの便利エイリアス |
| `completion` | Tab 補完の有効化・スタイル設定 |
| `git` | git コマンドのエイリアスと情報取得関数 |
| `syntax-highlighting` | コマンド入力中にリアルタイムでシンタックスハイライト |
| `autosuggestions` | 過去のコマンド履歴から入力候補をグレーで表示（→ キーで確定） |
| `history-substring-search` | ↑↓ キーで入力中の文字列を含む履歴を検索 |
| `prompt` | プロンプトテーマを読み込む（`mysorin` テーマを使用） |

#### キーバインド

Emacs モードを使用しています。主なショートカット：

| キー | 動作 |
| ---- | ---- |
| `Ctrl+A` | 行頭へ移動 |
| `Ctrl+E` | 行末へ移動 |
| `Ctrl+R` | コマンド履歴をインクリメンタル検索 |
| `Ctrl+U` | カーソル前の文字をすべて削除 |
| `↑` / `↓` | 入力中の文字列を含む履歴を検索（history-substring-search） |

#### ls カラー設定（Ubuntu 標準との統一）

macOS の標準 `ls` は BSD 実装で、Ubuntu の GNU `ls` とカラー表示の仕組みが異なります。
`brew install coreutils` で GNU `ls`（`gls`）をインストールすると、`zshrc` の設定により `gdircolors -b` で `LS_COLORS` を設定し、Ubuntu と同じカラー表示になります。

> **注意**: zprezto の git モジュールが `gls` を `git log` のエイリアスとして使っています。
> そのため `zshrc` では `gls` のエイリアスを使わず `/opt/homebrew/bin/gls` のフルパスを直接指定しています。
> `coreutils` をインストールしていない場合は、ls のカラー設定のみ Ubuntu と異なります（他の機能には影響しません）。

#### mysorin プロンプトテーマ

zprezto の `sorin` テーマをベースにカスタマイズしたテーマです。
カレントディレクトリのパスを短縮せず完全表示し、右プロンプトに git のブランチ・変更状態を表示します。

---

### Ubuntu — bash

Ubuntu の標準シェル（bash）をそのまま使います。

#### bash の主な設定内容

| 設定 | 内容 |
| ---- | ---- |
| `HISTCONTROL=ignoreboth` | 重複コマンドと先頭スペース付きコマンドを履歴に残さない |
| `HISTSIZE` / `HISTFILESIZE` | 履歴を 100,000 件保存 |
| `PROMPT_COMMAND` | コマンド実行のたびに履歴をファイルに書き込み・読み込み（複数セッション間で共有） |
| `shopt -s histappend` | シェル終了時に履歴を追記（上書きしない） |
| `shopt -s checkwinsize` | コマンド実行後にウィンドウサイズを再確認（ターミナルリサイズへの対応） |

bash 補完は `bash-completion@2`（Homebrew）または `/usr/share/bash-completion`（Ubuntu）を自動検出して読み込みます。

git プロンプトは `/opt/homebrew/share/git-core/contrib/completion/git-prompt.sh`（Mac）または `/usr/lib/git-core/git-sh-prompt`（Ubuntu）などを自動検出します。見つかった場合、プロンプトにブランチ名と変更状態（`*`）が表示されます。

---

## 設定のカスタマイズ

設定ファイルはシンボリックリンクなので、リポジトリ内のファイルを直接編集すれば即座に反映されます。

```bash
# 例: Vim の設定を変更する
vim ~/dotfiles/vimrc
# → 保存した瞬間から次回の Vim 起動に反映される
```

変更をバージョン管理する場合：

```bash
cd ~/dotfiles
git add vimrc
git commit -m "vimrc: ..."
git push
```

---

## 設定の更新（別マシンへの反映）

```bash
cd ~/dotfiles
git pull
```

シンボリックリンクはそのままなので、`git pull` だけで全設定が最新になります。

---

## メンテナンス

### zprezto を更新したときの確認手順（Mac のみ）

#### なぜ確認が必要か

`zpreztorc` はもともと zprezto が提供するデフォルト設定をベースに作られています。
zprezto を更新すると、zprezto 側のデフォルト `zpreztorc` に新しいオプションや変更が加わることがあります。
しかし dotfiles の `zpreztorc` は独立したファイルなので、**zprezto を更新しても dotfiles 側には自動反映されません**。
放置すると「zprezto が対応した新機能を知らずに使えていない」状態になります。

#### いつ確認するか

zprezto を更新したとき（以下のコマンドを実行したとき）に確認してください。

```zsh
git -C ~/.zprezto pull --recurse-submodules
```

#### 確認手順

```zsh
# zprezto のデフォルト zpreztorc と dotfiles の zpreztorc を比較する
diff ~/.zprezto/runcoms/zpreztorc ~/dotfiles/zpreztorc
```

差分を読んで、zprezto 側に追加された設定のうち取り込みたいものがあれば
`~/dotfiles/zpreztorc` に手動で反映してコミットします。

#### 差分の読み方

`diff` の出力は以下のルールで読みます。

```diff
< （左側）= zprezto のデフォルト側にある行
> （右側）= dotfiles 側にある行
```

取り込むべき差分の典型例：

- zprezto 側に新しいモジュールのコメント例が追加されていた → 参考として確認
- dotfiles 側にあって zprezto 側にない行 → 自分のカスタマイズなので変更不要

#### 実際の発生頻度

zprezto の `zpreztorc` が変更されることは稀です。
更新のたびに毎回 diff をとる必要はなく、**動作がおかしいと感じたときや
zprezto のメジャーアップデートがあったとき**に確認する程度で十分です。

---

## 新マシン セットアップ チェックリスト

新しいマシンで最初から環境を構築する際の全手順です。

### macOS の全手順

- [ ] **Homebrew をインストール**

  ```zsh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

- [ ] **必要ツールをインストール**

  ```zsh
  brew install vim tmux git coreutils
  ```

- [ ] **zprezto をインストール**

  ```zsh
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
  ```

- [ ] **このリポジトリを clone**

  ```zsh
  git clone https://github.com/zabaot/dotfiles.git ~/dotfiles
  ```

- [ ] **install.sh を実行**

  ```zsh
  cd ~/dotfiles
  ./install.sh
  ```

- [ ] **シェルを再起動**

  ```zsh
  source ~/.zshrc
  ```

- [ ] **Vim プラグインをインストール**

  ```vim
  :PlugInstall
  ```

### Ubuntu の全手順

- [ ] **必要ツールをインストール**

  ```bash
  sudo apt update
  sudo apt install vim tmux git ncurses-term
  ```

- [ ] **このリポジトリを clone**

  ```bash
  git clone https://github.com/zabaot/dotfiles.git ~/dotfiles
  ```

- [ ] **install.sh を実行**

  ```bash
  cd ~/dotfiles
  ./install.sh
  ```

- [ ] **シェルを再起動**

  ```bash
  source ~/.bashrc
  ```

- [ ] **Vim プラグインをインストール**

  ```vim
  :PlugInstall
  ```

---

## バックアップの復元

`install.sh` は既存のファイルを上書きせず、`.bak.YYYYMMDDHHMMSS` という名前でバックアップしてから置き換えます。
元の状態に戻したい場合は、バックアップファイルを手動で復元してください。

```bash
# バックアップファイルを確認する
ls ~/.vimrc.bak.*

# 元のファイルに戻す（例: .vimrc）
unlink ~/.vimrc                              # シンボリックリンクを削除
mv ~/.vimrc.bak.20240101120000 ~/.vimrc      # バックアップを元のパスに移動
```

`install.sh` 実行前にバックアップが作成されなかった場合（既存ファイルがなかった場合）は、
シンボリックリンクを削除するだけで元の状態になります。

```bash
unlink ~/.vimrc
unlink ~/.tmux.conf
```

---

## アンインストール

dotfiles の使用をやめる場合は、作成したシンボリックリンクを削除します。

### macOS のシンボリックリンクを削除

```zsh
unlink ~/.vimrc
unlink ~/.tmux.conf
unlink ~/.zshrc
unlink ~/.zpreztorc
unlink ~/.zprezto/modules/prompt/functions/prompt_mysorin_setup
```

### Ubuntu のシンボリックリンクを削除

```bash
unlink ~/.vimrc
unlink ~/.tmux.conf
unlink ~/.bashrc
```

シンボリックリンクを削除した後は、必要に応じて各ツールのデフォルト設定ファイルを再作成してください。

---

## トラブルシューティング

### `install.sh` が失敗する

**Permission denied** が出る場合は実行権限を付与してください。

```bash
chmod +x install.sh
./install.sh
```

**`ln: ~/.zshrc: File exists`** のようなエラーが出る場合、対象ファイルがすでにシンボリックリンクとして存在しています（`install.sh` は通常のファイルのみバックアップし、既存のシンボリックリンクは `-sf` で上書きします）。エラーが続く場合は手動で確認してください。

```bash
ls -la ~/.zshrc   # l で始まる行ならシンボリックリンク
```

---

### `unknown terminal: tmux-256color` エラー（Ubuntu）

`ncurses-term` パッケージが未インストールです。

```bash
sudo apt install ncurses-term
```

---

### Vim 起動時に `E117: Unknown function` などのエラーが出る

vim-plug のインストール後に `:PlugInstall` を実行していない可能性があります。
Vim を起動して以下を実行してください。

```vim
:PlugInstall
```

プラグインのダウンロード中にエラーが出た場合は、ネットワーク接続を確認してから `:PlugUpdate` を試してください。

---

### LSP が起動しない（Vim）

対応ファイルを開いたときに `:LspInstallServer` を実行したか確認してください。
インストール済みのサーバーを確認するには：

```vim
:LspStatus
```

サーバーのインストールには `npm` / `pip` などが必要な場合があります。対象言語の依存ツールが入っているか確認してください。

---

### zsh でコマンドが見つからない（Mac）

`brew install coreutils` を行ったあとにシェルを再起動していない可能性があります。

```zsh
source ~/.zshrc
```

それでも解決しない場合は、Homebrew のパスが通っているか確認してください。

```zsh
echo $PATH | tr ':' '\n' | grep homebrew
```

---

## ライセンス

[Apache License 2.0](LICENSE)
