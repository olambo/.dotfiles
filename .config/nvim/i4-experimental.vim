"function! SuppressAllStartingWith(c1)
"  let c2 = nr2char(getchar())
"  if maparg(a:c1.c2, 'n') != ''
"    echo 'maparg' a:c1.c2
"    return a:c1.c2
"  else
"    return '\<Nop>'
"  endif
"endfunction
"function! Suppress(c1)
"  "call SuppressAllStartingWith('d')
"endfunction
"nnoremap <expr> q Suppress('d')

" makes more sense for b to go back to previous word in visual mode 
xnoremap b ge
xnoremap B gE

nnoremap dd <nop>
" nnoremap dw <nop>
nnoremap dt <nop>
nnoremap df <nop>
nnoremap di" <nop>
nnoremap da" <nop>
nnoremap di' <nop>
nnoremap da' <nop>
nnoremap diw <nop>
nnoremap daw <nop>
nnoremap ds <nop>
nnoremap das <nop>
nnoremap dip <nop>
nnoremap dap <nop>
nnoremap di] <nop>
nnoremap di[ <nop>
nnoremap da] <nop>
nnoremap da[ <nop>
nnoremap di) <nop>
nnoremap di( <nop>
nnoremap da) <nop>
nnoremap da( <nop>
nnoremap di( <nop>
nnoremap da) <nop>
nnoremap da( <nop>
nnoremap dib <nop>
nnoremap dib <nop>

" nnoremap x <nop>
" nnoremap r <nop>
nnoremap u <nop>
" nnoremap i <nop>
" nnoremap o <nop>
nnoremap p <nop>
nnoremap gp <nop>
nnoremap gP <nop>
nnoremap . <nop>
 
nnoremap cc <nop>
" nnoremap cw <nop>
nnoremap ct <nop>
nnoremap cf <nop>
nnoremap ci" <nop>
nnoremap ca" <nop>
nnoremap ci' <nop>
nnoremap ca' <nop>
nnoremap ciw <nop>
nnoremap caw <nop>
nnoremap cs <nop>
nnoremap cas <nop>
nnoremap cip <nop>
nnoremap cap <nop>
nnoremap ci] <nop>
nnoremap ci[ <nop>
nnoremap ca] <nop>
nnoremap ca[ <nop>
nnoremap ci) <nop>
nnoremap ci( <nop>
nnoremap ca) <nop>
nnoremap ca( <nop>
nnoremap ci( <nop>
nnoremap ca) <nop>
nnoremap ca( <nop>
nnoremap cib <nop>
nnoremap cib <nop>
