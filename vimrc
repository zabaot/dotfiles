set nocompatible
set encoding=utf-8

" vim-plug — install.sh が初回セットアップ時に自動インストールする
call plug#begin()

Plug 'tomasr/molokai'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" Encoding
set fileencoding=utf-8
set fileformats=unix,dos,mac

" Display
set number
set cursorline
set ambiwidth=double
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P
set cmdheight=2
set showmatch
set matchtime=3
set helpheight=999
set formatoptions-=c
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set signcolumn=yes

" Split
set splitbelow
set splitright

" Cursor movement
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" Indent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Undo
set undofile
if !isdirectory($HOME . '/.vim/undo')
    call mkdir($HOME . '/.vim/undo', 'p')
endif
set undodir=~/.vim/undo

" Completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set updatetime=300

" Command-line completion
set wildmenu
set wildmode=longest:full,full

" Misc
set hidden

" True color
if has('termguicolors')
    set termguicolors
endif

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" LSP
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> K  <plug>(lsp-hover)
let g:lsp_diagnostics_echo_cursor = 1

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" Colorscheme — vim-plug インストール前はデフォルトにフォールバック
syntax on
set t_Co=256
set background=dark
try
    colorscheme molokai
    let g:molokai_original = 1
    let g:rehash256 = 1
    highlight Normal       ctermbg=NONE
    highlight NonText      ctermbg=NONE
    highlight LineNr       ctermbg=NONE
    highlight CursorLineNr ctermbg=NONE
catch
    colorscheme desert
endtry
