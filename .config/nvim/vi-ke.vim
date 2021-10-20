" Instead of a count indicating up or down a number of lines, it represents a partialLineNo
" You supply the last two digits or last digit.
 
" If a partialLineNo is supplied, go to the next matching line. Otherwise scroll up or down by 10 lines.
" Mapping <down> and <up> makes sense on my keyboard setup. Map the keys that make sense on yours.
nnoremap <down> <cmd>lua _G.vikeDown()<CR>
nnoremap <up> <cmd>lua _G.vikeUp()<CR>
xnoremap <down> <cmd>lua _G.vikeDown()<CR>
xnoremap <up> <cmd>lua _G.vikeUp()<CR>

" Need to know when 0 is pressed. It still goes to the start of the line.
nnoremap 0 <cmd>lua _G.vike0()<CR>
xnoremap 0 <cmd>lua _G.vike0()<CR>

" Optional! j and k keys. If a partialLineNo is supplied, go to the line. Otherwise works like original j and k.
nnoremap j <cmd>lua _G.vikeJ()<CR>
nnoremap k <cmd>lua _G.vikeK()<CR>
xnoremap j <cmd>lua _G.vikeJ()<CR>
xnoremap k <cmd>lua _G.vikeK()<CR>

" Optional! vi-ke for vim-sneak. Sneak needs to be added to your dependencies - https://github.com/justinmk/vim-sneak
" Using the above keys will prime Sneak, so the next ; or , will activate it.
nnoremap ; <cmd>lua _G.vike0Sneak()<CRk
nnoremap , <cmd>lua _G.vike0SneakUp()<CR>
xnoremap ; <cmd>lua _G.vike0Sneak()<CR>
xnoremap , <cmd>lua _G.vike0SneakUp()<CR>
" Give Sneak a mapping so it doesn't steal the 's' and 'S' keys.
map <leader>; <Plug>Sneak_s
nmap <leader>, <Plug>Sneak_S
" Case insensitive
let g:sneak#use_ic_scs = 1

" Optional! Typing v will go into visual mode. Typing vv from normal mode will activate line mode - mirroring cc, dd
" {partialLineNo}v will activate visual line mode and move to the line inidicated.
" visual mode <-> visual line mode (toggle). 
nnoremap v <cmd>lua _G.vikeV()<CR>
xnoremap v <cmd>lua _G.vikeV()<CR>
" {partialLineNo} visual block mode. I don't use <c-v>, but map it if you do.
nnoremap <leader>v <cmd>lua _G.vikVB()<CR>
xnoremap <leader>v <cmd>lua _G.vikeVB()<CR>
" Visual to end of line - mirroring C, D
nnoremap V v$h
xnoremap V $h
