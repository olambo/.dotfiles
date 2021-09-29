" install vim-plug: https://github.com/junegunn/vim-plug
"
call plug#begin('~/.config/nvim/plugged')

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
if !exists('g:vscode')
	Plug 'ojroques/vim-oscyank'
	Plug 'tmsvg/pear-tree'

	Plug 'justinmk/vim-dirvish'
    Plug 'mbbill/undotree'
    
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

    Plug 'kamykn/spelunker.vim'

    if has('nvim')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        " change vscPopupBack = '#f7f0f7'
        Plug 'Mofiqul/vscode.nvim'
    endif

    if exists('g:useMetals')
        Plug 'scalameta/nvim-metals'
        Plug 'nvim-lua/completion-nvim'
    endif
endif

call plug#end()
