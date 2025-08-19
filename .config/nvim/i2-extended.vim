"==============================================================================
" ROTATING MARK SYSTEM
"==============================================================================
" A smart bookmark system that automatically rotates through the top row keys
" (QWERTYUIOP) for setting marks, with efficient navigation between only the
" marks that have been set.
"
" Features:
" - Automatic mark rotation: No need to remember which marks are free
" - Smart navigation: Only cycles through marks you've actually set
" - Session persistence: Cleans up orphaned marks from previous sessions
" - Simple interface: One key to set, two keys to navigate
"
" Usage:
"   md        - Set mark at current position (auto-rotates Q->W->E->...->P->Q)
"   Ctrl-O    - Jump to previous valid mark
"   Ctrl-I    - Jump to next valid mark  
"   :C        - Clear all marks and reset system
"
"==============================================================================

" The queue of available mark letters (top row of keyboard)
let g:MarkQueue = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']

" Index pointing to the next mark to be set (rotates 0-9)
let g:CurrentMarkIndex = 0

" List of marks that have actually been set (subset of MarkQueue)
" Used for navigation to avoid jumping to non-existent marks
let g:ValidMarks = []

" Current position in ValidMarks list for navigation (0-based)
let g:NavMarkIndex = 0

" Clear all marks and reset the tracking system
" Called manually via :C command or automatically when starting fresh
function! ClearMyMarks()
    delmarks QWERTYUIOP              " Remove all marks Q through P
    let g:CurrentMarkIndex = 0       " Reset to start of rotation
    let g:ValidMarks = []            " Clear the valid marks list
    let g:NavMarkIndex = 0           " Reset navigation position
endfunction

" Set a mark at the current cursor position using automatic rotation
" Handles session restarts by clearing orphaned marks when ValidMarks is empty
function! SetNextMark()
    " If ValidMarks is empty but we're setting a mark, we possibly restarted
    " the editor and have orphaned marks from the previous session
    if len(g:ValidMarks) == 0
        call ClearMyMarks()
    endif
    
    " Get the next mark letter from our rotation queue
    let mark = g:MarkQueue[g:CurrentMarkIndex]
    
    " Set the mark at current cursor position
    execute "silent! normal! m" . mark
    
    " Track this mark as valid if it's not already tracked
    " (Handles case where we've rotated back to reuse a mark letter)
    if index(g:ValidMarks, mark) == -1
        call add(g:ValidMarks, mark)
    endif
    
    " Advance to next position in rotation (wraps back to 0 after P)
    let g:CurrentMarkIndex = (g:CurrentMarkIndex + 1) % len(g:MarkQueue)
endfunction

" Navigate to the next valid mark in the list
" Cycles through only the marks that have actually been set
function! JumpToNextValidMark()
    " Nothing to navigate if no marks are set
    if len(g:ValidMarks) == 0
        return
    endif
    
    " Move to next mark in the valid marks list (wraps to start)
    let g:NavMarkIndex = (g:NavMarkIndex + 1) % len(g:ValidMarks)
    let mark = g:ValidMarks[g:NavMarkIndex]
    
    " Jump to the mark (using ' to go to beginning of marked line)
    execute "silent! normal! '" . mark
endfunction

" Navigate to the previous valid mark in the list
" Cycles through only the marks that have actually been set
function! JumpToPrevValidMark()
    " Nothing to navigate if no marks are set
    if len(g:ValidMarks) == 0
        return
    endif
    
    " Move to previous mark in the valid marks list (wraps to end)
    let g:NavMarkIndex = (g:NavMarkIndex - 1 + len(g:ValidMarks)) % len(g:ValidMarks)
    let mark = g:ValidMarks[g:NavMarkIndex]
    
    " Jump to the mark (using ' to go to beginning of marked line)
    execute "silent! normal! '" . mark
endfunction

"------------------------------------------------------------------------------
" KEY MAPPINGS AND COMMANDS
"------------------------------------------------------------------------------

" Set next mark in rotation
nnoremap <silent> md :call SetNextMark()<CR>

" Navigate through valid marks (overrides default Vim jump list navigation)
nnoremap <silent> <C-o> :call JumpToPrevValidMark()<CR>
nnoremap <silent> <C-i> :call JumpToNextValidMark()<CR>

" Command to manually clear all marks and reset system
command! C call ClearMyMarks()
