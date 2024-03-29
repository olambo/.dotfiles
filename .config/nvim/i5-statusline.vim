fun XViKeTurbo(x)
  try
     return v:lua.ViKeTurbo(a:x)
  catch
  endtry
  return 0
endf

fun Xmo(isactive, inmode)
  let mode = mode()
  if (a:inmode == 'i' && a:isactive && (mode == 'i' || mode == 'R'))
    let turbo_ignore = XViKeTurbo("off")
    return '  I '
  elseif (a:inmode == 'v' && a:isactive && (mode == 'v' || mode == 'V' || mode == "\<C-V>")) 
    if (XViKeTurbo(''))
      return '  VR ' 
    end
    return '  V '
  elseif (a:inmode == 't' && a:isactive && (mode == 'n' && XViKeTurbo('') ))
    return '  R '
  end
  return ''
endf
highlight InsertColor guibg=green guifg=white
highlight VisualColor guibg=blue guifg=white
highlight TurboColor guibg=orange guifg=white

fun! SetupStl(nr)
  return get(extend(w:, { "is_active": (winnr() == a:nr) }), "", "")
endf
fun! ColStr()
  let column = col('.')
  if (column < 80)
    return ''
  elseif (column >=120)
    return '->120+'
  elseif (column >=100)
    return '->100+'
  elseif (column >=80)
    return '->80+'
  end
  return ''
endf
 
fun! BuildStatusLine(nr)
  let et = '%-5.3n %t%m%r%h%w %= %{&filetype} [↓%L]'
  let sep = '%{"  "}'
  return '%{SetupStl(' . a:nr . ')}' . '%#InsertColor#' . '%{Xmo(w:["is_active"], "i")}'. '%#VisualColor#' . '%{Xmo(w:["is_active"], "v")}' . '%#TurboColor#' . '%{Xmo(w:["is_active"], "t")}' . '%#CursorIM#' . sep . et . '%{ColStr()}'
endf

" winnr() - the number of the active window
set statusline=%!BuildStatusLine(winnr())
