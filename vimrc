set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,sjis,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

" =============================================================================
" autocmdを初期化
" =============================================================================
augroup myvimrc
  autocmd!
augroup END

" =============================================================================
" terminal encoding
" =============================================================================
let &termencoding = has('win32') || has('win64') ? 'cp932' : 'utf-8'

" =============================================================================
" vimfilesの設定
" =============================================================================
let s:home = expand('<sfile>:h')

" =============================================================================
" dein
" =============================================================================
let &runtimepath .= ','.expand(s:home.'/dein/repos/github.com/Shougo/dein.vim')

call dein#begin(s:home.'/dein')

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimshell.vim')        " vimshell
call dein#add('Shougo/vimfiler.vim')        " vimfiler
call dein#add('Shougo/neomru.vim')          " 履歴
call dein#add('Shougo/neoyank.vim')         " コピー履歴
call dein#add('Shougo/neocomplete.vim')     " 補完
call dein#add('Shougo/neosnippet.vim')      " スニペット補完
call dein#add('Shougo/neosnippet-snippets') " スニペット集
call dein#add('Shougo/unite.vim')           " 検索インタフェース
call dein#add('w0ng/vim-hybrid')            " カラースキーム
call dein#add('itchyny/lightline.vim')      " 綺麗なステータスライン
call dein#add('sgur/unite-everything')      " デスクトップ検索
call dein#add('rhysd/unite-codic.vim')      " uniteで英和辞書を使う
call dein#add('basyura/unite-rails')        " unite for rails
call dein#add('osyo-manga/shabadou.vim')    " QuickRunの拡張
call dein#add('osyo-manga/vim-watchdogs')   " 静的コード解析(非同期)
call dein#add('thinca/vim-fontzoom')        " フォントサイズ変更
call dein#add('thinca/vim-ref')             " クイックリファレンス閲覧
call dein#add('thinca/vim-quickrun')        " バッファのコードを実行
call dein#add('dannyob/quickfixstatus')     " quickfixをコマンドウィンドウに表示
call dein#add('KazuakiM/vim-qfsigns')       " quickfixをsign領域に表示
call dein#add('koron/codic-vim')            " 英和辞書(補完にも使う)
call dein#add('tpope/vim-surround')         " テキストオブジェクト
call dein#add('tpope/vim-fugitive')         " Git
call dein#add('tpope/vim-rails')            " rails
call dein#add('kannokanno/previm')          " Markdown
call dein#add('groenewege/vim-less')        " LESS
call dein#add('kchmck/vim-coffee-script')   " CoffeeScript
call dein#add('AndrewRadev/switch.vim')     " トグル操作(true <=> false など)
call dein#add('kana/vim-submode')           " サブモード(連続操作)
call dein#add('osyo-manga/vim-brightest')  " カーソル下の単語を自動ハイライト

if !(has('win32') || has('win64'))
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
endif

call dein#end()


" =============================================================================
" settings
" =============================================================================
set number              " 行数表示
set ts=4 sw=4 sts=4     " 基本インデント
set incsearch           " インクリメントサーチ
set ignorecase          " 大文字小文字無視
set smartindent         " スマートインデント
set nobackup            " バックアップなし
set noswapfile          " スワップなし
set undofile            " undoファイルあり
set tags=tags;          " タグの設定
set laststatus=2        " ステータス行を2行にする
set cmdheight=2         " コマンド行は1行に
set showcmd             " 常にステータス行を表示する
set clipboard=unnamed   " クリップボード共有
set showmatch           " 対応する括弧の表示
set hlsearch            " 検索結果のハイライト
set history=100         " ヒストリの最大
set backspace=indent,start,eol  " インデントを消せるようにする
set formatoptions-=ro   " 改行時にコメント継続させない
set list                " 不可視文字描画
set listchars=tab:^\_,trail:~,extends:.
set wildmenu wildmode=list,longest:full
set t_ut=
set cursorline
hi clear CursorLine

augroup myvimrc
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd FileType vim setlocal expandtab ts=2 sts=2 sw=2 autoindent
  autocmd FileType coffee setlocal expandtab ts=2 sts=2 sw=2 autoindent
  autocmd FileType eruby  setlocal expandtab ts=2 sts=2 sw=2 autoindent
augroup END


" =============================================================================
" keymapping
" =============================================================================
let g:submode_timeout = 0
let g:submode_keep_leaving_key = 1
let g:submode_keyseqs_to_leave = ['s', 'q']

