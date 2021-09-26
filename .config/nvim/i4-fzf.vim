"All dont need a preview
let g:fzf_preview_window = []
" list functions to run 
noremap <leader>l :call fzf#run({'source': 'cat ~/.config/nvim/bin/lkeyFunctions', 'sink': 'call', 'window': { 'width': 0.9, 'height': 0.7 } })<cr> 
" list buffers, move to one
" nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <c-x><c-f> :Buffers<CR>
nnoremap <silent> <Leader>g :Rg<CR>

" find files of wanted types 
nnoremap <silent> gf :call ZSFiles()<cr>

nnoremap <silent> <Leader>ff :call ZGlobal()<cr>
nnoremap <silent> <Leader>fl :call ZLocal()<cr>

function! ZGlobal()
  execute "FZF"
endfunction

function! ZLocal()
  execute "FZF %:h"
endfunction

function! ZSFiles()
  let rg= "rg --type-add 'sc:*.worksheet.sc' -g '!target/' -t sc -t md -t scala --iglob='!Library/*' --files " . getcwd()
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction
