" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> g, b                      -> <pagedown>, <pageup>
"   <hyp> (, )                      -> <home>, <end>

let mapleader="\<space>"

" start of line
nnoremap <home> ^
" visual mode. Don't select the return chr at the end of line
xnoremap <home> ^
xnoremap <end> $h

" makes more sense for b to go back to previous word in visual mode 
xnoremap b ge
xnoremap B gE

nnoremap <leader>v <c-v>j

nnoremap <c-x><c-u> <nop>
noremap <c-x><c-p> <nop>

" yank until end of line
nnoremap Y y$

" insert mode no vertical movement"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" move down and up a bit more than normal
nnoremap <up> 10k
nnoremap <down> 10j
xnoremap <up> 10k
xnoremap <down> 10j

" keep centred
nnoremap n nzzzv
nnoremap N Nzzzv

" various bats and bits
set ignorecase
set smartcase
set splitbelow splitright
set backspace=2
set tabstop=2
set shiftwidth=2
set iskeyword+=-,#
set expandtab
set nu
set textwidth=0
" keep cursor towards center
set scrolloff=10
" gutter space for lsp info on left
set signcolumn=yes
" increased for lsp code actions
" set updatetime=100


"save
nnoremap <space>s :update<cr>

" wipeout buffer
nnoremap <silent> <leader>q :bw<cr>

" very nice but I keep forgeting I have to hit return to keep
set incsearch

" go to next split
nnoremap <leader><leader> <c-w><c-w>

" toggle numbers
noremap <leader>n :set number!<cr>:se norelativenumber<cr>

" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

