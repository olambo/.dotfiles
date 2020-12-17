" hyper key <hyp> == <shift,contol,option,command> down (via karabiner elements)
"   caps-lock                       -> <hyp> on hold, <esc> on press and release
"   <hyp> h, j, k, l                -> <left>, <down>, <up>, <right>
"   <hyp> u, d                      -> <pageup>, <pagedown>
"   <hyp> 9, 0                      -> <home>, <end>

noremap <pageup> <c-u>
noremap <pagedown> <c-d>
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

" close curly brackets
inoremap { {}<C-G>U<Left>

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
set scrolloff=4

autocmd Filetype java,scala,python set expandtab
autocmd Filetype go set noexpandtab
