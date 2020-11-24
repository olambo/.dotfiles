call plug#begin('~/.config/nvim/plugged')

Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'olambo/vim-lightline-tea'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/fzf'

if !has("gui_vimr")
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif

call plug#end()
