" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> g, b                      -> <pagedown>, <pageup>
"   <hyp> (, )                      -> <home>, <end>

let mapleader="\<space>"

" visual mode to start, end of line
xnoremap <home> ^
xnoremap <end> $
" visual mode <-> visual line mode
xnoremap <expr> v mode() ==# "v" ? "V" : "v"
" visual mode <-> visual block mode
xnoremap <expr> <leader>j mode() ==# "\<c-v>" ? "V" : "\<c-v>"
xnoremap <expr> j mode() ==# "v" ? "\<c-v>j" : "j"

" select line mode via number
nnoremap <expr> <leader>v '<esc>vV' . (v:count1) . 'jk'

" start of line
nnoremap <home> ^

" insert mode no movement"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" move down and up a bit more than normal
nnoremap <up> 5k
nnoremap <down> 5j
xnoremap <up> 5k
xnoremap <down> 5j

" yank until end of line (ie. work like C, D)
nnoremap Y y$
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
set ruler
set expandtab
set nu

"save
nnoremap <space>s :update<cr>

" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

" go to next split
nnoremap <leader><leader> <c-w><c-w>

" toggle numbers
noremap <leader>n :set number!<cr>:se norelativenumber<cr>

" wipeout buffer
nnoremap <silent> <leader>q :bw<cr>
