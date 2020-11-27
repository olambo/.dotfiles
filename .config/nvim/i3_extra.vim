set belloff=all
set nowrap
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
set incsearch

" icons stop left alignment
let g:dirvish_git_show_icons = 0

map t <Plug>(easymotion-t)
map f <Plug>(easymotion-sl)
map ;; <Plug>(easymotion-bd-wl)
map s <Plug>(easymotion-s2)

" ----------------------------------------------------------------------------------------------
" keyboard maestro assisted key combinations
 
" <hyper-y> yank selection and save it into a file which is monitored
function! It2copy()
    execute "normal! `<v`>y"
    let regInfo = getreg('"')
    call writefile(split(regInfo, "\n"), expand("~/.config/nvim/runcache/vim-clipboard.txt"))
    echo "i2copy"
endfunction
vnoremap <c-\><c-\> :call It2copy()<cr>

" <cmd-/> comment/uncomment
nmap <c-\>/ <Plug>CommentaryLine<cr>
vmap <c-\>/ <Plug>Commentary

" ----------------------------------------------------------------------------------------------
" leader of the pack. 
let mapleader="\<space>"
" set showcmd

" go to next split
nnoremap <tab> <c-w><c-w>

" magic replace
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>

" toggle numbers
nnoremap <silent> <leader>nn :call ToggleNumber()<CR>
nnoremap <leader>nn :call ToggleNumber()<CR>
function! ToggleNumber()
  if &number == '' && &relativenumber == ''
    set number relativenumber 
  else
    set nonumber norelativenumber 
  endif
endfunction

" toggle highlight search
nnoremap <leader>hh :set hlsearch! hlsearch?<CR>

nnoremap <leader><leader> :call ToggleMouse()<CR>
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

" these lead to unintended consequences if they are not set to something
nnoremap <leader>i :echoerr 'You typed "<leader>i". Use "i" to insert'<cr>
nnoremap <leader>s :echoerr 'You typed "<leader>s". Use "<leader>w" to write file'<cr>
nnoremap <leader>a :echoerr 'You typed "<leader>a". Use "a" to append'<cr>
nnoremap <leader>d :echoerr 'You typed "<leader>d". Use "d" to delete'<cr>
nnoremap <leader>c :echoerr 'You typed "<leader>c". Use "c" to change'<cr>
nnoremap <leader>o :echoerr 'You typed "<leader>o". Use "o" to open line'<cr>
nnoremap <leader>p :echoerr 'You typed "<leader>p". Use "p" to paste'<cr>
nnoremap <leader>r :echoerr 'You typed "<leader>r". Use "r" to replace'<cr>
nnoremap <leader>u :echoerr 'You typed "<leader>u". Use "u" to undo'<cr>
nnoremap <leader>x :echoerr 'You typed "<leader>x". Use "x" to delete'<cr>
 
" create file in directory vi %foo/bar.md
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
" correctly set markdown for vim-commentary
autocmd FileType markdown setlocal commentstring=#\ %s

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'override' : {
  \         'color00' : ['ffffff', '231'],
  \         'linenumber_bg' : ['ffffff', '231'],
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

function! GoFinder()
  :!exec open -a Finder %:p:h
endfunction
" open finder at current directory
nnoremap <silent> <leader>fin :call GoFinder()<cr>

" move to work
nnoremap <silent> <Leader>wrk :e ~/dev/wrk <bar> :cd ~/dev/wrk<cr>
" reset starting path
nnoremap <leader>pcd :cd <c-r>=expand('%:h')<cr><cr>
" goto starting path
nnoremap <leader>ppp :e `pwd`<cr>

function! GoTerm()
    :term
    :set nonumber 
    :set norelativenumber
    :startinsert
endfunction
nnoremap <silent> <leader>tt :call GoTerm()<cr>
