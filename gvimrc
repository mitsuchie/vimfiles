" カラースキーム
colorscheme hybrid
hi LineNr ctermfg=14 guifg=#878b91

" フォントとメニュー
if has('win32') || has('win64')
  set guifont=Ricty\ Diminished:h14:cSHIFTJIS
  let &guioptions = substitute(&guioptions, '[mT]', '', 'g')
end
