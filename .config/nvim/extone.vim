" SKIM --------------------------------
let $SKIM_DEFAULT_COMMAND = "git ls-tree -r --name-only HEAD || rg --files || ag -l -g \"\" || find ."

function! Skim_files()
  call skim#run({'source': 'fd -t f "scala$|py$|conf$"', 'sink': 'e' })
endfunction

nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <Leader>fr :Files <c-r>=expand('%:h')<cr><cr>
nnoremap <silent> <Leader>fs :call Skim_files()<cr>

nnoremap <silent> <leader>bb :Buffers<cr>
