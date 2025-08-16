fun Xmo(isactive, inmode)
  let mode = mode()
  if (a:inmode == 'i' && a:isactive && (mode == 'i' || mode == 'R'))
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

fun! ColStr()
  let column = col('.')
  if (column >= 120)
    return '->120+'
  elseif (column >= 100)
    return '->100+'
  elseif (column >= 80)
    return '->80+'
  end
  return ''
endf

fun! BuildStatusLine(nr)
  let setup = '%{SetupStl(' . a:nr . ')}'
  let insert_mode = '%#InsertColor#%{Xmo(w:["is_active"], "i")}'
  let visual_mode = '%#VisualColor#%{Xmo(w:["is_active"], "v")}'
  let separator = '%#CursorIM#%{"  "}'
  let info = '%-5.3n %t%m%r%h%w %= [↓%l/%L] %{ColStr()} %{&filetype}'
  
  return setup . insert_mode . visual_mode . separator . info
endf

set statusline=%!BuildStatusLine(winnr())
