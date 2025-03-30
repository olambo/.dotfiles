" Open Apple menu | System Preferences | Keyboard | Shortcuts | Services
" command shift a - Disable Search man Page Index in Terminal
"
" turn off various accented forms of the character 
" in terminal type the following line
"      defaults write -g ApplePressAndHoldEnabled -bool false
"

sethandler a:vim

set visualbell
set noerrorbells
set multiple-cursors
set commentary

nnoremap <left> :action MethodUp<CR>
nnoremap <s-left> :action MethodUp<CR>
nnoremap <right> :action MethodDown<CR>

nnoremap - :action RecentFiles<CR>
nnoremap g- :action SelectInProjectView<CR>
nnoremap g<cr> :action ShowIntentionActions<CR>
nnoremap g= :action ReformatCode<CR>

nnoremap gd :action GotoDeclaration<CR>
nnoremap gi :action GotoImplementation<CR>

nnoremap gr :action Refactorings.QuickListPopupAction<CR>
nnoremap gR :action ShowUsages<CR>

nnoremap gt :action ExpressionTypeInfo<CR>
nnoremap gh :action QuickJavaDoc<CR>
nnoremap gH :action ShowHoverInfo<CR>

nnoremap gs :action FileStructurePopup<CR>
nnoremap gS :action GotoSuperMethod<CR>

nnoremap g; :action JumpToLastChange<CR>
nnoremap g, :action JumpToNextChange<CR>

"noremap gk :action Back<CR>
"noremap gj :action Forward<CR>

nnoremap ge :action GotoNextError<CR>
nnoremap gE :action GotoPreviousError<CR>

nnoremap gb :action ToggleLineBreakpoint<CR>
nnoremap gB :action ViewBreakpoints<CR>

nnoremap gO :action Debug<CR>
nnoremap go :action ContextRun<CR>

nnoremap <A-j> :action EditorCloneCaretBelow<CR>
nnoremap <A-k> :action EditorCloneCaretAbove<CR>

nnoremap gm :action ToggleBookmark<CR>
nnoremap gM :action ShowBookmarks<CR>

map <A-l> <Plug>NextWholeOccurrence
map <C-A-l> <Plug>NextOccurrence

map <S-A-l> <Plug>SkipOccurrence
map <A-h> <Plug>RemoveOccurrence
" not editor buffer related
" noremap <leader>t :action JumpToLastWindow<CR>
" noremap <leader>w :action RestoreDefaultLayout<CR>

nnoremap ga :action SearchEverywhere<CR>
nnoremap gf :action GotoFile<CR>
nnoremap gF :action FindInPath<CR>
