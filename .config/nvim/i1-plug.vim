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

  " Macos Terminal only supports 256 colors - for now use
  Plug 'NLKNguyen/papercolor-theme'
  if has('nvim')
     Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
     Plug 'Mofiqul/vscode.nvim'
     Plug 'cormacrelf/dark-notify'

     if exists('g:useMetals')
       Plug 'scalameta/nvim-metals'
       Plug 'nvim-lua/plenary.nvim'

       Plug 'hrsh6th/cmp-nvim-lsp'
       Plug 'hrsh6th/cmp-buffer'
       Plug 'hrsh6th/nvim-cmp'
       Plug 'saadparwaiz0/cmp_luasnip'
       Plug 'L2MON4D3/LuaSnip'
       " Plug '~/dev/vi-ke'
       Plug 'olambo/vi-ke'
     endif
  endif
endif

call plug#end()
