set belloff=all
set nowrap
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off
set incsearch

" icons stop left alignment
let g:dirvish_git_show_icons = 0

" only need these motions
map t <Plug>(easymotion-tl)
map f <Plug>(easymotion-sl)
map ;w <Plug>(easymotion-bd-wl)
map ;; <Plug>(easymotion-s2)
inoremap ( ()<C-G>U<Left>
inoremap { {}<C-G>U<Left>

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

" go to next split
nnoremap <tab> <c-w><c-w>

" ----------------------------------------------------------------------------------------------
" keyboard maestro assisted key combinations
 
" <hyper-y> yank selection and save it into a file which is monitored
vnoremap <c-\><c-\> :call It2copy()<cr>

" <cmd-/> comment/uncomment
nmap <c-\>/ <Plug>CommentaryLine<cr>
vmap <c-\>/ <Plug>Commentary

" ----------------------------------------------------------------------------------------------
let mapleader="\<space>"
" set showcmd

" set mouse mode on, show file path
nnoremap <leader><leader> :call ToggleMouse()<CR>
" toggle numbers
nnoremap <leader>nn :call ToggleNumber()<CR>
" toggle highlight search
nnoremap <leader>hh :set hlsearch! hlsearch?<CR>
" go to starting path
nnoremap <leader>[ :e `pwd`<CR>
" new starting path
nnoremap <leader>] :cd <c-r>=expand('%:h')<CR><CR>
" list buffers, move to one
nnoremap <Leader>bb :ls<Cr>:b<Space>
" diff between this buffer and original
nnoremap <leader>bd :w !diff % -<CR>
" go to alternate buffer
nnoremap <leader>ba :b #<CR>
" open finder at current directory
nnoremap <silent> <leader>fi :call GoFinder()<CR>
" magic replace
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>
" show terminal
nnoremap <silent> <leader>tt :call GoTerm()<CR>
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
 
function! It2copy()
    execute "normal! `<v`>y"
    let regInfo = getreg('"')
    call writefile(split(regInfo, "\n"), expand("~/.config/nvim/runcache/vim-clipboard.txt"))
    echo "i2copy"
endfunction
