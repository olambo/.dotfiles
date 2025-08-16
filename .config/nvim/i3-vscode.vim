"nnoremap nnoremap <M-A-C-S-'> w
" already defined
" nnoremap gd <Cmd>call VSCodeNotify('editor.action.goToDefinition')<CR>

" Navigate wrapped lines: visual lines by default, logical lines with counts
" Note: Uses nmap (recursive) instead of nnoremap - VSCode Neovim plugin
" doesn't handle non-recursive mappings properly for gj/gk commands
nmap <silent> <expr> j v:count ? 'j' : 'gj'
nmap <silent> <expr> k v:count ? 'k' : 'gk'
set wrap

autocmd BufLeave,BufEnter * set modifiable

nnoremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

nnoremap - <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
nnoremap g- <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

noremap gI <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap gR <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

nnoremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

nnoremap go <Cmd>call VSCodeNotify('python.execInTerminal-icon')<CR>
nnoremap gO <Cmd>call VSCodeNotify('workbench.action.debug.run')<CR>

nnoremap g<cr> <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

nnoremap g= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

nnoremap ga <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>

nnoremap <cr> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <leader>v <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
