if has('win32')
	" Windows用
	"set guifont=MS_Gothic:h11:b:cSHIFTJIS
	set gfn=MeiryoKe_Gothic:h12:cSHIFTJIS
	"set guifont=MS_Mincho:h12:cSHIFTJIS
	" 行間隔の設定
	set linespace=1
	set guioptions-=T    " ツールバー非表示
	" 一部のUCS文字の幅を自動計測して決める
	colorscheme desert
	if has('kaoriya')
		set ambiwidth=auto
	endif
elseif has('mac')
	set guifont=Osaka－等幅:h14
	set showtabline=2    " タブを常に表示
	set guioptions-=T    " ツールバー非表示
	set antialias        " アンチエイリアス
	set tabstop=4        " タブサイズ
	set nobackup         " バックアップなし
	set visualbell t_vb= " ビープ音なし
	set columns=100      " 横幅
	set lines=35         " 行数
	set nowrapscan       " 検索をファイルの先頭へループしない
	colorscheme molokai
	set imdisable
elseif has('xfontset')
	" UNIX用 (xfontsetを使用)
	set guifontset=a14,r14,k14
endif

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
"常にタブを表示
set showtabline=2

"透明度を変更
set transparency=20
map  gw :macaction selectNextWindow:
map  gW :macaction selectPreviousWindow:


