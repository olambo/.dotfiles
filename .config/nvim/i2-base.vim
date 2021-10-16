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

" select visual mode, or if a number is first pressed, visual block mode
nnoremap <expr> v v:count == 0 ? "<esc>v" : v:count == 1 ? "<esc>vV" : "<esc>vV" . (v:count-1) . "j"
" visual block mode - select extra line to start with
nnoremap <leader>v <c-v>j

" visual mode <-> visual line mode
xnoremap <expr> v mode() ==# "v" ? "V" : "v"
" visual mode <-> visual block mode
xnoremap <expr> <leader>v mode() ==# "\<c-v>" ? "V" : "\<c-v>"

" visual to end of line.
nnoremap V v$h
xnoremap V $h
" yank until end of line
nnoremap Y y$

" move undo and repeat to hyp-u, hyp-.
nnoremap . <nop>
nnoremap u <nop>
nnoremap <c-x>. .
nnoremap <c-x><c-u> u

" move paste to hyp-p
nnoremap p <nop>
nnoremap P <nop>
" normal mode, paste from unnamed register (gets line deletes)
nnoremap <c-x><c-p> ""p
" paste before, from unnamed register
nnoremap <leader><c-x><c-p> P
" other modes paste from yank register
inoremap <c-x><c-p> <c-r><c-o>0
cnoremap <c-x><c-p> <c-r><c-o>0
vnoremap <c-x><c-p> "0p
" cut - copy to yank register, then delete
xnoremap x ygvd

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
set expandtab
set nu
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

