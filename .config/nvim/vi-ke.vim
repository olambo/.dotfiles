" Go to the line indicated by the last digit, or last two digits.
" I'm using the j and k keys. It's optional, but as long as you can accept a provided
" number represents an indicator of a row, it's fine.
"
nnoremap 0 <cmd>lua _G.vike0()<CR>
nnoremap k <cmd>lua _G.vikeK()<CR>
nnoremap j <cmd>lua _G.vikeJ()<CR>
nnoremap <up> <cmd>lua _G.vikeUp()<CR>
nnoremap <down> <cmd>lua _G.vikeDown()<CR>

xnoremap 0 <cmd>lua _G.vike0()<CR>
xnoremap k <cmd>lua _G.vikeK()<CR>
xnoremap j <cmd>lua _G.vikeJ()<CR>
xnoremap <up> <cmd>lua _G.vikeUp()<CR>
xnoremap <down> <cmd>lua _G.vikeDown()<CR>

" turn off jump mode
nnoremap l <cmd>lua _G.vikeL()<CR>
xnoremap l <cmd>lua _G.vikeL()<CR>

" Using vi-ke for vim-sneak. It's optional!
" It needs to be added to your dependencies - https://github.com/justinmk/vim-sneak
" Give Sneak a mapping so it doesn't steal the 's' and 'S' keys. Typing the
" digit 0 will prime Sneak, so the next ; or , will activate it.
map <leader>; <Plug>Sneak_s
nmap <leader>, <Plug>Sneak_S

" Case insensitive
let g:sneak#use_ic_scs = 1

nnoremap ; <cmd>lua _G.vike0Sneak()<CR>
nnoremap , <cmd>lua _G.vike0SneakUp()<CR>
xnoremap ; <cmd>lua _G.vike0Sneak()<CR>
xnoremap , <cmd>lua _G.vike0SneakUp()<CR>


" Typing v will go into visual mode. 
" {partLinenr}v will go into visual Line mode and move to the line inidicated by partialLine
nnoremap v <cmd>lua _G.vikeV()<CR>
" Typing vv from normal mode will select a line - like cc, dd, yy
" visual mode <-> visual line mode (toggle)
xnoremap v <cmd>lua _G.vikeV()<CR>

" visual mode <-> visual block mode (toggle)
xnoremap <expr> <leader>v mode() ==# "\<c-v>" ? "V" : "\<c-v>"
" visual block mode - select extra line to start with (block mode doesnt make sense with just one line)
nnoremap <leader>v <c-v>j

" Visual to end of line - like C, D, Y
nnoremap V v$h
xnoremap V $h

