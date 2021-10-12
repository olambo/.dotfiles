"----------------------------------------------------------------------------------------------
" Yak visual region expand and contract. Works up to first expand to multiple lines.
" Also Yak surround - add or remove surrounding Quotes, Parenthesis.
" Also Yak regex. Set up a regex search/replace in a simple manner.

nnoremap <right> <Cmd>lua _G.yakInit()<Cr>
nnoremap <expr> g/ ':s/'.expand('<cword>').'//g<Left><Left>'

xnoremap g/ <Cmd>lua _G.getYakPatternTxt()<cr>
xnoremap <leader>e <Cmd>lua _G.getYakPattern()<cr>

xnoremap <right> <Cmd>lua _G.yakExpand()<Cr>
xnoremap <left> <Cmd>lua _G.yakContract()<Cr>
xnoremap = <Cmd>lua _G.yakExpand1Chr()<Cr>
xnoremap - <Cmd>lua _G.yakContract1Chr()<Cr>

xnoremap ii <Cmd>lua _G.yakInsert()<cr>
xnoremap aa <Cmd>lua _G.yakAppend()<cr>

nnoremap <c-x><c-q> c
xnoremap c <Cmd>lua _G.change()<cr>

