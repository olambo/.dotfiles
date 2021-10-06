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
        Plug 'cormacrelf/dark-notify'
    endif
    " Macos Terminal only supports 256 colors - for now use
    Plug 'NLKNguyen/papercolor-theme'

    if exists('g:useMetals')
        Plug 'scalameta/nvim-metals'
        Plug 'nvim-lua/plenary.nvim'

        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/nvim-cmp'
        Plug 'saadparwaiz1/cmp_luasnip'
        Plug 'L3MON4D3/LuaSnip'
    endif
endif

call plug#end()
