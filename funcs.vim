"   切换配色方案[[[2
function! Toggle_color()
  let colors = ['desertEx', 'fog', 'anotherdark', 'zenburn', 'molokai', 'tango2', 'camo', 'Tomorrow-Night']
  " spring2 是增加了彩色终端支持的 spring
  if !exists("g:colors_name")
    let g:colors_name = 'pink_lily'
  endif
  let i = index(colors, g:colors_name)
  let i = (i+1) % len(colors)
  exe 'colorscheme ' . get(colors, i)
endfunction

" php check syntax
function! CheckSyntax()
 if &filetype!="php"
  echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
  return
 endif
 if &filetype=="php"
  " Check php syntax
  setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
  " Set shellpipe
  setlocal shellpipe=>
  " Use error format for parsing PHP error output
  setlocal errorformat=%m\ in\ %f\ on\ line\ %l
 endif
 execute "silent make %"
 set makeprg=make
 execute "normal :"
 execute "copen"
endfunction

"打开当前路径
function! OpenFoldPwd()
  if has("win32")
    silent execute "!explorer ."
  elseif has('mac')
    silent execute "!open ."
  else
    silent execute "!nautilus ."
  endif
endfunction

"lessc
function! Lessc(filename)
  "设置less路径
  let file    = a:filename
  "如果没有设置路径，或者设置的文件不存在
  "则设置编译文件为当前文件
  if !filereadable(file . '.less')
    let file = expand("%:r")
  endif

  "此处配置比较麻烦
  if has('win32')
    let lesspath = 'sh lessc.sh'
  else
    let lesspath = 'lessc'
  endif
  let nowfile  = shellescape(file . '.less')
  let desfile  = shellescape(file) . '.css'
  execute '!' . lesspath . ' ' . nowfile . ' ' . desfile
  echo 'lessc form ' . nowfile . ' to ' . desfile
endfunction
nmap <leader>lc :call Lessc('index')<CR>
nmap <leader>lf :call Lessc(input("输入需要编译的less文件名:"))<CR>

"coffee
function! CoffeeMakeFile(filename)
  "设置less路径
  let file    = a:filename
  "如果没有设置路径，或者设置的文件不存在
  "则设置编译文件为当前文件
  if !filereadable(file . '.coffee')
    let file = expand("%:r")
  endif

  let coffeepath = 'coffee'
  let nowfile  = shellescape(file . '.coffee')
  execute '!' . coffeepath . ' -c ' . nowfile
  echo 'lessc form ' . nowfile
endfunction
nmap <leader>cof :call CoffeeMakeFile('f')<CR>

" 自动更新文件的最后更新时间
" see http://oldj.net/article/vim-auto-last-update/
function! AutoUpdateTheLastUpdateInfo()
	let s:original_pos = getpos(".")
	let s:regexp = "^\\s*\\([#\\\"\\*]\\|\\/\\/\\)\\s\\?[lL]ast \\([uU]pdate\\|[cC]hange\\):"
	let s:lu = search(s:regexp)
	if s:lu != 0
		let s:update_str = matchstr(getline(s:lu), s:regexp)
		call setline(s:lu, s:update_str . strftime("%Y-%m-%d %H:%M:%S"))
		call setpos(".", s:original_pos)
	endif
endfunction

"let g:eward_current_pwd = 0
"设置当前目录为根目录
function! Eward_set_pwd()
  let g:eward_current_pwd = getcwd()
endfunction

"获取路径，如果获取到g:eward_current_pwd，返回g:eward_current_pwd，否则返回当前
"目录
function! Eward_get_pwd()
  if !exists('g:eward_current_pwd')
    return getcwd()
  else
    return g:eward_current_pwd
  endif
endfunction

"在配置eward_current_pwd中查询
function! Eward_search_in_path()
  "call <SID>CommandTShowFileFinder(Eward_get_pwd())
  let a:arg = Eward_get_pwd()
  if has('ruby')
    ruby $command_t.show_file_finder
  else
    call s:CommandTRubyWarning()
  endif
endfunction

function! s:CommandTRubyWarning()
  echohl WarningMsg
  echo "command-t.vim requires Vim to be compiled with Ruby support"
  echo "For more information type:  :help command-t"
  echohl none
endfunction

"输入数字，在buffer中跳转
function! Eward_buffer_go(type)
  let l:num = input('请输入buffer 序号:')
  execute "normal :"
  if a:type == 'split'
    execute "sb" . l:num
  else
    execute "b" . l:num
  end
endfunction
" buffer go number
"nmap <leader>bn :call Eward_buffer_go('')<cr>
" buffer split number
"nmap <leader>sn :call Eward_buffer_go('split')<cr>

function! Eward_session(type)
  let l:filename = input('请输入seesion文件名: ')
  let l:basename = $VIMFILES.'/sessions/'.l:filename.'.vim'
  if a:type == 'w'
    execute 'normal :'
    execute 'mksession! '.l:basename
  else
    if filereadable(l:basename)
      execute 'normal :'
      execute 'source '.l:basename
    else
      echo '文件不存在'
    end
  end
endfunction
" session write
nmap <leader>sw :call Eward_session('w')<cr>
" session read
nmap <leader>sr :call Eward_session('')<cr>
