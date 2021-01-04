" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> f, b                      -> <pagedown>, <pageup>
"   <hyp> (, )                      -> <home>, <end>

" insert mode no movement
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

" insert mode drop down list selection.
inoremap <down> <c-n>
inoremap <up> <c-p>
inoremap <expr> <left> pumvisible() ? "\<C-e>" : "\<left>"

" next previous paragraph, start of text
nnoremap <down> }E^
nnoremap <up> {{E^
" move a bit
nnoremap <left> B
nnoremap <right> W

" move to start and end of paragraphs and to the end of Words
vnoremap <down> j}gE
vnoremap <up> k{
vnoremap <left> gE
vnoremap <right> E

" yank until end of line (ie. work like C, D)
nnoremap Y y$

" down when number given: j, otherwise gj. (similar with k)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" various bats and bits
set ignorecase
set smartcase
set splitbelow splitright
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#

" for most enviroments don't want tab spacing. But for Go, go fmt uses tabs
autocmd Filetype java,scala,python set expandtab
autocmd Filetype go set noexpandtab

let mapleader="\<space>"

" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

" go to next split
nmap <leader><leader> <c-w><c-w>

" toggle numbers
noremap <leader>n :set number!<cr>:se norelativenumber<cr>

" <hyper-y> copy to system clipboard. This is overriden, if i3_extra is used.
vnoremap <c-x><c-y> "+y
