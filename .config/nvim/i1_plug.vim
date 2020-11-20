packadd minpac

call minpac#init()

" k-takata/minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('christoomey/vim-system-copy')
call minpac#add('justinmk/vim-dirvish')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('itchyny/lightline.vim')
call minpac#add('olambo/vim-lightline-tea')
call minpac#add('NLKNguyen/papercolor-theme')
call minpac#add('junegunn/fzf')
call minpac#add('neovim/nvim-lsp')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('scalameta/nvim-metals')

" To install or update plugins:
" call minpac#update()
packloadall

if has('nvim')
lua << EOF
require'lspconfig'.metals.setup{}
EOF
endif
