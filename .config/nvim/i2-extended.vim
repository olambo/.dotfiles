"==============================================================================
" ROTATING MARK SYSTEM
" Note: <C-o>/<C-i> override default jumplist navigation
" Personal preference - I prefer mark navigation over jumplist
"==============================================================================
let g:MarkQueue = ['Q','W','E','R','T','Y','U','I','O','P']
let g:CurrentMarkIndex = 0
let g:ValidMarks = []
let g:NavMarkIndex = 0
let g:MarkData = {}

function! ClearMyMarks()
    delmarks QWERTYUIOP
    let g:CurrentMarkIndex = 0
    let g:ValidMarks = []
    let g:NavMarkIndex = 0
    let g:MarkData = {}
endfunction

function! SetNextMark()
    if len(g:ValidMarks) == 0
        call ClearMyMarks()
    endif
    let mark = g:MarkQueue[g:CurrentMarkIndex]
    
    " VSCode restriction: only allow marks in same file
    if exists('g:vscode') && len(g:ValidMarks) > 0
        let current_file = expand('%:p')
        let first_mark_file = g:MarkData[g:ValidMarks[0]].file
        if current_file !=# first_mark_file
            return
        endif
    endif
    
    let existing_index = index(g:ValidMarks, mark)
    let is_reusing_mark = existing_index != -1
    
    execute "silent! normal! m" . mark
    
    let g:MarkData[mark] = {
    \ 'file': expand('%:p'),
    \ 'lnum': line('.'),
    \ 'col': col('.')
    \ }
    
    if !is_reusing_mark
        call add(g:ValidMarks, mark)
        let g:NavMarkIndex = len(g:ValidMarks) - 1
    else
        let g:NavMarkIndex = existing_index
    endif
    
    let g:CurrentMarkIndex = (g:CurrentMarkIndex + 1) % len(g:MarkQueue)
endfunction

function! JumpToMark(mark)
    if !has_key(g:MarkData, a:mark)
        return
    endif
    let data = g:MarkData[a:mark]
    
    if expand('%:p') !=# data.file
        execute 'silent! edit ' . fnameescape(data.file)
    endif
    
    execute "silent! normal! `" . a:mark
endfunction

function! JumpToNextValidMark()
    if len(g:ValidMarks) == 0 | return | endif
    let g:NavMarkIndex = (g:NavMarkIndex + 1) % len(g:ValidMarks)
    call JumpToMark(g:ValidMarks[g:NavMarkIndex])
endfunction

function! JumpToPrevValidMark()
    if len(g:ValidMarks) == 0 | return | endif
    let g:NavMarkIndex = (g:NavMarkIndex - 1 + len(g:ValidMarks)) % len(g:ValidMarks)
    call JumpToMark(g:ValidMarks[g:NavMarkIndex])
endfunction

"------------------------------------------------------------------------------
" MAPPINGS AND COMMANDS
"------------------------------------------------------------------------------
nnoremap <silent> mm :call SetNextMark()<CR>
nnoremap <silent> <C-o> :call JumpToPrevValidMark()<CR>
nnoremap <silent> <C-i> :call JumpToNextValidMark()<CR>

command! C call ClearMyMarks()
command! S echo 'Valid marks: ' . string(g:ValidMarks) . ' | NextWrite: ' . g:MarkQueue[g:CurrentMarkIndex] . ' | Current: ' . (len(g:ValidMarks) > 0 ? g:ValidMarks[g:NavMarkIndex] : 'none')
