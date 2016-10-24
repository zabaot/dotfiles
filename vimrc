"VIM setting
set nocompatible
set notitle          "編集中のファイル名を表示
syntax on          "コードの色分け
set t_Co=256 "Vim256色対応
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

"Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileformat=unix

"Display
set number         " 行番号を表示する
set ambiwidth=double
set cursorline     " カーソル行の背景色を変える
set cursorcolumn   " カーソル位置のカラムの背景色を変える
set ambiwidth=double "Unicodeで行末が変になる問題を解決
set laststatus=2   " ステータス行を常に表示
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\    " ファイルエンコーディングや文字コードをステータス行に表示する
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set matchtime=3    " showmatchの表示時間
set helpheight=999 " ヘルプを画面いっぱいに開く
set formatoptions-=c "フォーマット揃えをコメント以外有効にする
set list           " 不可視文字を表示

" 不可視文字の表示記号指定
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set backspace=indent,eol,start "Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,] "行頭行末の左右移動で行をまたぐ
set scrolloff=8                "上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set expandtab "タブ入力を複数の空白入力に置き換える
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

"Search
set hlsearch "検索文字列をハイライトする
set incsearch "インクリメンタルサーチを行う
set ignorecase "大文字と小文字を区別しない
set smartcase "大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan "最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault "置換の時 g オプションをデフォルトで有効にする

"gtag設定
nmap <C-q> <C-w><C-w><C-w>q
nmap <C-g> :Gtags -g
nmap <C-i> :Gtags -f %<CR>
nmap <C-j> :GtagsCursor<CR>
nmap <C-k> :Gtags -r <C-r><C-w><CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"検索によるハイライトを無効化するショートカット
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"複数ファイルの編集を可能にする
set hidden

