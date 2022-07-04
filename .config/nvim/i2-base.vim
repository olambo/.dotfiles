let mapleader="\<space>"

" left hand
noremap q u| noremap w d| noremap e y| noremap r p| noremap t <c-r>
vnoremap a $h| nnoremap s i| vnoremap s <nop>| nnoremap d <nop>| vnoremap d v| noremap D v$h
noremap z .| noremap c <nop>| noremap v c| noremap V C

" right hand
noremap u n| noremap U N| noremap i b| nnoremap o w| vnoremap o e| noremap p <nop>

" Explore Visual select mode left
nnoremap da va| nnoremap ds vi| noremap dd V
" Visual mode right
nnoremap du vi"| nnoremap do viw| vnoremap fo $h
nnoremap dl v| nnoremap dj v<c-v>j| vnoremap dj <c-v>

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