" サブモード
nnoremap s <nop>
nnoremap si :<C-u>cd %:h<CR>
nnoremap <silent> sv :<C-u>VimShell -split<CR>
nnoremap <silent> sn :<C-u>Unite launcher<CR>gvim.exe
nnoremap <silent> sH <C-w>H<CR>
nnoremap <silent> sJ <C-w>J<CR>
nnoremap <silent> sK <C-w>K<CR>
nnoremap <silent> sL <C-w>L<CR>
nnoremap <silent> J 5j
nnoremap <silent> K 5k
" ウィンドウ幅の調整
call submode#enter_with('resize_x', 'n', '', 'sdl', '<C-w>>')
call submode#enter_with('resize_x', 'n', '', 'sdh', '<C-w><')
call submode#enter_with('resize_y', 'n', '', 'sdj', '<C-w>+')
call submode#enter_with('resize_y', 'n', '', 'sdk', '<C-w>-')
call submode#map('resize_x', 'n', '', 'l', '<C-w>>')
call submode#map('resize_x', 'n', '', 'h', '<C-w><')
call submode#map('resize_y', 'n', '', 'j', '<C-w>+')
call submode#map('resize_y', 'n', '', 'k', '<C-w>-')
" いっぱい移動する
call submode#enter_with('move', 'nv', '', 'sj', '5j')
call submode#enter_with('move', 'nv', '', 'sk', '5k')
call submode#map('move', 'nv', '', 'j', '5j')
call submode#map('move', 'nv', '', 'k', '5k')
" タブの移動
call submode#enter_with('tabmode', 'n', '', 'sl', 'gt')
call submode#enter_with('tabmode', 'n', '', 'sh', 'gT')
call submode#map('tabmode', 'n', '', 'l', 'gt')
call submode#map('tabmode', 'n', '', 'h', 'gT')
" フォントサイズ
call submode#enter_with('fontzoom', 'n', '', 's+', ':FontZoom +1<CR>')
call submode#enter_with('fontzoom', 'n', '', 's-', ':FontZoom +1<CR>')
call submode#map('fontzoom', 'n', '', '+', ':FontZoom +1<CR>')
call submode#map('fontzoom', 'n', '', '-', ':FontZoom -1<CR>')
" エスケープ
" inoremap jj <ESC>
" <ESC>連打でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
" タグ関係
nnoremap t <C-t>
" タブで移動
nnoremap <TAB> <C-w>w
nnoremap <C-j> <C-i>

" 互換性の問題
if !has('gui_running')
  augroup myvimrc
    autocmd VimEnter * imap <Nul> <C-Space>
  augroup END
endif


" =============================================================================
" キャッシュ
" =============================================================================
let g:playcode_data_directory    = s:home.'/cache/playcode'
let g:neocomplete#data_directory = s:home.'/cache/neocomplete/'
let g:neosnippet#data_directory  = s:home.'/cache/neosnippet/'
let g:neomru#directory_mru_path  = s:home.'/cache/neomru/directory'
let g:neomru#file_mru_path       = s:home.'/cache/neomru/file'
let g:neoyank#data_directory     = s:home.'/cache/neoyank/'
let g:unite_data_directory       = s:home.'/cache/unite/'
let g:vimshell_data_directory    = s:home.'/cache/vimhell/'
let &undodir = s:home.'/cache/undo'
let &viminfo = &viminfo.',n'.s:home.'/cache/_viminfo'


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
  autocmd FileType css        setl omnifunc=csscomplete#CompleteCSS
  autocmd FileType html       setl omnifunc=htmlcomplete#CompleteTags
  autocmd FileType markdown   setl omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python     setl omnifunc=pythoncomplete#Complete
  autocmd FileType xml        setl omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby       setl omnifunc=rubycomplete#Complete
augroup END

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" <C-Space>でオムニ補完 VisualStudioに合わせる
" imap <Nul> <C-x><C-o>
" imap <C-Space> <C-X><C-O>


" =============================================================================
" neosnippet
" =============================================================================
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = s:home.'/snippets/'

" スニペット展開する
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal') | set conceallevel=2 concealcursor=i | endif


" =============================================================================
" vimfiler
" =============================================================================
let g:vimfiler_as_default_explorer = 1
nnoremap <silent> o :<C-u>VimFiler -simple -split -winwidth=32 -no-quit<CR>


" =============================================================================
" vimshell
" =============================================================================
let g:vimshell_prompt = 'X / _ / X < '


" =============================================================================
" quickrun
" =============================================================================
" 実行中は SAN値! ピンチ! する
call quickrun#module#register(shabadou#make_quickrun_hook_anim(
      \	'santi_pinch',
      \	['＼(・ω・＼)　SAN値！', '　(／・ω・)／ピンチ！'],
      \	6,
      \), 1)

" Windows用の改行コード削除
function! s:hook_quickrun_to_unix_line()
  let s:hook = { 'name': 'to_unix_line', 'kind': 'hook' }

  function! s:hook.init(session)
    let config = a:session.config
    let runner = config.runner
    let enable = get(config, 'hook/to_unix_line/enable', 0)
    let self.config.enable = enable
  endfunction

  function! s:hook.on_output(session, context)
    let a:context.data = substitute(a:context.data, "\r", '', 'g')
  endfunction

  call quickrun#module#register(s:hook)
