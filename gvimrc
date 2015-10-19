"フォント設定
"set guifontwide=Osaka:h12
"set guifont=Osaka-Mono:h14

"---------------------------------------------------------------------------
" フォント設定:
"
if has('win32')
	" Windows用
	"set guifont=MS_Gothic:h11:b:cSHIFTJIS
	set gfn=MeiryoKe_Gothic:h12:cSHIFTJIS
	"set guifont=MS_Mincho:h12:cSHIFTJIS
	" 行間隔の設定
	set linespace=1
	" 一部のUCS文字の幅を自動計測して決める
	if has('kaoriya')
		set ambiwidth=auto
	endif
elseif has('mac')
	set guifont=Osaka－等幅:h14
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
set transparency=3
map  gw :macaction selectNextWindow:
map  gW :macaction selectPreviousWindow:

