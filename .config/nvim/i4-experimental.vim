" ok. The theory is that my right hand often comes back and rests on the wrong
" keys. Then I end up with a complete buffer mess. I tried taking all lowercase keys that might
" modify the buffer away. I've had to put some of them back

" I seem to use all these keys and feel weird without them. 
" Key s has been used for sneak and I've added substitue to the hyp-h key.
" nnoremap r <nop>
" nnoremap i <nop>
" nnoremap o <nop>
" nnoremap cw <nop>
" nnoremap dw <nop>
" nnoremap dl <nop>
" nnoremap cl <nop>

" use this to cut
" vnoremap x <nop>

" makes more sense for b to go back to previous word in visual mode 
xnoremap b ge
xnoremap B gE

" These keys may make editing non deterministic. Things go wrong and you have no idea why. 
" As such I'm moving them off lowercase and onto their hyper key equivalent.
" Theres an advantage for paste as it can then work from the same keystroke in different modes.
nnoremap u <nop>
nnoremap p <nop>
nnoremap P <nop>
nnoremap gp <nop>
nnoremap gP <nop>
nnoremap . <nop>

" try to use visual mode for more than one line
" nnoremap <expr> dd v:count == 0 ? "<esc>dd" : "<esc>:echo 'use visual keystroke {count}vd'<cr>"
nnoremap dd <nop>

" use visual J
nnoremap J <nop>
" use visual J to cut
nnoremap x <nop>

" I can probaby get away without the following keys, with the vi-ka expand/surround functionality.
" For example, ciw and diw become one less keystroke at <hyp-l>c or <hyp-l>d. 
" Why have the keys if you dont use them. It just makes random things hapening more likely.
nnoremap cc <nop>
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

" could use this
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

