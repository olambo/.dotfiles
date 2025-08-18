" i4-fzf.vim - FZF configuration and utility functions
" 
" All dont need a preview
let g:fzf_preview_window = []

" list functions to run. Ensure functions are defined below
noremap g<leader> :call fzf#run({'source': 'cat ~/.config/nvim/bin/lkeyFunctions', 'sink': funcref("ZRunner"), 'window': { 'width': 0.6, 'height': 0.7 } })<cr> 

" list buffers - changed from <c-x><c-f> to avoid clash with clipboard copy
nnoremap <silent> <leader>b :Buffers<CR>

" find files of wanted types - updated for Python and Markdown only
nnoremap <silent> gF :call ZSFiles()<cr>

" find IN files - ripgrep search
nnoremap <silent> gf :RG<CR>

" Find files function - now searches Python and Markdown files only
function! ZSFiles()
  let rg= "rg -t py -t md --glob='!target/' --glob='!Library/' --files " . fnameescape(getcwd())
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction

" Ripgrep find in files - updated for Python and Markdown only
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --glob='!target/' --glob='!Library/' -t py -t md --column --line-number --no-heading --color=always --smart-case %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ------------------------------------------------------
" Utility functions - run via lkeyFunctions file and g<leader> menu
 
function! ZRunner(item)
  execute "call " . split(a:item)[0] . "()"
endfunction

" Compare current buffer with saved version on disk
function! BufferDiff()
    execute "w !diff % -"
endfunction

" Open current file's directory in Finder (macOS)
function! OpenFinder()
  :!exec open -a Finder %:p:h
endfunction

" Copy current file's full path to system clipboard
function! FilePath()
    let path = expand("%:p")
    let @+ = path  " Yank to system clipboard
    echo path
endfunction

" Open FZF file finder in any directory
function! FindFileAny()
  execute "FZF"
endfunction

" Open FZF file finder in current file's directory
function! FindFileLocal()
  execute "FZF %:h"
endfunction