endfunction

call s:hook_quickrun_to_unix_line()

" VisualStudioの設定
let s:clcommand = '"D:/Program Files (x86)/Microsoft Visual Studio 12.0/VC/bin/vcvars32.bat" x86 \& cl '

let g:quickrun_config = {
\  '_' : {
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime': 40,
\    'outputter': 'multi:buffer:quickfix',
\    'outputter/quickfix/open_cmd' : '',
\    'hook/time/enable': 1,
\    'hook/to_unix_line/enable': 1,
\    'hook/santi_pinch/enable': 1,
\    'hook/output_encode/encoding': 'utf-8',
\    'hook/quickfix_replate_tempname_to_bufnr/enable_exit': 1,
\    'hook/quickfix_replate_tempname_to_bufnr/priority_exit': -10,
\    'hook/close_quickfix/enable_success': 1,
\    'hook/close_quickfix/enable_hook_loaded': 1,
\    'hook/qfsigns_update/enable_exit':   1,
\    'hook/qfsigns_update/priority_exit': 3,
\  },
\  'cpp/cl': {
\   'exec': [s:clcommand.' %o %s /nologo /EHsc /Fo%s:p:r.obj /Fe%s:p:r.exe \& %s:p:r.exe %a'],
\   'tempfile': '%{tempname()}.cpp',
\   'hook/sweep/files': ['%S:p:r.exe', '%S:p:r.obj'],
\   'hook/output_encode/encoding': 'cp932'
\  },
\
\  'watchdogs_checker/_': { 'hook/time/enable': 0, 'outputter/quickfix/open_cmd': '' }
\}

if executable('rubocop')
  let g:quickrun_config['ruby/watchdogs_checker'] = { 'type': 'watchdogs_checker/rubocop' }
endif

if has('win32') || has('win64')
  let g:quickrun_config.cpp = { 'type': 'cpp/cl' }
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
" リファレンスの文字コード
let g:ref_refe_encoding = 'UTF-8'

" + でカーソル下の単語のリファレンスを開く
nmap <silent> + <Plug>(ref-keyword)
vmap <silent> + <Plug>(ref-keyword)


" =============================================================================
" unite
" =============================================================================
let g:unite_enable_start_insert = 1         " 最初からinsertモードにしておく
let g:unite_source_history_yank_enable = 1  " ヤンク履歴とか使えるようにする
let g:unite_source_history_yank_limit = 100 " 履歴の最大を設定
let g:unite_force_overwrite_statusline = 0  " ステータスはlightlineに任せる

" , にショートカットを割り振っておく
" 最近開いたファイルとかその他諸々
nnoremap <silent> ,f  :<C-u>Unite buffer file_mru file -buffer-name=searcher<CR>
" ヤンク(コピー履歴)
nnoremap <silent> ,y :<C-u>Unite history/yank -buffer-name=history_yank<CR>
" ランチャー
nnoremap <silent> ,r :<C-u>Unite launcher -buffer-name=launcher<CR>
" grep結果, :Unite grep:(パス)
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=grep<CR>
nnoremap <silent> ,G  :<C-u>Unite grep:. -buffer-name=grep<CR><C-w><C-R><C-W>
" タグ関連
nnoremap g<C-]> :<C-u>Unite -immediately tselect:<C-r>=expand('<cword>')<CR><CR>
nnoremap g] :<C-u>Unite tselect:<C-r>=expand('<cword>')<CR><CR>
" プロジェクト (everything)
if executable('es')
  nnoremap <silent> ,a  :<C-u>Unite everything/async -buffer-name=everything<CR>
else
  nnoremap <silent> ,a  :<C-u>Unite file_rec/async:! -buffer-name=project<CR>
endif
" PlayCode
nnoremap <silent> ,cc :<C-u>Unite contest -buffer-name=[playcode]\ contests<CR>
nnoremap <silent> ,cp :<C-u>Unite problem -buffer-name=[playcode]\ problems<CR>

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

" grep は the platium searcher を使う (必須) pt.exe
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
" previm
" =============================================================================
augroup myvimrc
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

let g:previm_open_cmd = ''


" =============================================================================
" switch
" =============================================================================
" 呼び出し用のキーマッピング
nnoremap - :<C-u>Switch<CR>

" 文字列リテラルをトグル 'string' → "string" → 'string' ...
let s:switch_custom_definitions = [
      \   {
      \       '''\(.\{-}\)''' :  '"\1"',
      \        '"\(.\{-}\)"'  : '''\1''',
      \   },
      \]

augroup myvimrc
  autocmd FileType *    let g:switch_custom_definitions = s:switch_custom_definitions
  autocmd FileType ruby let g:switch_custom_definitions = []
