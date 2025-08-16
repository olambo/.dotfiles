"nnoremap nnoremap <M-A-C-S-'> w
" already defined
" nnoremap gd <Cmd>call VSCodeNotify('editor.action.goToDefinition')<CR>
" 

autocmd BufLeave,BufEnter * set modifiable

nnoremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

nnoremap - <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
nnoremap g- <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

noremap gI <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
nnoremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap gR <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>

"noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
"noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

nnoremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
nnoremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

nnoremap go <Cmd>call VSCodeNotify('python.execInTerminal-icon')<CR>
nnoremap gO <Cmd>call VSCodeNotify('workbench.action.debug.run')<CR>

nnoremap g<cr> <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

nnoremap g= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

nnoremap ga <Cmd>call VSCodeNotify('workbench.action.showCommands')<CR>

nnoremap <leader><leader> :

nnoremap <cr> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <leader>v <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
