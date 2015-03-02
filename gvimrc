" カラースキーム
colorscheme hybrid
hi LineNr ctermfg=14 guifg=#878b91

" 透明度の設定
augroup mygvimrc
autocmd guienter * set transparency=245
augroup END

" フォントとメニュー
if has('win32') || has('win64')
  set guifont=Ricty\ Diminished:h14:cSHIFTJIS
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
end
