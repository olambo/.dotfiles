fun Xmo(isactive, inmode)
  let mode = mode()
  if (a:inmode == 'i' && a:isactive && mode == 'i')
    return '  I '
  elseif (a:inmode == 'v' && a:isactive && (mode == 'v' || mode == 'V' || mode == "\<C-V>")) 
    return '  V '
  end
  return ''
endf
highlight InsertColor guibg=green guifg=white
highlight VisualColor guibg=blue guifg=white

fun! SetupStl(nr)
  return get(extend(w:, { "is_active": (winnr() == a:nr) }), "", "")
endf

fun! BuildStatusLine(nr)
  let et = '%-5.3n %t%m%r%h%w %= %Y [LEN=%L]'
  let sep = '%{"  "}'
  return '%{SetupStl(' . a:nr . ')}' . '%#InsertColor#' . '%{Xmo(w:["is_active"], "i")}'. '%#VisualColor#' . '%{Xmo(w:["is_active"], "v")}' . '%#CursorIM#' . sep . et
endf

" winnr() - the number of the active window
set statusline=%!BuildStatusLine(winnr())
