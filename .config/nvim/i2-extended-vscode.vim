"==============================================================================
" SIMPLE VSCODE BOOKMARK WRAPPER
" Direct wrapper around VSCode Bookmarks extension API
"==============================================================================

function! SetBookmarkMark()
    " Move to beginning of line first
    normal! ^
    call VSCodeNotify('bookmarks.toggle')
endfunction

function! JumpToNextBookmark()
    call VSCodeNotify('bookmarks.jumpToNext')
endfunction

function! JumpToPrevBookmark()
    call VSCodeNotify('bookmarks.jumpToPrevious')
endfunction

function! ClearAllBookmarks()
    call VSCodeNotify('bookmarks.clearFromAllFiles')
    echo 'All bookmarks cleared'
endfunction

function! ListBookmarks()
    call VSCodeNotify('bookmarks.listFromAllFiles')
endfunction

"------------------------------------------------------------------------------
" MAPPINGS AND COMMANDS
"------------------------------------------------------------------------------
nnoremap <silent> mm :call SetBookmarkMark()<CR>
nnoremap <silent> <C-o> :call JumpToPrevBookmark()<CR>
nnoremap <silent> <C-i> :call JumpToNextBookmark()<CR>

command! C call ClearAllBookmarks()
command! S call ListBookmarks()
