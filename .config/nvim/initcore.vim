" Base configuration for hyper-key
" Apple macOS hyper-keys were created/assigned via karabiner-elements and keyboard maestro
" No ctrl-key mappings have been harmed by hyper-key. They are separate keys!

" hyper-key is assigned to caps-lock (<esc> on single press) 
" hyper-key is also assigned to ';'  (';' on single press)
 
" hyper-key movement: hyper-(h,j,k,l,a,e,n,b) 
" hyper-key movement keys can be used in and out of vim.
"   hyper hyper-hjkl -> assigned to left,down,up,right arrow keys 
"   hyper-n and hyper-b (next-page, back-a-page) -> pagedown, pageup 
"   hyper-a and hyper-e -> ctrl-a, ctrl-e (emacs/macOS start, end of line)
 
" move between splits
nnoremap <Left> <C-W>h
nnoremap <Down> <C-W>j
nnoremap <Up> <C-W>k
nnoremap <Right> <C-W>l

" scroll up and down by a fixed amount 
nnoremap <pagedown> 10<c-d>
nnoremap <pageup> 10<c-u>
vnoremap <pagedown> 5<c-d>
vnoremap <pageup> 5<c-u>

" use emacs/macOS start and end of line
nnoremap <C-a> ^
nnoremap <C-e> $
vnoremap <C-a> ^
noremap <C-e> $
" move in insert mode (hyper-hjkl arrow keys already allow movement)
inoremap <C-a> <C-O>^
inoremap <C-e> <C-O>$
" move in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" yank until end of line. Now works like C, D.
nnoremap Y y$

" down by one line gj, or when down by multiples j
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" q! and Q! quit without saving
command-bang Q q<bang>

" various
set ic
set smartcase
set expandtab
set splitbelow splitright
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#
set number relativenumber
set scrolloff=4

" simple leader. 
let mapleader=' '

" try to stay out of command mode. Use ZQ to quit without saving.
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
" split quickly
nnoremap <silent> <leader>h :split<cr>
nnoremap <silent> <leader>v :vsplit<cr>
" set number on and off via toggle
nnoremap <silent> <leader>n :set number! relativenumber!<cr>

" these lead to unintended consequences while they are not set to something
nnoremap <leader>x :echoerr 'You typed "<leader>x". Use "x" to delete'<cr>
nnoremap <leader>i :echoerr 'You typed "<leader>i". Use "i" to insert'<cr>
nnoremap <leader>s :echoerr 'You typed "<leader>s". Use "<leader>w" to write file'<cr>
nnoremap <leader>a :echoerr 'You typed "<leader>a". Use "a" to append'<cr>
nnoremap <leader>d :echoerr 'You typed "<leader>d". Use "d" to delete'<cr>
nnoremap <leader>c :echoerr 'You typed "<leader>c". Use "c" to change'<cr>
nnoremap <leader>o :echoerr 'You typed "<leader>o". Use "o" to open line'<cr>
nnoremap <leader>p :echoerr 'You typed "<leader>p". Use "p" to paste'<cr>
nnoremap <leader>r :echoerr 'You typed "<leader>r". Use "r" to replace'<cr>
nnoremap <leader>u :echoerr 'You typed "<leader>u". Use "u" to undo'<cr>

