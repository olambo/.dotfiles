map <leader>; <Plug>Sneak_s
nmap <leader>, <Plug>Sneak_S
let g:sneak#use_ic_scs = 1

" use hyp-m or cmd-/ to comment 
nmap <c-x><c-m> gcc
xmap <c-x><c-m> gc
nmap <C-_> gcc
xmap <C-_> gc

" down when number given: j, otherwise gj. (similar with k)
nnoremap <silent> <expr> j v:count ? 'j' : 'gj'
nnoremap <silent> <expr> k v:count ? 'k' : 'gk'

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
source ~/.config/nvim/vi-ka.vim
" nvim and vim appear incompatible here
set dir=~/.config/nvim-data/swapfiles
set backup
set backupdir=~/.config/nvim-data/backupfiles
set undofile
set undodir=~/.config/nvim-data/undofiles

:lua <<EOF
require('vi-ka')
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { },               -- List of parsers to ignore installing
  highlight = {
    enable = true,                    -- false will disable the whole extension
    disable = { },                    -- list of language that will be disabled
  },
}
EOF
endif
