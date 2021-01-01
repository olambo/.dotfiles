set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
set incsearch

if exists('$TMUX')
	" tmux title to iterm title. todo: working in neovim, not working in vim
	let &t_ts = "\<Esc>]0"
	let &t_fs = "\x7"
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
 
" <hyper-y> yank selection and save it into a file which is monitored
" todo: find out why, multiple line selected, calling multiple times?
" this doesn't work when selection get too big!
vnoremap <c-x><c-y> :call It2copy()<cr>

" <cmd-/> comment/uncomment
nmap <c-x><c-x> <Plug>CommentaryLine<cr>
vmap <c-x><c-x> <Plug>Commentary

" ----------------------------------------------------------------------------------------------
let mapleader="\<space>"
set showcmd

"go run
noremap <leader>rr :call GoCommand("go run main.go")<CR>
"go test
noremap <leader>tt :call GoCommand("go test")<CR>
"go test
noremap <leader>T :call GoCommand("go test -run " . expand("<cword>"))<CR>
"organize imports
noremap <leader>ii :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
" set mouse mode on, show file path
nnoremap <leader>mm :call ToggleMouse()<CR>
" toggle numbers
nnoremap <leader>nn :call ToggleNumber()<CR>
" toggle highlight search
nnoremap <leader>hh :set hlsearch! hlsearch?<CR>
" go to starting path
nnoremap <leader>[ :e `pwd`<CR>
" new starting path
nnoremap <leader>] :cd <c-r>=expand('%:h')<CR><CR>
" diff between this buffer and original
nnoremap <leader>bc :w !diff % -<CR>
" go to alternate buffer
nnoremap <leader>ba :b #<CR>
" remove buffer
nnoremap <leader>bd :bd<CR>
" open finder at current directory
nnoremap <silent> <leader>fi :call GoFinder()<CR>
" replace
nnoremap <leader>/ :%s//gI<Left><Left><Left>
" show terminal
nnoremap <silent> <leader>te :call GoTerm()<CR>
" show filepath
nnoremap <silent> <leader>fp <c-g>

" ----------------------------------------------------------------------------------------------
function! GoTerm()
    :set nonumber 
    :set norelativenumber
    :term
    :startinsert
endfunction

function! ToggleNumber()
  if &number == '' && &relativenumber == ''
    set number relativenumber 
  else
    set nonumber norelativenumber 
  endif
endfunction

function! GoFinder()
  :!exec open -a Finder %:p:h
endfunction

function! ToggleMouse()
  if &mouse != ''
    set nonumber 
    set norelativenumber
    set mouse=
    echo "Mouse OFF for:" expand('%:p')
  else
    set mouse=nv
    echo "Mouse usage enabled"
  endif
endfunction
 
function! GoCommand(cmd)
	if &mod == 1 
		echohl WarningMsg | echo "WARNING, BUFFER NOT WRITTEN!" | echohl None | echo a:cmd
	else
		echo "vcommand: " . a:cmd
	endif
	call writefile([a:cmd], expand("~/.config/nvim/runcache/vcommand.txt"))
endfunction

function! It2copy()
    silent execute "normal! `<v`>y"
    let regInfo = getreg('"')
    call writefile(split(regInfo, "\n"), expand("~/.config/nvim/runcache/vclipboard.txt"))
endfunction
