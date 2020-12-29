call plug#begin('~/.config/nvim/plugged')

Plug 'justinmk/vim-sneak'
if !exists('g:vscode')
	Plug 'tmsvg/pear-tree'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'justinmk/vim-dirvish'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf'

	if !has("gui_vimr")
  		Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  		Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
	endif
endif

call plug#end()
