let mapleader="\<space>"

nnoremap e <nop>
nnoremap s <nop>
nnoremap v <nop>
nnoremap ep p
nnoremap p :
" normal and visual
noremap eo o
noremap a i
noremap ea a
noremap ee e
noremap i b
noremap o w
noremap eh ^
noremap el $

noremap m 10j| noremap , 10k

" visual normal and visual mode mappings
noremap ss V| noremap S v$h
" visual normal mode mappings
nnoremap gs gv
nnoremap sl v
nnoremap sw viw
nnoremap sj V9j
nnoremap sk vi"
nnoremap s; vi'
nnoremap si vi)
nnoremap sak va"
nnoremap s. v$h
nnoremap sn v^  
" visual only mode mapping
vnoremap sh <c-v>
vnoremap sn v
vnoremap s. $h
nnoremap saw vaw
nnoremap siw viw

nnoremap gm G

" insert mode no vertical movement"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <pageup> <nop>
inoremap <pagedown> <nop>

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
