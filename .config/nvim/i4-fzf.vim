"All dont need a preview
let g:fzf_preview_window = []

" list functions to run. Ensure functions are defined somewhere
noremap <leader>; :call fzf#run({'source': 'cat ~/.config/nvim/bin/lkeyFunctions', 'sink': funcref("ZRunner"), 'window': { 'width': 0.9, 'height': 0.7 } })<cr> 

" list buffers, move to one
nnoremap <silent> <c-x><c-f> :Buffers<CR>
nnoremap <silent> <Leader>g :Rg<CR>

" find files of wanted types 
nnoremap <silent> gf :call ZSFiles()<cr>

nnoremap <silent> <Leader>ff :call ZGlobal()<cr>
nnoremap <silent> <Leader>fl :call ZLocal()<cr>

function! ZRunner(item)
  execute "call " . a:item . "()"
endfunction

function! ZGlobal()
  execute "FZF"
endfunction

function! ZLocal()
  execute "FZF %:h"
endfunction

function! ZSFiles()
  let rg= "rg --type-add 'sc:*.worksheet.sc' -t md -t scala --glob='!target/' --glob='!Library/' --files " . fnameescape(getcwd())
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction
