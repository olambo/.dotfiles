call plug#begin('~/.config/nvim/plugged')

Plug 'NLKNguyen/papercolor-theme'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'

if !has("gui_vimr")
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif

call plug#end()
