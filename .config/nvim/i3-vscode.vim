" sneak with very bright lables!
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
let g:sneak#use_ic_scs = 1

" set up replace on current word
nnoremap <expr> g/ ':%s/'.expand('<cword>').'/'

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

noremap gk <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
noremap gj <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>

noremap ge <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>
noremap gE <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>

noremap go <Cmd>call VSCodeNotify('workbench.action.debug.start')<CR>
noremap g<cr> <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>

noremap g= <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>
noremap <space>s <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
