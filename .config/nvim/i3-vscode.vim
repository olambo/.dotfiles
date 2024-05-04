"nnoremap nnoremap <M-A-C-S-'> w
" noremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>
" noremap gd <Cmd>call VSCodeNotify('editor.action.goToDefinition')<CR>
noremap - <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
noremap gf <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

noremap gI <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
noremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
noremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

noremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
noremap cd <Cmd>call VSCodeNotify('editor.action.rename')<CR>

noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

noremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
noremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

noremap go <Cmd>call VSCodeNotify('workbench.action.debug.run')<CR>
noremap g<cr> <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

noremap g= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

nnoremap <leader><leader> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
nnoremap <leader>v <Cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
