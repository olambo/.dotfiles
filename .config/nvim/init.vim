" check i1-plug for vim-plug install instructions
 
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

if exists('g:vscode')
  source ~/.config/nvim/i1-plug.vim
  source ~/.config/nvim/i2-base.vim
  source ~/.config/nvim/i2-plus.vim
	source ~/.config/nvim/i3-vscode.vim
else
  source ~/.config/nvim/i1-plug.vim
  source ~/.config/nvim/i2-base.vim
  source ~/.config/nvim/i2-plus.vim
	source ~/.config/nvim/i3-vim.vim
	source ~/.config/nvim/i4-fzf.vim
endif
