if has('win32')
    let $VIMFILES = $VIM.'/vimfiles'
else
    let $VIMFILES = $HOME.'/.vim'
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
source $VIMFILES/vundle.vim
source $VIMFILES/funcs.vim
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

"指定英文逗号作为<leader>键
let mapleader=","

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"if has("vms")
  "set nobackup		" do not keep a backup file, use versions instead
"else
  "set backup		" keep a backup file
"endif
"set backupdir=$VIMFILES/bak
set nobackup
" 重启后撤销历史可用 persistent undo 
set undofile
set undodir=$VIMFILES/bak
set undolevels=1000 "maximum number of changes that can be undone


set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" 把shell设置为bash
set shell=/bin/bash
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
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

"set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI "易水空间的设置
"set guifont=Courier_New:h12:cANSI "苹果字体
"set gfw=幼圆:h10.5:cGB2312 "中文幼圆字体
"set gfw=YaHei:h10.5:cGB2312 "雅黑字体 
"小屏幕配置
"set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
"set gfw=Yahei_Mono:h10:cGB2312
if has("win32")
  "set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
  "set gfw=Yahei_Mono:h12:cGB2312
endif

if has("mac")
  "set guifont=Courier_New:h16
  "set guifont=Courier:h14
  "set guifont=Menlo_Regular:h14
  set guifont=Monaco:h14
  "set guifont=Andale_Mono:h14
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

" 合并my.vim
" tree 打开NERDTree
"cmap bm NERDTreeFromBookmark 

" php xdebug日志高亮
au BufRead,BufNewFile *.xt set ft=xt syntax=xt
" Map <CTRL>-P to check the file for syntax
:setl makeprg=php
:set errorformat=%m\ in\ %f\ on\ line\ %l
:noremap <C-P> :call CheckSyntax()<CR>
"map <C-I> :TlistToggle<CR>
set tags=tags;
set autochdir
"set foldmethod:manual
"set foldmethod=syntax
set foldmethod=marker
autocmd filetype javascript set foldmethod=syntax
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
set foldnestmax=2
let javascript_fold=1
let javaScript_fold=1         " JavaScript
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
" taglist
let Tlist_Auto_Highlight_Tag = 1
"let Tlist_Auto_Open = 1
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 1
let Tlist_Max_Tag_Length = 30
let Tlist_Process_File_Always = 0
let Tlist_Show_Menu = 0
let Tlist_Show_One_File = 0
"let Tlist_Sort_Type = order
"let Tlist_Use_Horiz_Window = 0
"let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 30
let tlist_php_settings = 'php;c:class;i:interfaces;d:constant;f:function'
"let Tlist_JS_Settings = 'javascript;s:string;a:array;o:object;f:function'

let g:netrw_winsize = 30
nmap fe :Sexplore!<CR>

let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
"set statusline=%F%m%r,%Y,%{&fileformat}\ \ \ ASCII=\%b,HEX=\%B\ \ \ %l,%c%V\ %p%%\ \ \ [\ %L\ lines\ in\ all\ ]

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
" ctrl + shift + h 打开wiki homepage
"nmap <leader>home :VimwikiIndex<CR>

set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80
"highlight when over lenght
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"nmap <C-V> "+p<CR>
nnoremap ; :
"\cfg编辑配置文件
",n查找下一个
"nmap <leader>cn :cn<CR>
"前一个
"nmap <leader>cp :cp<CR>
"nmap <leader>d  <C-D>
"nmap <leader>j  <C-D>
"nmap <leader>p  <C-U>
"nmap <leader>u  <C-U>
" ack 命令
"let g:ackprg= expand("ack -H --nocolor --nogroup --column")


"Ack 配置
if has("win32")
  let g:ackprg="ack -H --nocolor --nogroup --column"
elseif has("mac")
  let g:ackprg="ack -H --nocolor --nogroup --column"
else
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
" MiniBufExplorer
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0  

" 重载配置文件，立即生效，无须重启

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

let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplMapWindowNavVim = 0

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

" 设置字典 ~/.vim/dict/文件的路径
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'php' : $VIMFILES.'/dict/funclist.txt',
    \ 'javascript' : $VIMFILES.'/dict/javascript.dict',
    \ 'coffee' : $VIMFILES.'/dict/javascript.dict',
    \ }

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
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
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
let g:NERDTreeQuitOnOpen = 1

" ,fm 打开WMToggle
nmap <leader>fm :WMToggle<cr>
nmap <leader>tb :TagbarToggle<cr>
nmap <leader>t :call Eward_search_in_path()<cr>
nnoremap <leader>cfg :e $VIMFILES/config.vim<CR>
nnoremap <leader>so :source $VIMFILES/config.vim<cr>
nnoremap <leader>sp :call Eward_set_pwd()<cr>

nnoremap <leader><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

nmap <leader>th :tabprevious<CR>
nmap <leader>tl :tabnext<CR>
nmap <leader>tn :tabnew<CR>

nmap <leader>mt :TMiniBufExplorer<CR>
nmap <leader>mc :TMiniBufExplorer<CR>
nmap <leader>jn :%!python -m json.tool<CR>

let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetDirectories = ["myultisnips"]
"nmap <leader>d :call AutoUpdatseTheLastUpdateInfo()<CR>
"Last update:2012-10-21 22:39:55