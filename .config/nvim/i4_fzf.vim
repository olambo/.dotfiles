" dont need a preview
let g:fzf_preview_window = []
" list functions to run 
noremap <leader>l :call fzf#run({'source': 'cat ~/.config/nvim/bin/lkeyFunctions', 'sink': 'call', 'window': { 'width': 0.9, 'height': 0.7 } })<cr> 
" list buffers, move to one
nnoremap <silent> <Leader>b :Buffers<CR>
" find files of wanted types 
nnoremap <silent> <Leader>z :call FzfFiles()<cr>

function! ZAll()
  execute "FZF"
endfunction

function! ZLocal()
  execute "FZF %:h"
endfunction

function! FzfFiles()
  let rg= "rg -t go -t md -t scala --iglob='!Library/*' --files " . getcwd()
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction
