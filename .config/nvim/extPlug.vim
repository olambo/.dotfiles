function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

if !has("gui_vimr")
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': function('DoRemote') }
  "Plug 'ckipp01/coc-metals', {'do': 'yarn install --frozen-lockfile'}
endif
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
