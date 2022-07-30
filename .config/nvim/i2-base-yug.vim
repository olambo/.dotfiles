let mapleader="\<space>"

" left hand
noremap u f| noremap z u| noremap Z <c-r>
noremap e v| noremap E v$h
noremap h c| noremap H C| noremap k d| noremap K D| noremap q :

" right hand
nnoremap d 10k| nnoremap l 10j
noremap f h| noremap s j| noremap t k| noremap r l| noremap n ;| noremap N ,
noremap c n| noremap C N| noremap m 0| noremap v $| noremap j r

" Explore Visual select mode left
nnoremap E v$h
noremap ee V
nnoremap ec v<c-v>j| vnoremap ec <c-v>| noremap em V

" insert mode no vertical movement"
inoremap <up> <nop>| inoremap <down> <nop>| inoremap <pageup> <nop>| inoremap <pagedown> <nop>

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
