" Rotating mark system using top row: QWERTYUIOP
let g:MarkQueue = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']
let g:CurrentMarkIndex = 0

function! SetNextMark()
    " Find next empty mark slot, or recycle from beginning if all full
    let start_index = g:CurrentMarkIndex
    let found_empty = 0
    
    " Look for first empty slot starting from current position
    for i in range(len(g:MarkQueue))
        let check_index = (g:CurrentMarkIndex + i) % len(g:MarkQueue)
        let mark = g:MarkQueue[check_index]
        let mark_pos = getpos("'" . mark)
        
        " If mark is empty (not set)
        if mark_pos[1] == 0 && mark_pos[2] == 0
            let g:CurrentMarkIndex = check_index
            let found_empty = 1
            break
        endif
    endfor
    
    " If no empty slots found, start recycling from beginning
    if !found_empty
        let g:CurrentMarkIndex = 0
    endif
    
    let mark = g:MarkQueue[g:CurrentMarkIndex]
    execute "silent! normal! m" . mark
    
    " Move to next position for next call
    let g:CurrentMarkIndex = (g:CurrentMarkIndex + 1) % len(g:MarkQueue)
endfunction

function! ShowCurrentMarks()
    echo "Current marks (Q-W-E-R-T-Y-U-I-O-P):"
    for i in range(len(g:MarkQueue))
        let mark = g:MarkQueue[i]
        let mark_pos = getpos("'" . mark)
        if mark_pos[1] != 0 || mark_pos[2] != 0
            let filename = fnamemodify(bufname(mark_pos[0]), ':t')
            if filename == ''
                let filename = '[current buffer]'
            endif
            let indicator = (i == g:CurrentMarkIndex) ? " <- next" : ""
            echo "  " . mark . ": line " . mark_pos[1] . " in " . filename . indicator
        else
            let indicator = (i == g:CurrentMarkIndex) ? " <- next" : ""
            echo "  " . mark . ": [empty]" . indicator
        endif
    endfor
endfunction

function! GetValidMarks()
    let valid_marks = []
    for mark in g:MarkQueue
        let mark_pos = getpos("'" . mark)
        if mark_pos[1] != 0 || mark_pos[2] != 0
            call add(valid_marks, mark)
        endif
    endfor
    return valid_marks
endfunction

let g:NavMarkIndex = 0

function! JumpToNextValidMark()
    let valid_marks = GetValidMarks()
    if len(valid_marks) == 0
        return
    endif
    
    let g:NavMarkIndex = (g:NavMarkIndex + 1) % len(valid_marks)
    let mark = valid_marks[g:NavMarkIndex]
    execute "silent! normal! '" . mark
endfunction

function! JumpToPrevValidMark()
    let valid_marks = GetValidMarks()
    if len(valid_marks) == 0
        return
    endif
    
    let g:NavMarkIndex = (g:NavMarkIndex - 1 + len(valid_marks)) % len(valid_marks)
    let mark = valid_marks[g:NavMarkIndex]
    execute "silent! normal! '" . mark
endfunction

" Main mapping - md sets the next mark in rotation
nnoremap md :call SetNextMark()<CR>
" Navigation through valid marks (Ctrl+o goes backwards, Ctrl+i goes forwards)
nnoremap <C-o> :call JumpToPrevValidMark()<CR>
nnoremap <C-i> :call JumpToNextValidMark()<CR>
" Show current mark status
command! Marks call ShowCurrentMarks()
