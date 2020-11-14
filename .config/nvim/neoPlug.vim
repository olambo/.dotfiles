function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

if !has("gui_vimr")
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': function('DoRemote') }
endif
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
