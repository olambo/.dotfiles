let mapleader="\<space>"

nnoremap s <nop>
vnoremap s v
noremap v <nop>
nnoremap e <nop>
nnoremap ep p
nnoremap p :
" text objects
nnoremap di di| nnoremap da da| nnoremap ci ci| nnoremap ca ca| nnoremap si vi| nnoremap sa va| nnoremap vi <nop>| nnoremap va <nop>
" normal and visual"
noremap eo o
noremap a i
noremap ea a
noremap ee e
noremap o w
noremap eh ^
noremap el $

noremap m 10j| noremap , 10k

" visual normal and visual mode mappings
noremap ss V| noremap S v$h
" visual normal mode mappings
nnoremap gs gv
nnoremap sw viw
nnoremap sm v<c-v>j| noremap sh v
nnoremap su vi'
nnoremap sj vi"
nnoremap sk vi)
nnoremap S v$h
" visual only mode mapping
vnoremap sm <c-v>
vnoremap s. $h
nnoremap saw vaw
nnoremap siw viw

noremap i b
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
