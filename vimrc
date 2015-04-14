set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,sjis,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

" =============================================================================
" terminal encoding
" =============================================================================
if has('win32') || has('win64')
  set termencoding=cp932
else
  set termencoding=utf-8
endif

" =============================================================================
" autocmdを初期化
" =============================================================================
augroup myvimrc
  autocmd!
augroup END

" =============================================================================
" vimfilesの設定
" =============================================================================
let s:home = expand('~/.vim')
if has('win32') || has('win64')
  let s:home = expand('~/vimfiles')
endif

" =============================================================================
" NeoBundle
" =============================================================================
if has('vim_starting')
  let &runtimepath .= ','.s:home.'/bundle/neobundle.vim/'
endif

call neobundle#begin(expand(s:home."/bundle/"))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'mac'     : 'make -f make_mac.mak',
\     'linux'   : 'make',
\    },
\ }

NeoBundle 'w0ng/vim-hybrid'            " カラースキーム
NeoBundle 'itchyny/lightline.vim'      " 綺麗なステータスライン
NeoBundle 'Shougo/unite.vim'           " 検索インタフェース
NeoBundle 'Shougo/neomru.vim'          " 履歴
NeoBundle 'Shougo/neocomplete.vim'     " 補完
NeoBundle 'Shougo/neosnippet.vim'      " スニペット補完
NeoBundle 'Shougo/neosnippet-snippets' " スニペット集
NeoBundle 'Shougo/unite-outline'       " コード中のクラスの概要
NeoBundle 'Shougo/vimshell.vim'        " vimshell
NeoBundle 'thinca/vim-ref'             " クイックリファレンス閲覧
NeoBundle 'thinca/vim-quickrun'        " バッファのコードを実行
NeoBundle 'osyo-manga/shabadou.vim'    " QuickRunの拡張
NeoBundle 'osyo-manga/vim-watchdogs'   " 静的コード解析(非同期)
NeoBundle 'sgur/unite-everything'      " デスクトップ検索
NeoBundle 'dannyob/quickfixstatus'     " quickfixをコマンドウィンドウに表示
NeoBundle 'KazuakiM/vim-qfsigns'       " quickfixをsign領域に表示
NeoBundle 'koron/codic-vim'            " 英和辞書(補完にも使う)
NeoBundle 'rhysd/unite-codic.vim'      " uniteで英和辞書を使う
NeoBundle 'tpope/vim-surround'         " テキストオブジェクト
NeoBundle 'tpope/vim-fugitive'         " Git
NeoBundle 'tpope/vim-rails'            " rails
NeoBundle 'basyura/unite-rails'        " unite for rails
NeoBundle 'kannokanno/previm'          " プレビュー
NeoBundle 'eiiches/unite-tselect'      " TagSelect for Unite
NeoBundle 'groenewege/vim-less'        " LESS
NeoBundle 'kchmck/vim-coffee-script'   " CoffeeScript
NeoBundle 'AndrewRadev/switch.vim'     " toggling text
NeoBundle 'ujihisa/unite-colorscheme'  " Uniteでカラースキームを選ぶ
NeoBundle 'kana/vim-submode'           " submode
NeoBundle 'zhaocai/quickrun-runner-vimshell.vim' " QuickRunでvimshellを使う

" C# ... 主にUnityに使うっぽい
if has('MSBuild')
  NeoBundleLazy 'nosami/Omnisharp', {
  \   'autoload': {'filetypes': ['cs']},
  \   'build': {
  \     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
  \     'mac': 'xbuild server/OmniSharp.sln',
  \     'unix': 'xbuild server/OmniSharp.sln',
  \   }
  \ }
endif

call neobundle#end()
NeoBundleCheck


" =============================================================================
" settings
" =============================================================================
set number              " 行数表示
set ts=4 sw=4 sts=4     " 基本インデント
set incsearch           " インクリメントサーチ
set smartindent         " スマートインデント
set nobackup            " バックアップなし
set noswapfile          " スワップなし
set undofile            " undoファイルあり
" set autochdir           " 開いたファイルのディレクトリに移動
set tags=tags;          " タグの設定
set laststatus=2        " ステータス行を2行にする
set cmdheight=2         " コマンド行は1行に
set showcmd             " 常にステータス行を表示する
set clipboard=unnamed   " クリップボード共有
set showmatch           " 対応する括弧の表示
set hlsearch            " 検索結果のハイライト
set history=100         " ヒストリの最大
set shellslash          " Windowsで/
set backspace=indent,start,eol  " インデントを消せるようにする
set formatoptions-=ro   " 改行時にコメント継続させない
set list                " 不可視文字描画
set listchars=tab:^\_,trail:~,extends:.
set wildmenu
set wildmode=list,longest:full
set t_ut=              " for tmux
set cursorline
hi clear CursorLine

