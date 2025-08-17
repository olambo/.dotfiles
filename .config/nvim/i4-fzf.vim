"All dont need a preview
let g:fzf_preview_window = []

" list functions to run. Ensure functions are defined below
noremap g<leader> :call fzf#run({'source': 'cat ~/.config/nvim/bin/lkeyFunctions', 'sink': funcref("ZRunner"), 'window': { 'width': 0.6, 'height': 0.7 } })<cr> 
" list buffers, mapped from <hyp-f> via karabiner elements
nnoremap <silent> <c-x><c-f> :Buffers<CR>
" find files of wanted types 
nnoremap <silent> gF :call ZSFiles()<cr>
" find IN files 
nnoremap <silent> gf :RG<CR>

function! ZSFiles()
  let rg= "rg --type-add 'sc:*.worksheet.sc' -t sc -t md -t scala --glob='!target/' --glob='!Library/' --files " . fnameescape(getcwd())
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction

" Ripgrep find in files
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --type-add 'sc:*.worksheet.sc' --glob='!target/' --glob='!Library/' -t sc -t md -t scala --column --line-number --no-heading --color=always --smart-case %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ------------------------------------------------------
"  run via lkeyFunctions file
 
function! ZRunner(item)
  execute "call " . split(a:item)[0] . "()"
endfunction

function! BufferDiff()
    execute "w !diff % -"
endfunction

function! BufferWipeout()
    execute "silent! bufdo! bw"
endfunction

function! OpenFinder()
  :!exec open -a Finder %:p:h
endfunction

function! FilePath()
    let path = expand("%:p")
    let @+ = path  " Yank to system clipboard
    echo path
endfunction

function! CdHere()
    execute "cd %:p:h"
endfunction

function! CdOrig()
    execute "e `pwd`"
endfunction

function! MetalsRunDoctor()
   execute "MetalsRunDoctor"
endfunction

function! OrganizeImports()
   execute "MetalsOrganizeImports"
endfunction

function! FindFileAny()
  execute "FZF"
endfunction

function! FindFileLocal()
  execute "FZF %:h"
endfunction

" when running fzf#run. Output doesnt appear!. So echo via a timer
function! ToggleMouse()
  if &mouse != ''
    set nonumber 
    set norelativenumber
    set mouse=
    let &titlestring = "MOUSE OFF " . expand("[$USER]") . expand('%:~')
    set title
    let msgToEcho = "Mouse is off"
  else
    set mouse=nv
    let &titlestring = expand("[$USER]") . expand('%:~')
    set title
    let msgToEcho = "Mouse enabled"
  endif
    call timer_start(1, function('TimerEcho', [msgToEcho]))
endfunction

function! TimerEcho(msg, timer)
    if len(a:msg) > 0
        echo a:msg
    endif
endfunction
