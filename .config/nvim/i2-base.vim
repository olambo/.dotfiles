 let mapleader="\<space>"

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
set signcolumn=yes

"save
nnoremap <leader>s :update<cr>
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

nnoremap 2v Vj
nnoremap 3v V2j
nnoremap 4v V3j
nnoremap 5v V4j
nnoremap 6v V5j
nnoremap 7v V6j
nnoremap 8v V7j
nnoremap 9v V8j
" vv from normal mode goes into visual mode
vnoremap v V
