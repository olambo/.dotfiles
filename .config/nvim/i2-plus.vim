" use hyp-m or cmd-/ to comment 
nmap <C-_> gcc
xmap <C-_> gc

" down when number given: j, otherwise gj. (similar with k)
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'

" insert undo
inoremap <c-x><c-u> <esc>u

" paste from yank register
inoremap <c-x><c-p> <c-r><c-o>0
cnoremap <c-x><c-p> <c-r><c-o>0
xnoremap <c-x><c-p> "0p
nnoremap <c-x><c-p> "0p

" cut - copy to yank register, then delete - no hyper key for this
xnoremap <c-x>x ygvd

" on <cr> dont hide closing bracket. don't need . repeat here
let g:pear_tree_repeatable_expand = 0
" this stops expansion on <CR> but no mapping in karabiner elements. Probably can remove
imap <c-x><c-e> <Plug>(PearTreeExpand)

" always show line numbers, but only in current window.
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber

" jump list
nnoremap gk <c-o>
nnoremap gj <c-i>

set belloff=all
set mouse=nv " this is not going to allow command-c. can use option-mouse or turn off

" set up replace on current word
noremap <expr> g/ ':%s/'.expand('<cword>').'//gIc<Left><Left><Left><Left>'

if has('nvim')
  " nvim and vim appear incompatible here
  set dir=~/.config/nvim-data/swapfiles
  set backup
  set backupdir=~/.config/nvim-data/backupfiles
  set undofile
  set undodir=~/.config/nvim-data/undofiles

  source ~/.config/nvim/vi-ka.vim
:lua <<EOF
  require('vi-ka')
  require('vi-ke-example-keys')
EOF
endif
