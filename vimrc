" vim-plug — 初回セットアップ時に install.sh が自動インストールする
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
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileformat=unix

" Display
set nocompatible
set number
set cursorline
set cursorcolumn
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
set wrapscan
set gdefault
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Misc
set hidden

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" LSP
nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> K  <plug>(lsp-hover)
let g:lsp_diagnostics_echo_cursor = 1

" Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" Colorscheme
syntax on
set t_Co=256
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
highlight Normal       ctermbg=NONE
highlight NonText      ctermbg=NONE
highlight LineNr       ctermbg=NONE
highlight CursorLineNr ctermbg=NONE
