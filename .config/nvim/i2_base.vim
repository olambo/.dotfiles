" hyper: vim inspired key movement, inside and outside of vim.

" Apple macOS hyper-keys created/assigned/mapped via karabiner-elements (low level) and keyboard-maestro (higer level)
" hyper key: <hyp> == hyper key == hold <caps-lock> down == hold <shift,contol,option,command> down
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp-h>, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp-b>, n (go-back, go-next)   -> <pageup>, <pagedown> (adequate? scrolling without ctrl-f,b,d,u,e,y).
"   <hyp-9>, 0, [, ]                -> <home>, <end>, <prev-tab>, <next-tab>

nnoremap <pageup> 10<c-u>
nnoremap <pagedown> 10<c-d>
vnoremap <pageup> 10<c-u>
vnoremap <pagedown> 10<c-d>
" insert mode no movement
inoremap <pagedown> <nop>
inoremap <pageup> <nop>

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

" both q! and Q! quit without saving
command-bang Q q<bang>

" various bats and bits
set ignorecase
set smartcase
set expandtab
set splitbelow splitright
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#
set scrolloff=4
