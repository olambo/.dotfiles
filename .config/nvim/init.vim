" check i1-plug for vim-plug install instructions
 
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

source ~/.config/nvim/i1-plug.vim
if exists('g:yuz')
  source ~/.config/nvim/i2-base-yuz.vim
else
  source ~/.config/nvim/i2-base.vim
endif
source ~/.config/nvim/i2-plus.vim

if exists('g:vscode')
	source ~/.config/nvim/i3-vscode.vim
else
	source ~/.config/nvim/i3-vim.vim
	source ~/.config/nvim/i4-fzf.vim
endif
