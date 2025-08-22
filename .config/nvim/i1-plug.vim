" install vim-plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
if !exists('g:vscode')
    Plug 'MeanderingProgrammer/render-markdown.nvim'
    Plug 'justinmk/vim-dirvish'
    
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " macOS Terminal only supports 256 colors - for now use
    Plug 'NLKNguyen/papercolor-theme'
    if has('nvim')
        Plug 'Mofiqul/vscode.nvim'
    endif
endif
call plug#end()

" Setup render-markdown after plugins are loaded
if !exists('g:vscode')
    lua local ok, rm = pcall(require, 'render-markdown'); if ok then rm.setup({enabled = false}) end
    
    " Keep render-markdown disabled by default
    autocmd BufEnter *.md lua pcall(function() require('render-markdown').disable() end)
    autocmd BufLeave *.md lua pcall(function() require('render-markdown').disable() end)
endif
