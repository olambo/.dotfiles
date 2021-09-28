set visualbell
set noerrorbells
set multiple-cursors
set commentary
set sneak

nnoremap <left> :action MethodUp<CR>
nnoremap <right> :action MethodDown<CR>

nnoremap s :action KJumpAction.Char1<cr>
nnoremap S :action KJumpAction.Char1<cr>

noremap - :action SelectInProjectView<CR>
noremap g- :action ActivateProjectToolWindow<CR>

noremap gd :action GotoDeclaration<CR>
noremap gi :action GotoImplementation<CR>

noremap gu :action ShowUsages<CR>
noremap gt :action Scala.TypeInfo<CR>:action ExpressionTypeInfo<CR>

noremap gs :action GotoSuperMethod<CR>
noremap gr :action Refactorings.QuickListPopupAction<CR>

noremap g; :action JumpToLastChange<CR>
noremap g, :action JumpToNextChange<CR>

noremap gk :action Back<CR>
noremap gj :action Forward<CR>

noremap ge :action GotoNextError<CR>
noremap gE :action GotoPreviousError<CR>

noremap gm :action ToggleBookmark<CR>
noremap gM :action ShowBookmarks<CR>

noremap gb :action ToggleLineBreakpoint<CR>
noremap gB :action ViewBreakpoints<CR>

noremap gf :action FileStructurePopup<CR>
noremap go :action ChooseRunConfiguration<CR>

noremap <A-j> :action EditorCloneCaretBelow<CR>
noremap <A-k> :action EditorCloneCaretAbove<CR>

noremap g<cr> :action ShowIntentionActions<CR>

map <A-l> <Plug>NextWholeOccurrence
map <C-A-l> <Plug>NextOccurrence

map <S-A-l> <Plug>SkipOccurrence
map <A-h> <Plug>RemoveOccurrence

" not editor buffer related
noremap <leader>t :action JumpToLastWindow<CR>
noremap <leader>w :action RestoreDefaultLayout<CR>

noremap <leader>f :action FindInPath<CR>