if !(has('win32') || has('win64'))
  set t_Co=256
endif

" カラースキーム
if &t_Co <= 16
  colorscheme desert
else
  colorscheme hybrid
endif

if has('win32') || has('win64')
  set termencoding=cp932
endif

" Post Launch Settings
augroup myvimrc
  " grepしたらquickfixを表示
  autocmd QuickFixCmdPost *grep* cwindow
  " vimfiles/ftplugin/ruby.vim が反映されなかったらココ！
  " autocmd FileType ruby setlocal expandtab ts=2 sts=2 sw=2 autoindent
augroup END


" =============================================================================
" keymapping
" =============================================================================
let g:submode_timeout = 0
let g:submode_keep_leaving_key = 1
let g:submode_keyseqs_to_leave = ['s', 'q']

" サブモード
nnoremap s <nop>
nnoremap <silent> si :lcd %:h<CR>
nnoremap <silent> ss :split<CR>
nnoremap <silent> sv :vsplit<CR>
nnoremap <silent> sH <C-w>H<CR>
nnoremap <silent> sJ <C-w>J<CR>
nnoremap <silent> sK <C-w>K<CR>
nnoremap <silent> sL <C-w>L<CR>

" エスケープ
inoremap jj <ESC>
" <ESC>連打でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
" ウィンドウ幅の調整
" nnoremap <C-l> <C-w>>
" nnoremap <C-h> <C-w><
" nnoremap <C-j> <C-w>+
" nnoremap <C-k> <C-w>-
call submode#enter_with('resize_x', 'n', '', 'sdl', '<C-w>>')
call submode#enter_with('resize_x', 'n', '', 'sdh', '<C-w><')
call submode#enter_with('resize_y', 'n', '', 'sdj', '<C-w>+')
call submode#enter_with('resize_y', 'n', '', 'sdk', '<C-w>-')
call submode#map('resize_x', 'n', '', 'l', '<C-w>>')
call submode#map('resize_x', 'n', '', 'h', '<C-w><')
call submode#map('resize_y', 'n', '', 'j', '<C-w>+')
call submode#map('resize_y', 'n', '', 'k', '<C-w>-')
" いっぱい移動する
" nnoremap J 5j
" nnoremap K 5k
" vnoremap J 5j
" vnoremap K 5k
nnoremap J <NOP>
nnoremap K <NOP>
vnoremap J <NOP>
vnoremap K <NOP>
call submode#enter_with('move', 'n', '', 'sj', '5j')
call submode#enter_with('move', 'n', '', 'sk', '5k')
call submode#map('move', 'n', '', 'j', '5j')
call submode#map('move', 'n', '', 'k', '5k')
call submode#enter_with('move', 'v', '', 'sj', '5j')
call submode#enter_with('move', 'v', '', 'sk', '5k')
call submode#map('move', 'v', '', 'j', '5j')
call submode#map('move', 'v', '', 'k', '5k')
" タブの移動
" nnoremap } gt
" nnoremap { gT
call submode#enter_with('tabmode', 'n', '', 'sl', 'gt')
call submode#enter_with('tabmode', 'n', '', 'sh', 'gT')
call submode#map('tabmode', 'n', '', 'l', 'gt')
call submode#map('tabmode', 'n', '', 'h', 'gT')
" タグ関係
nnoremap t <C-t>
nnoremap g<C-]> :<C-u>Unite -immediately tselect:<C-r>=expand('<cword>')<CR><CR>
nnoremap g] :<C-u>Unite tselect:<C-r>=expand('<cword>')<CR><CR>
" スペースの活用
" nnoremap <Space> .

" 互換性の問題
if !has('gui_running')
  augroup myvimrc
    autocmd VimEnter * imap <Nul> <C-Space>
  augroup END
