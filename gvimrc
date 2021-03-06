set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,sjis,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

" カラー
set t_Co=256

" カラースキーム
set background=dark

try
  colorscheme hybrid
endtry

hi LineNr ctermfg=14 guifg=#878b91
hi CursorLine cterm=underline guibg=#383a3e

" 透明度の設定
augroup mygvimrc
  autocmd guienter * set transparency=245
augroup END

" フォントとメニュー
if has('win32') || has('win64')
  set guifont=Ricty\ Diminished:h14:cSHIFTJIS
  let &guioptions = substitute(&guioptions, '[T]', '', 'g')
end
