" minimal settings
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

let mapleader="\<space>"
" very nice but I keep forgeting I have to hit return to keep
set incsearch

" toggle numbers
nnoremap <leader>n :set number!<cr>:se norelativenumber<cr>
" toggle highlight search
nnoremap <leader>h :set hlsearch! hlsearch?<cr>

" split management
nnoremap <leader><leader> <C-w><C-w>
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
nnoremap <leader>f :q<cr>
nnoremap <leader>q <C-w>c

" like rest of macos
inoremap <C-d> <Del>
" tiresome to type colon
nnoremap <cr> :
" hard to type slash
nnoremap s /

" vv from normal mode goes into visual line mode
vnoremap v V
" visual line mode by nr of lines
nnoremap 1v V
nnoremap 2v Vj
nnoremap 3v V2j
nnoremap 4v V3j
nnoremap 5v V4j
nnoremap 6v V5j
nnoremap 7v V6j
nnoremap 8v V7j
nnoremap 9v V8j
