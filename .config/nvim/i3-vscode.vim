" nnoremap <M-A-C-S-'> w
" noremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>
" noremap gd <Cmd>call VSCodeNotify('editor.action.goToDefinition')<CR>
noremap - <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
noremap gf <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

noremap gI <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
noremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
noremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

noremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
noremap gR <Cmd>call VSCodeNotify('editor.action.rename')<CR>

noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

noremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
noremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

noremap go <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>
noremap g<cr> <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

noremap g= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
noremap <space>s <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>

noremap gm <Cmd>call VSCodeNotify('workbench.action.terminal.openNativeConsole')<CR>

