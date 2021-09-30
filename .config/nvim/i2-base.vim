" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> g, b                      -> <pagedown>, <pageup>
"   <hyp> (, )                      -> <home>, <end>

" start of line
nnoremap <home> ^

" visual block mode to start, end of line
 xnoremap <home> ^
 xnoremap <end> $

" insert mode no movement
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" move down and up a bit more than normal
nnoremap <up> 5k
nnoremap <down> 5j
vnoremap <up> 5k
vnoremap <down> 5j

" next previous paragraph, start of text
nnoremap <left> {{E^
nnoremap <right> }E^
vnoremap <left> k{
vnoremap <right> j}gE

" yank until end of line (ie. work like C, D)
nnoremap Y y$

" various bats and bits
set ignorecase
set smartcase
set splitbelow splitright
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#
set ruler
set expandtab
set nu

let mapleader="\<space>"

"visual block
noremap <leader>v <c-v>

"save
nnoremap <space>s :update<cr>

" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

" go to next split
nmap <leader><leader> <c-w><c-w>

" toggle numbers
noremap <leader>n :set number!<cr>:se norelativenumber<cr>
