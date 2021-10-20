" Go to the line indicated by the last digit, or last two digits of any supplied count/partialLineNo
nnoremap <down> <cmd>lua _G.vikeDown()<CR>
nnoremap <up> <cmd>lua _G.vikeUp()<CR>
xnoremap <down> <cmd>lua _G.vikeDown()<CR>
xnoremap <up> <cmd>lua _G.vikeUp()<CR>

" need to know when 0 is pressed.
nnoremap 0 <cmd>lua _G.vike0()<CR>
xnoremap 0 <cmd>lua _G.vike0()<CR>

" Optional! j and k keys.
nnoremap j <cmd>lua _G.vikeJ()<CR>
nnoremap k <cmd>lua _G.vikeK()<CR>
xnoremap j <cmd>lua _G.vikeJ()<CR>
xnoremap k <cmd>lua _G.vikeK()<CR>

" Optional! vi-ke for vim-sneak.
" Sneak needs to be added to your dependencies - https://github.com/justinmk/vim-sneak
nnoremap ; <cmd>lua _G.vike0Sneak()<CRk
nnoremap , <cmd>lua _G.vike0SneakUp()<CR>
xnoremap ; <cmd>lua _G.vike0Sneak()<CR>
xnoremap , <cmd>lua _G.vike0SneakUp()<CR>
" Give Sneak a mapping so it doesn't steal the 's' and 'S' keys. Typing the
" digit 0 will prime Sneak, so the next ; or , will activate it.
map <leader>; <Plug>Sneak_s
nmap <leader>, <Plug>Sneak_S
" Case insensitive
let g:sneak#use_ic_scs = 1

" Optional! Typing v will go into visual mode. 
" {partialLineNo}v will go into visual line mode and move to the line inidicated by partialLineNo
" visual mode <-> visual line mode (toggle). Typing vv from normal mode will select a line - mirroring cc, dd
nnoremap v <cmd>lua _G.vikeV()<CR>
xnoremap v <cmd>lua _G.vikeV()<CR>
" {partialLineNo} visual block mode.
nnoremap <leader>v <cmd>lua _G.vikeVB()<CR>
xnoremap <leader>v <cmd>lua _G.vikeVB()<CR>
" Visual to end of line - like C, D, Y
nnoremap V v$h
xnoremap V $h
