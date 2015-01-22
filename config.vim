" 区分不同的操作系统
" 配置统一的变量$VIMFILES
if has('win32')
  let $VIMFILES = $VIM.'/vimfiles'
else
  let $VIMFILES = $HOME.'/.vim'
endif

" 引入 Vundle插件管理工具
" https://github.com/gmarik/Vundle.vim
set rtp+=~/.vim/bundle/vundle/
"set rtp+=~/.vim/bundle/vim-table-mode/
call vundle#rc()

" 配置插件
source $VIMFILES/vundle.vim
" 配置自定义函数
source $VIMFILES/funcs.vim

" 指定英文逗号作为<leader>键
let mapleader=","

" 不向后兼容vi
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup

" 重启后撤销历史可用 persistent undo 
set undofile
set undodir=$VIMFILES/bak
" 最大可回滚层级，如果太大了不好，导致备份文件夹太多了
" 我的mac上甚至出现bak文件有3G那么大
set undolevels=100 

set history=50
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" 高亮当前行
if has('gui')
  set cursorline
endif

" 把shell设置为bash
set shell=/bin/bash

" Q map到gq，滚到页面底部
map Q gq

" CTRL-u在输入模式下，删除一个单词
" CTRL-U删除一行
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏

if has("win32")
  "set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
  "set gfw=Yahei_Mono:h12:cGB2312
endif

if has("mac")
  set guifont=Monaco:h14
endif

" 配置多语言环境
if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fenc=utf-8
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

set relativenumber

"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"-----------------------------------------------------------------
" javascript 语法设置 ~/.vim/syntax/javascript.vim
"-----------------------------------------------------------------
" 设置折叠层数为
setlocal foldlevel=1
" 打开javascript折叠
let b:javascript_fold=1
" 打开javascript对dom、html和css的支持
let javascript_enable_domhtmlcss=1

" 主题
color Tomorrow-Night

"使用空格替换tab
set expandtab
set shiftwidth=2
set tabstop=2
au FileType html,css,vim,javascript setl shiftwidth=2
au FileType html,css,vim,javascript setl tabstop=2
au FileType java,php,pascal setl shiftwidth=4
au FileType java,php,pascal setl tabstop=4
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.md set filetype=markdown

set smarttab
set lbr
" 设置文本宽度为78
set tw=78
set fo+=m
"Auto indent
set ai
set si
set cindent
set wrap

if has("win32")
  au GUIENTER * simalt ~x "vi自动最大化
endif

"Use the dictionary completion 
set complete-=k complete+=k

"双击m键删除^M符号
nmap mm :%s/\r//g<cr>

" php xdebug日志高亮
au BufRead,BufNewFile *.xt set ft=xt syntax=xt

" Map <CTRL>-P to check the file for syntax
:setl makeprg=php
:set errorformat=%m\ in\ %f\ on\ line\ %l
:noremap <C-P> :call CheckSyntax()<CR>

set tags=tags;
set autochdir
"set foldmethod:manual
"set foldmethod=syntax
set foldmethod=marker
autocmd filetype javascript setl foldmethod=syntax
" 文件增加后缀.js
autocmd filetype javascript set suffixesadd+=.js
"au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
set foldnestmax=2
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
let javascript_enable_domhtmlcss=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Vimwiki配置
if has("win32")
  let vimwiki_path = 'D:/Dropbox/wiki'
  let vimwiki_path_1 = 'D:/code/shepherdwind'
else
  let vimwiki_path = $HOME.'/Dropbox/wiki'
  let vimwiki_path_1 = $HOME.'/code/shepherdwind'
endif

let g:vimwiki_list = [{'path': vimwiki_path,
                      \ 'path_html': vimwiki_path .'/html/',
                      \ 'template_path': vimwiki_path.'/wiki/tpl/',
                      \ 'template_default': 'template',
                      \ 'template_ext': '.tpl',
                      \ 'nested_syntaxes' : {'html':'html','css':'css','javascript':'javascript','php':'php',},},
                      \{ 'path': vimwiki_path_1 .'/wiki',
                      \  'path_html': vimwiki_path_1 .'/',
                      \  'ext': '.wiki',
                      \ 'template_path': vimwiki_path_1.'/tpl/',
                      \ 'template_default': 'default',
                      \ 'template_ext': '.tpl',
                      \ 'nested_syntaxes' : {'html':'html','css':'css','javascript':'javascript','php':'php','json':'json','less': 'less',},}]
let g:vimwiki_CJK_length = 1
let g:vimwiki_html_header_numbering = 0
"使用Alt+f键生成html文档
nmap <A-f> :VimwikiAll2HTML <CR>
"禁止自动识别CamelCase单词
let g:vimwiki_camel_case = 0
"Toggle list item on/off (checked/unchecked)
nmap <S-Space> :VimwikiToggleListItem <CR>

