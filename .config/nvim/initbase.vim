
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
set number relativenumber
set backspace=2
set tabstop=4
set shiftwidth=4
set iskeyword+=-,#
set scrolloff=4
set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off

" ----------------------------------------------------------------------------------------------
" keyboard maestro translates between <cmd> na <hyp> to <c-\>... key combinations
" <hyp> == hold hyper key down
" <cmd> == hold command key down
 
" <cmd-c> | <hyp-y> to system copy
vmap <c-\><c-\> <Plug>SystemCopy
xmap <c-\><c-\> <Plug>SystemCopy
nmap <c-\><c-\><c-\><c-\> <Plug>SystemCopyLine

" <cmd-/> comment/uncomment
nmap <C-\>/ <Plug>CommentaryLine<cr>
vmap <C-\>/ <Plug>Commentary

" <hyp-cr> move between splits
nnoremap <c-\><c-w> <c-w>w
tnoremap <c-\><c-w> <C-\><C-n><c-w>w

" ----------------------------------------------------------------------------------------------
" leader of the pack. 
let mapleader="\<space>"

" magic replace
nnoremap <leader>/ :%s/\v/gc<Left><Left><Left>
" toggle number on and off
nnoremap <silent> <leader>nn :set number! relativenumber!<cr> 
" highlight off
nnoremap <leader><leader> :nohlsearch<Bar>:echo<CR>

" these lead to unintended consequences if they are not set to something
nnoremap <leader>i :echoerr 'You typed "<leader>i". Use "i" to insert'<cr>
nnoremap <leader>s :echoerr 'You typed "<leader>s". Use "<leader>w" to write file'<cr>
nnoremap <leader>a :echoerr 'You typed "<leader>a". Use "a" to append'<cr>
nnoremap <leader>d :echoerr 'You typed "<leader>d". Use "d" to delete'<cr>
nnoremap <leader>c :echoerr 'You typed "<leader>c". Use "c" to change'<cr>
nnoremap <leader>o :echoerr 'You typed "<leader>o". Use "o" to open line'<cr>
nnoremap <leader>p :echoerr 'You typed "<leader>p". Use "p" to paste'<cr>
nnoremap <leader>r :echoerr 'You typed "<leader>r". Use "r" to replace'<cr>
nnoremap <leader>u :echoerr 'You typed "<leader>u". Use "u" to undo'<cr>
nnoremap <leader>x :echoerr 'You typed "<leader>x". Use "x" to delete'<cr>
 
