" sneak with very bright lables!
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S

" down when number given: j, otherwise gj. (similar with k)
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

noremap - <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
" noremap gf <Cmd>call VSCodeNotify('workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup')<CR>
noremap gf <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

" noremap gd <Cmd>call VSCodeNotify('editor.action.goToDefinition')<CR>
noremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>

noremap gu <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
noremap gt <Cmd>call VSCodeNotify('editor.action.showHover')<CR>

noremap gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

noremap gh <Cmd>call VSCodeNotify('workbench.action.navigateToLastEditLocation')<CR>
noremap gl <Cmd>call VSCodeNotify('workbench.action.navigateToNextEditLocation')<CR>

noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

noremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
noremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

noremap go <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>