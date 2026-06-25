set nocompatible   " Vi互換モードを無効化（Vim本来の全機能を使えるようにする）
set encoding=utf-8 " Vim内部で使う文字コードをUTF-8に設定

" プラグイン管理: vim-plug（install.sh が初回セットアップ時に自動インストール）
call plug#begin()

Plug 'tomasr/molokai'                                " カラースキーム
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " ファジーファインダー本体
Plug 'junegunn/fzf.vim'                              " fzf の Vim 統合
Plug 'prabirshrestha/vim-lsp'                        " LSPクライアント（コード補完・定義ジャンプ）
Plug 'mattn/vim-lsp-settings'                        " 言語サーバーの自動セットアップ
Plug 'prabirshrestha/asyncomplete.vim'               " 非同期補完エンジン
Plug 'prabirshrestha/asyncomplete-lsp.vim'           " LSP と asyncomplete を接続

call plug#end()

" 文字コード
set fileencoding=utf-8       " ファイルの保存文字コード
set fileformats=unix,dos,mac " 改行コードを自動判別（新規ファイルは unix）

" 表示
set number           " 行番号を表示
set cursorline       " カーソル行をハイライト
set ambiwidth=double " 全角文字の幅を2として扱う（日本語表示のずれを防ぐ）
set laststatus=2     " ステータスラインを常に表示
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P
                     " ステータスライン: ファイル名・修正状態・文字コード・改行コード・行/列位置
set cmdheight=2      " コマンドラインの表示行数（LSPメッセージが1行に収まらない場合に備える）
set showmatch        " 対応する括弧をハイライト
set matchtime=3      " 括弧ハイライトの表示時間（×0.1秒）
set helpheight=999   " ヘルプを画面いっぱいに開く
set formatoptions-=c " コメント行の自動折り返しを無効化
set list             " タブ・末尾スペースなどの不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
                     " 不可視文字の表示記号（タブ: »-、末尾スペース: -、折り返し: »«）
set signcolumn=yes   " サイン列を常に表示（LSP診断アイコンによるテキストのずれを防ぐ）

" ウィンドウ分割
set splitbelow " :split で下に開く
set splitright " :vsplit で右に開く

" カーソル移動
set backspace=indent,eol,start " バックスペースでインデント・行頭・改行を削除可能にする
set whichwrap=b,s,h,l,<,>,[,]  " 行頭・行末で左右移動したとき前後の行に移動する
set scrolloff=8                 " カーソル上下に常に8行の余白を確保
set sidescrolloff=16            " カーソル左右に常に16文字の余白を確保
set sidescroll=1                " 横スクロールを1文字単位で行う

" インデント
set tabstop=4     " タブ文字を画面上で何文字幅で表示するか
set shiftwidth=4  " 自動インデントのずれ幅
set expandtab     " タブ入力をスペースに展開
set softtabstop=4 " タブキー・バックスペースで動くカーソル幅
set autoindent    " 改行時に直前の行のインデントを継続
set smartindent   " 構文に合わせてインデントを自動調整

" 検索
set hlsearch   " 検索結果をハイライト
set incsearch  " 入力中にリアルタイムで検索（インクリメンタルサーチ）
set ignorecase " 検索時に大文字・小文字を区別しない
set smartcase  " 検索語に大文字が含まれるときだけ大文字・小文字を区別する
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l> " Ctrl+L でハイライトを消去

" Undo
set undofile " セッションをまたいで undo 履歴をファイルに永続化
if !isdirectory($HOME . '/.vim/undo')
    call mkdir($HOME . '/.vim/undo', 'p') " undo 保存ディレクトリがなければ作成
endif
set undodir=~/.vim/undo " undo ファイルの保存場所

" 補完
set completeopt=menuone,noinsert,noselect " 候補が1つでもメニュー表示、自動挿入・自動選択しない
set shortmess+=c                          " 「x/y マッチ」などの補完メッセージを非表示
set updatetime=300 " CursorHold イベントの発火間隔（ms）、LSP診断の反応速度に影響（デフォルト4000）

" コマンドライン補完
set wildmenu                   " 補完候補をメニュー表示
set wildmode=longest:full,full " 1回目Tab: 共通部分まで補完、2回目Tab: 候補を順に選択

" その他
set hidden " 未保存のバッファを隠しバッファとして残す（保存せず別ファイルへ移動できる）

" トゥルーカラー
if has('termguicolors')
    set termguicolors " 24bitフルカラーを有効化（ターミナルが対応している場合のみ）
endif

" fzf キーマップ
nnoremap <C-p> :Files<CR>   " Ctrl+P でファイル検索
nnoremap <C-b> :Buffers<CR> " Ctrl+B で開いているバッファ一覧

" LSP キーマップ
nmap <silent> gd <plug>(lsp-definition) " gd で定義元にジャンプ
nmap <silent> gr <plug>(lsp-references) " gr で参照一覧を表示
nmap <silent> K  <plug>(lsp-hover)      " K でカーソル位置のドキュメントをホバー表示
let g:lsp_diagnostics_echo_cursor = 1  " カーソル位置のエラー・警告をコマンドラインに表示

" asyncomplete キーマップ
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"                   " Tab で補完候補を次に進む
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"                 " Shift+Tab で補完候補を前に戻る
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"  " Enter で補完を確定

" カラースキーム
syntax on        " シンタックスハイライトを有効化
set t_Co=256     " 256色対応
set background=dark
let g:molokai_original = 1 " オリジナルの molokai 配色を使用（設定はcolorscheme呼び出し前に必要）
let g:rehash256 = 1        " 256色モードで近似色を使用
try
    colorscheme molokai " molokai カラースキームを適用
    highlight Normal       ctermbg=NONE " 背景をターミナルのデフォルト色に透過
    highlight NonText      ctermbg=NONE
    highlight LineNr       ctermbg=NONE
    highlight CursorLineNr ctermbg=NONE
catch
    colorscheme desert " プラグイン未インストール時は組み込みの desert にフォールバック
endtry