endif


" =============================================================================
" キャッシュ
" =============================================================================
let g:neocomplete#data_directory = s:home."/cache/neocomplete/"
let g:neosnippet#data_directory  = s:home."/cache/neosnippet/"
let g:neomru#directory_mru_path  = s:home."/cache/neomru/directory"
let g:neomru#file_mru_path       = s:home."/cache/neomru/file"
let g:unite_data_directory       = s:home."/cache/unite/"
let g:vimhell_data_directory     = s:home."/cache/vimhell/"
let &undodir = s:home.'/cache/undo'
let &viminfo = &viminfo.',n'.s:home.'/cache/_viminfo'
" let &backupdir = s:home.'/cache/backup'
" let &directory = s:home.'/cache/swap'


" =============================================================================
" neocomplete
" =============================================================================
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

augroup myvimrc
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
augroup END

" ドットやアローで補完リストを表示する
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" let g:neocomplete#force_omni_input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" <C-Space>でオムニ補完 VisualStudioに合わせる
imap <Nul> <C-x><C-o>
imap <C-Space> <C-X><C-O>


" =============================================================================
" neosnippet
" =============================================================================
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = s:home.'/snippets/'

" <C-Space>でスニペットを展開する
imap <expr><C-Space> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<C-Space>"
imap <expr><Space>   neosnippet#jumpable()   ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Space>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" =============================================================================
" quickrun
" =============================================================================
" 実行中は SAN値! ピンチ! する
call quickrun#module#register(shabadou#make_quickrun_hook_anim(
\	'santi_pinch',
\	['＼(・ω・＼)　SAN値！', '　(／・ω・)／ピンチ！'],
\	6,
\), 1)

" エラーならquickfix, 成功ならバッファに表示
let g:quickrun_config = {
\  '_' : {
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime': 40,
\    'hook/santi_pinch/enable': 1,
\    'hook/time/enable': 1,
\    'hook/output_encode/encoding': 'utf-8',
\    'hook/quickfix_replate_tempname_to_bufnr/enable_exit': 1,
\    'hook/quickfix_replate_tempname_to_bufnr/priority_exit': -10,
\    'hook/close_quickfix/enable_success': 1,
\    'hook/close_quickfix/enable_hook_loaded': 1,
\    'hook/qfsigns_update/enable_exit':   1,
\    'hook/qfsigns_update/priority_exit': 3,
\    'outputter': 'multi:buffer:quickfix',
\    'outputter/quickfix/open_cmd' : '',
\  },
\  'cpp/vc': {
\    'exec': ['cl.bat %o %S /Fo%S:P:R.obj /Fe%S:P:R.exe',
\             '%S:P:R.exe %a'],
\    'tempfile': '%{tempname()}.cpp',
\    'hook/sweep/files': ['%S:P:R.exe', '%S:P:R.obj'],
\    'hook/output_encode/encoding': 'cp932'
\  },
\  'cs': { 'hook/output_encode/encoding': 'cp932' },
\  'watchdogs_checker/vc' : {
\    'command'   : 'cl.bat',
\    'exec'      : '%c /Zs %o %s:p ',
\    'hook/output_encode/encoding': 'cp932'
\	},
\  'ruby/watchdogs_checker' : { 'type' : 'watchdogs_checker/rubocop' },
\  'cpp/watchdogs_checker'  : { 'type' : 'watchdogs_checker/vc' },
\}

" VC++をデフォルトにしておく
if has('win32') || has('win64')
  let g:quickrun_config.cpp = { 'type': 'cpp/vc' }
endif

" <C-c>でQuickRunの強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : '\<C-c>'


" =============================================================================
" watchdogs
" =============================================================================
call watchdogs#setup(g:quickrun_config)

let g:watchdogs_check_BufWritePost_enable = 1

