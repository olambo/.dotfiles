" check i1-plug for vim-plug install instructions
source ~/.config/nvim/i1-plug.vim
source ~/.config/nvim/i2-base.vim

if exists('g:vscode')
	source ~/.config/nvim/i3-vscode.vim
else
	source ~/.config/nvim/i3-vim.vim
	source ~/.config/nvim/i4-fzf.vim
  source ~/.config/nvim/i5-statusline.vim
endif
