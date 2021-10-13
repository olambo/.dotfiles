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

" visual mode <-> visual line mode
xnoremap <expr> v mode() ==# "v" ? "V" : "v"
" visual mode <-> visual block mode
xnoremap <expr> <leader>j mode() ==# "\<c-v>" ? "V" : "\<c-v>"
" take the mode from visual selection - they can get it back by pressing v
xnoremap <expr> j mode() ==# "v" ? "\<c-v>j" : "j"

" select visual line(s)
nnoremap <expr> <leader>v v:count < 2 ? "<esc>vV" : "<esc>vV" . (v:count-1) . "j"
" highlight the line(s) for deletion or change
nnoremap <expr> <bs> v:count < 2 ? "<esc>vV" : "<esc>vV" . (v:count-1) . "j"

" visual to end of line.
nnoremap V v$h
xnoremap V $h
" yank until end of line
nnoremap Y y$

" insert mode no vertical movement"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" move down and up a bit more than normal
nnoremap <up> 5k
nnoremap <down> 5j
xnoremap <up> 5k
xnoremap <down> 5j

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
