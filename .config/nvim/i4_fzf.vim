" FZF --------------------------------
let $FZF_DEFAULT_COMMAND = "git ls-tree -r --name-only HEAD || rg --files || ag -l -g \"\" || find ."

function! FZF_files()
  call fzf#run({'source': 'fd -t f "scala$|py$|conf$"', 'sink': 'e' })
endfunction

nnoremap <silent> <leader>ff :FZF<cr>
nnoremap <silent> <Leader>fr :FZF <c-r>=expand('%:h')<cr><cr>
nnoremap <silent> <Leader>fs :call FZF_files()<cr>

