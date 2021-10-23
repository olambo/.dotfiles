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
let g:sneak#label = 1
autocmd ColorScheme * hi Sneak guifg=green guibg=LightMagenta ctermfg=black ctermbg=LightMagenta
autocmd ColorScheme * hi SneakScope guifg=white guibg=grey ctermfg=white ctermbg=grey

sign define kehl numhl=Kelight

function! HighlightLineno()
  let ln = line('.')
  if exists("b:hiLn") && b:hiLn == ln
    return
  endif
  sign unplace 2 group=*
  let a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -10]
  for l in a
    let lnx = l + ln
    if ln > 0
      exec 'sign place 2 name=kehl line=' . lnx
    endif
  endfor
  highlight Kelight ctermfg=brown guifg=orange
  let b:hiLn = ln
endfunction

autocmd! CursorMoved * :call HighlightLineno()

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
" allow sneak to have the s key
" map <leader>; <Plug>Sneak_s
" map <leader>, <Plug>Sneak_S
unmap <f99>
