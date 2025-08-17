" install vim-plug: https://github.com/junegunn/vim-plug
"
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-commentary'
if !exists('g:vscode')
	Plug 'justinmk/vim-dirvish'
    
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

  " Macos Terminal only supports 256 colors - for now use
  Plug 'NLKNguyen/papercolor-theme'
  if has('nvim')
     Plug 'Mofiqul/vscode.nvim'
  endif
endif

call plug#end()
