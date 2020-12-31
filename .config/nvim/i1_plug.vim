call plug#begin('~/.config/nvim/plugged')

Plug 'justinmk/vim-sneak'
if !exists('g:vscode')
	Plug 'tmsvg/pear-tree'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'justinmk/vim-dirvish'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
  	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  	Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif

call plug#end()
