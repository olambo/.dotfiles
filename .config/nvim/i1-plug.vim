" install vim-plug: https://github.com/junegunn/vim-plug
"
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'
if has('nvim')

endif
if !exists('g:vscode')
	Plug 'ojroques/vim-oscyank'
	Plug 'tmsvg/pear-tree'

	Plug 'justinmk/vim-dirvish'
  Plug 'mbbill/undotree'
    
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

  " Macos Terminal only supports 256 colors - for now use
  Plug 'NLKNguyen/papercolor-theme'
  if has('nvim')
     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
     Plug 'Mofiqul/vscode.nvim'
     Plug 'cormacrelf/dark-notify'
  endif
endif

call plug#end()
