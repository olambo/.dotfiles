" FZF --------------------------------

" list buffers, move to one
nnoremap <silent> <Leader>bb :Buffers<CR>
" find files of wanted types 
nnoremap <silent> <Leader>ff :call FZF_files()<cr>
" find any type of file
nnoremap <silent> <leader>fa :FZF<cr>
" find files local to current directory
nnoremap <silent> <Leader>fl :FZF <c-r>=expand('%:h')<cr><cr>

function! FZF_files()
  let rg= "rg -t go -t md -t scala --iglob='!Library/*' --files " . getcwd()
  call fzf#run({'source': rg, 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.7 } })
endfunction
