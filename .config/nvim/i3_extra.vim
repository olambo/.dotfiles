set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
set incsearch

" use cmd-/ to comment (mapped from cmd-_ from karabiner elements)
nmap <C-_> gcc
xmap <C-_> gc

" insert mode drop down list selection.
inoremap <down> <c-n>
inoremap <up> <c-p>
inoremap <expr> <left> pumvisible() ? "\<C-e>" : "\<left>"

" for most enviroments don't want tab spacing. But for Go, go fmt uses tabs
autocmd BufEnter *.go set noexpandtab
autocmd BufRead *.go set noexpandtab
autocmd BufLeave * set expandtab

if exists('$TMUX')
    " tmux title to iterm title. todo: working in neovim, not working in vim
    let &t_ts = "\<Esc>]0"
    let &t_fs = "\x7"
endif

if has('nvim')
    " insert mode for terminal
    au TermOpen * startinsert
endif

" put file path into title, remove laststatus - I'd rather have an extra line!
autocmd BufEnter * let &titlestring = expand("[$USER]") . expand('%:~')
set title
set laststatus=0
 
" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override' : {
  \         'color00' : ['#ffffff', '231'],
  \         'linenumber_bg' : ['#ffffff', '231'],
  \       }
  \     },
  \     'default.dark': {
  \       'override' : {
  \       }
  \     }
  \   }
  \ }
colorscheme PaperColor
set bg=light

" ----------------------------------------------------------------------------------------------
"  karabiner elements assisted key combinations
noremap <c-x><c-x> ;
inoremap <c-x><c-x> <esc>
 
" copy to system clipboard
if $TERM_PROGRAM == "Apple_Terminal"
    vnoremap <c-x><c-y> "+y
else
    vnoremap <c-x><c-y> :OSCYank<CR>
endif

" ----------------------------------------------------------------------------------------------
let mapleader="\<space>"
set showcmd

" deprecated open pane below and start vcommand
" nnoremap <silent> <leader>H :call system("osascript ~/.config/nvim/bin/vcommand-split")<CR>
"go run using vcommand
noremap <leader>m :call GoCommand("go run main.go")<CR>
"go test using vcommand
noremap <leader>t :call GoCommand("go test")<CR>
"go individual test using vcommand
noremap <leader>T :call GoCommand("go test -run " . expand("<cword>"))<CR>
"organize imports
noremap <leader>i :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
" yank file path to system buffer
noremap <leader>y :call FilePath()<CR>
" remove buffer
nnoremap <leader>d :bd<CR>
" set up find replace
nnoremap <leader>/ :%s//gI<Left><Left><Left>

"----------------------------------------------------------------------------------------------
function! PathHere()
    execute "cd %:p:h"
endfunction

function! PathOrig()
    execute "e `pwd`"
endfunction

function! FilePath()
    let path = expand("%:p")
    " deprecated
    " call writefile([passth], expand("~/.config/nvim/runcache/vclipboard.txt"))
    call YankOSC52(path)
    echo path
endfunction

function! ExampleMap()
    let example = "nnoremap <leader>; :call GoCommand('go run main.go arg1')<cr>"
    call YankOSC52(example)
endfunction

function! BufferDiff()
    execute "w !diff % -"
endfunction

function! BufferAlt()
    execute "b #"
endfunction

function! ToggleHlight()
    execute "set hlsearch! hlsearch?"
endfunction

function! ToggleRNumber()
  if &number == '' && &relativenumber == ''
    set number relativenumber 
  else
    set nonumber norelativenumber 
  endif
endfunction

function! GoFinder()
  :!exec open -a Finder %:p:h
endfunction

" echo when running fzf#run. Output doesnt appear!. So echo via a timer
function! TimerEcho(msg, timer)
    if len(a:msg) > 0
        echo a:msg
    endif
endfunction

function! ToggleMouse()
  if &mouse != ''
    set nonumber 
    set norelativenumber
    set mouse=
    let &titlestring = "MOUSE OFF " . expand("[$USER]") . expand('%:~')
    set title
    let msgToEcho = "Mouse is off"
  else
    set mouse=nv
    let &titlestring = expand("[$USER]") . expand('%:~')
    set title
    let msgToEcho = "Mouse enabled"
  endif
    call timer_start(1, function('TimerEcho', [msgToEcho]))
endfunction

function! GoCommand(cmd)
    if &mod == 1 
        echohl WarningMsg | echo "WARNING, BUFFER NOT WRITTEN!" | echohl None | echo a:cmd
    else
        echo "vcommand: " . a:cmd
    endif
    call writefile([a:cmd], expand("~/.config/nvim/runcache/vcommand.txt"))
endfunction

