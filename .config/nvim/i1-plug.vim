" install vim-plug: https://github.com/junegunn/vim-plug
 
" install node
" install python for coc
" python3 -m pip install --user --upgrade pynvim

call plug#begin('~/.config/nvim/plugged')

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
if !exists('g:vscode')
	Plug 'ojroques/vim-oscyank'
	Plug 'tmsvg/pear-tree'
	Plug 'NLKNguyen/papercolor-theme'
	Plug 'justinmk/vim-dirvish'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
    " vim as ide?
    " Plug 'scalameta/nvim-metals'
    " Plug 'nvim-lua/completion-nvim'
endif

call plug#end()
