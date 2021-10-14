"----------------------------------------------------------------------------------------------
" Vika visual region expand and contract. Works up to first expand to multiple lines.
" Also Vika surround - add or remove surrounding Quotes, Parenthesis.
" Also Vika regex. Set up a regex search/replace in a simple manner.

nnoremap <right> <Cmd>lua _G.vikaInit()<Cr>
nnoremap <expr> g/ ':s/'.expand('<cword>').'//g<Left><Left>'

xnoremap g/ <Cmd>lua _G.vikaPatternTxt()<cr>
xnoremap <leader>e <Cmd>lua _G.vikaPattern()<cr>

xnoremap <right> <Cmd>lua _G.vikaExpand()<Cr>
xnoremap <left> <Cmd>lua _G.vikaContract()<Cr>
xnoremap = <Cmd>lua _G.vikaExpand1Chr()<Cr>
xnoremap - <Cmd>lua _G.vikaContract1Chr()<Cr>

xnoremap ii <Cmd>lua _G.vikaInsert()<cr>
xnoremap aa <Cmd>lua _G.vikaAppend()<cr>

xnoremap c <Cmd>lua _G.vikaChange()<cr>
