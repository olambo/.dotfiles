let mapleader="\<space>"

" prevent some 1 lowercase key alterations to buffer
nnoremap a <nop>| nnoremap s <nop>| nnoremap u <nop>| nnoremap . <nop>
nnoremap aa a
nnoremap ai i
nnoremap au u
nnoremap a. .
" normal and visual
noremap ao o

" right hand mappings
noremap u n|noremap U N| noremap i b| noremap o e
noremap n ^| noremap m 10j| noremap , 10k| noremap . $

" visual normal and visual mode mappings
noremap v <nop>| noremap vv V| noremap V v$h
" visual normal mode mappings
nnoremap vl v
nnoremap vw viw
nnoremap vj V3j
nnoremap vk vi"
nnoremap v; vi'
nnoremap vi vi)
nnoremap vak va"
nnoremap v. v$h
" visual only mode mapping
vnoremap vh <c-v>
vnoremap vn v
vnoremap . $h

" quick mods on words
nnoremap ciw ciw
nnoremap diw diw
nnoremap c. C
nnoremap y. y$
nnoremap d. D

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
