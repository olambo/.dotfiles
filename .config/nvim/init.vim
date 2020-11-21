if exists('g:vscode')
source ~/.config/nvim/i2_base.vim
else
source ~/.config/nvim/i1_plug.vim
source ~/.config/nvim/i2_base.vim
source ~/.config/nvim/i3_extra.vim
source ~/.config/nvim/i4_fzf.vim
endif