let g:qfsigns#Config = {'id': '5050', 'name': 'QFError',}
execute 'sign define '.get(g:qfsigns#Config,'name').' texthl=Error text=>>'


" =============================================================================
" ref
" =============================================================================
" + でカーソル下の単語のリファレンスを開く
nmap <silent> + <Plug>(ref-keyword)
vmap <silent> + <Plug>(ref-keyword)

let g:ref_refe_encoding = "UTF-8"


" =============================================================================
" unite
" =============================================================================
let g:unite_enable_start_insert = 1         " 最初からinsertモードにしておく
let g:unite_source_history_yank_enable = 1  " ヤンク履歴とか使えるようにする
let g:unite_source_history_yank_limit = 100 " 履歴の最大を設定

" , にショートカットを割り振っておく
" 最近開いたファイルとかその他諸々
nnoremap <silent> ,f :<C-u>Unite buffer file_mru file -buffer-name=searcher<CR>
nnoremap <silent> ,,f :<C-u>Unite file_rec/async:! -buffer-name=project<CR>
" ファイル
nnoremap <silent> ,e :<C-u>Unite buffer -buffer-name=filer<CR>
" ヤンク(コピー履歴)
nnoremap <silent> ,y :<C-u>Unite history/yank -buffer-name=history_yank<CR>
" grep結果, :Unite grep:(パス)
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search<CR>
nnoremap <silent> ,,g :<C-u>Unite grep:! -buffer-name=search<CR>
" outline結果, :Unite outline
nnoremap <silent> ,d :<C-u>Unite outline -buffer-name=outline<CR>
" プロジェクト
nnoremap <silent> ,s :<C-u>Unite file_rec:! -buffer-name=project<CR>

" Everythingを起動している必要あり、加えて別途es.exeをDLしてパスを通す
nnoremap <silent> ,a  :<C-u>Unite everything/async -buffer-name=everything<CR>
" if has('win32') || has('win64')
" else
  " .gitとか.svn以下で検索
"  nnoremap <silent> ,a :<C-u>Unite file_rec/async:! -buffer-name=project<CR>
" endif

" <C-l>でウィンドウ分割して開く, <C-o>でタブで開く
augroup myvimrc
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('tabopen')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-o> unite#do_action('tabopen')
  autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
  autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
  autocmd FileType unite nnoremap <silent> <buffer> <C-c> :q<CR>
  autocmd FileType unite inoremap <silent> <buffer> <C-c> <ESC>:q<CR>
augroup END

" grepはthe platium searcherを使う (必須) pt.exe
if executable('pt')
  set grepprg=pt\ --nogroup
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

call unite#custom#profile('default', 'context', {
      \ 'prompt_direction': 'top',
      \ 'prompt': '> ',
      \ 'candidate_icon': '- ',
      \ 'hide_icon': 0 })


" =============================================================================
" codic
" =============================================================================
inoremap <silent> <C-o>  <C-R>=<SID>codic_complete()<CR>
function! s:codic_complete()
  let line = getline('.')
  let start = match(line, '\k\+$')
  let cand = s:codic_candidates(line[start :])
  call complete(start +1, cand)
  return ''
endfunction
function! s:codic_candidates(arglead)
  let cand = codic#search(a:arglead, 30)
  " error
  if type(cand) == type(0)
    return []
  endif
  " english -> english terms
  if a:arglead =~# '^\w\+$'
    return map(cand, '{"word": v:val["label"], "menu": join(map(copy(v:val["values"]), "v:val.word"), ",")}')
  endif
  " japanese -> english terms
  return s:reverse_candidates(cand)
endfunction
function! s:reverse_candidates(cand)
  let _ = []
  for c in a:cand
    for v in c.values
      call add(_, {"word": v.word, "menu": !empty(v.desc) ? v.desc : c.label })
    endfor
  endfor
  return _
endfunction


" =============================================================================
" previm
" =============================================================================
augroup myvimrc
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" Previm
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nnoremap <silent> <F7> :<C-u>PrevimOpen<CR>
nnoremap <silent> <F5> :call previm#refresh()<CR>


" =============================================================================
" switch
" =============================================================================
" 文字列リテラルをトグル
" 'string' → "string" → 'string' ...
let g:switch_custom_definitions =
\[
\   {
\       '''\(.\{-}\)''' :  '"\1"',
\        '"\(.\{-}\)"'  : '''\1''',
\   },
\]
''
" 呼び出し用のキーマッピング
nnoremap - :<C-u>Switch<CR>


" =============================================================================
" paste mode
" =============================================================================
" 貼り付け時に無駄にインデントするのを防ぐ
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif


" =============================================================================
filetype on
filetype plugin on
filetype indent on
syntax on