set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80

nnoremap ; :

"Ack 配置
if has("win32")
  let g:ackprg="ack -H --nocolor --nogroup --column"
elseif has("mac")
  let g:ackprg="ack -H --nocolor --nogroup --column"
else
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
" MiniBufExplorer
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplMoreThanOne=0 
"let g:miniBufExplorerMoreThanOne=2
"let g:miniBufExplMapWindowNavVim = 0

set winaltkeys=no
nnoremap <space> <C-D><CR>

let g:user_zen_settings = {
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'c',
\  },
\  'xml' : {
\    'extends' : 'html',
\  },
\  'haml' : {
\    'extends' : 'html',
\  },
\}

autocmd InsertChange *.{py,js,css},*vimrc call AutoUpdateTheLastUpdateInfo()

au! BufRead,BufNewFile *.json set filetype=json

" 插入当前日期
nnoremap <F7> strftime("%Y-%m-%d %H:%M:%S")<CR>
noremap <F7> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

set wildmenu   "显示补全列表
set wildmode=longest:full   " 补全行为设置

" config for neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
  "source $VIMFILES/nodejs.vim
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

nmap <leader>cd :call OpenFoldPwd()<CR>
" NERDTree
map <leader>ff :NERDTreeToggle<CR>
" 打开文件的时候退出nerdtree
let g:NERDTreeQuitOnOpen = 0

nnoremap <leader>cfg :e $VIMFILES/config.vim<CR>
" 重载配置文件，立即生效，无须重启
nnoremap <leader>sv :source $VIMFILES/config.vim<cr>
nnoremap <leader>sp :call Eward_set_pwd()<cr>
"nmap <leader>t :call Eward_search_in_path()<cr>

nnoremap <leader><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
nmap <D-]> :tabprevious<cr>
nmap <D-[> :tabnext<CR>

nmap <leader>th :tabprevious<CR>
nmap <leader>tl :tabnext<CR>
nmap <leader>tn :tabnew<CR>

nmap <leader>mt :MBEToggle<CR>
nmap <leader>mc :MBEClose<CR>
nmap <leader>jn :%!python -m json.tool<CR>

" 向上移动一行
nmap <leader>u ddkP
" 向下移动一行
nmap <leader>d ddp
vmap <leader>u xkP`[V`]
vmap <leader>d xp`[V`]

let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetDirectories = ["myultisnips"]
let g:UltiSnipsSnippetsDir = "~/code/snippets/myultisnips/"

" 自动保存文件
au InsertLeave *.* write

" powerline config
if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14
   endif
endif

" ctrlp disabled changed
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/build/*        " Linux/MacOSX
" 使用j k进入esc模式
inoremap jk <esc>
let g:goldenview__enable_default_mapping=0
" 禁止原生的esc和ctrl-c，这个有点狠
"inoremap <C-c> <nop>
"inoremap <esc> <nop>

" Unite Plugins
" {{{
nnoremap <C-b> :Unite -start-insert buffer<cr>
nnoremap <C-g> :Unite grep<cr>
"nnoremap <C-u> :Unite<cr>
"nnoremap <C-f> :Unite -start-insert file file_rec buffer<cr>
" For ag
if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
" http://eblundell.com/thoughts/2013/08/15/Vim-CtrlP-behaviour-with-Unite.html
" Replicated Behaviour
" 
" <C-x> <C-v> open file in horizontal and vertical split
" <C-t> open file in new tab
" <esc> exit unite window
" <C-j> <C-k> Navigation, keep hands on home row
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/', 'node_modules', 'build'
      \ ], '\|'))

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

nnoremap <C-f> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" Unite end"}}}

" 窗口最大
"set lines=999 columns=999

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AirLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mini buffer explorer类似
" let g:airline#extensions#tabline#enabled = 1
" show git branch
let g:airline#extensions#branch#enabled = 1
" vim gitter show
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

" powerline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#ctrlp#color_template = 'replace'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => AirLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wildfire_objects = { "*" : ["i'", 'i"', "i)", "i]", "i}", "ip", "i<", "i`" ], "html,xml" : ["at"] }

" syntastic
if file_readable('.jshintrc')
  let g:syntastic_javascript_jshint_args = '--config ' . expand('%:p:h') . '/.jshintrc'
else
  let g:syntastic_javascript_jshint_args = '--config ~/.jshintrc'
endif

let g:syntastic_javascript_checkers = ['jshint']
" ignore html
let g:syntastic_mode_map = { 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:table_mode_corner = '+'