augroup END


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
" statusline
" =============================================================================
" -----------------------------------------------------------------------------
" statusline base
" -----------------------------------------------------------------------------
function s:statusline_base(vcs, component)
  let statusline = { 'vcs': a:vcs, 'component': a:component }

  function! statusline.key()
    return 'w:'.(self.vcs).'_'.(self.component).'_statusline_cache'
  endfunction

  function! statusline.get_string()
    return exists(self.key()) ? eval(self.key()) : self.detect()
  endfunction

  function! statusline.extract(path)
    let path = a:path == '' ? '' : simplify(fnamemodify(a:path, ':p:s'))
    let prev = ''

    while path!=prev && !self.is_root(path)
      let prev = path
      let path = fnamemodify(path, ':h')
    endwhile
    return self.is_root(path) ? path : ''
  endfunction

  function! statusline.is_root(path)
    return a:path != '' && isdirectory(substitute(a:path,'[\/]$','','').'/.'.(self.vcs))
  endfunction

  function! statusline.on_hook(root, path)
    return (self.vcs).'_'.(self.component)
  endfunction

  function! statusline.detect()
    if !executable('git') | return '' | endif

    let path = expand('%:p')
    let root = self.extract(path)
    exe "let ".(self.key())." = '".(root!='' ? self.on_hook(root, path) : '')."'"

    return eval(self.key())
  endfunction

  function! statusline.auto_detect()
    execute 'augroup '.(self.vcs).'_'.(self.component).'_detect'
    execute 'autocmd!'
    execute 'autocmd BufNewFile,BufReadPost * unlet! '.(self.key())
    execute 'autocmd VimEnter               * unlet! '.(self.key())
    execute 'autocmd CmdWinEnter            * unlet! '.(self.key())
    execute 'augroup END'
  endfunction

  function! statusline.command(command)
    return vimproc#system(substitute(a:command, '\\', '/', 'g'))
  endfunction

  return statusline
endfunction

" -----------------------------------------------------------------------------
" statusline for git
" -----------------------------------------------------------------------------
let g:gitstatusline = s:statusline_base('git', 'main')
call g:gitstatusline.auto_detect()

function! g:gitstatusline.on_hook(root, path)
  call fugitive#detect(a:path)

  let is_managed = self.command('git -C '.a:root.' ls-files  '.a:path) != ''
  let is_changed = self.command('git -C '.a:root.' status -s '.a:path) != ''

  let option  = !is_managed ? 'X'
        \			: !is_changed ? '_'
        \			: '*'

  return 'Git('.option.')'
endfunction

let g:gitcommitline = s:statusline_base('git', 'commit')
call g:gitcommitline.auto_detect()

function! g:gitcommitline.on_hook(root, path)
  if self.command('git -C '.a:root.' ls-files  '.a:path) == ''
    return ''
  endif

  let log = self.command('git -C '.a:root.' log --format=oneline '.a:path)
  return '#'.len(split(log, "\n"))
endfunction

let s:exwombat = g:lightline#colorscheme#wombat#palette
let s:exwombat.normal.git = s:exwombat.normal.warning
let g:lightline#colorscheme#exwombat#palette = s:exwombat

let g:lightline = {
      \ 'colorscheme': 'exwombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'git_main', 'git_branch', 'git_revision',
      \               'unite', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'git_branch':   '%{exists("*fugitive#head(")?fugitive#head():""}',
      \   'git_revision': '%{g:gitcommitline.get_string()}',
      \   'unite': '%{substitute(unite#get_status_string(), " | ", "", "g")}'
      \ },
      \ 'component_expand': {
      \   'git_main': 'g:gitstatusline.get_string',
      \ },
      \ 'component_type': {
      \   'git_main': 'git'
      \ },
      \ 'component_visible_condition': {
      \   'git_main':     '(g:gitstatusline.get_string()!="")',
      \   'git_branch':   '(exists("*fugitive#head") && ""!=fugitive#head())',
      \   'git_revision': '(g:gitcommitline.get_string()!="")',
      \   'unite': '(&filetype=="unite")'
      \ },
      \ 'separator':    { 'left': '',  'right': ''  },
      \ 'subseparator': { 'left': '>', 'right': '<' }
      \ }


" =============================================================================
" matchit
" =============================================================================
if !exists('loaded_matchit') | runtime macros/matchit.vim | endif


" =============================================================================
" brightest
" =============================================================================
let g:brightest#highlight = { 'group' : 'BrightestUnderline' }

" =============================================================================
filetype on
filetype plugin on
filetype indent on
syntax on

set background=dark
colorscheme hybrid

hi LineNr ctermfg=243 guifg=#878b91
hi CursorLine ctermbg=237 guibg=#383a3e
