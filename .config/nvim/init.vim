call plug#begin('~/.local/share/nvim/plugged')
source ~/.config/nvim/essentialPlug.vim
source ~/.config/nvim/extPlug.vim
call plug#end()

source ~/.config/nvim/initbase.vim
source ~/.config/nvim/essential.vim
source ~/.config/nvim/extone.vim
if !has("gui_vimr")
  source ~/.config/nvim/extcoc.vim
endif
