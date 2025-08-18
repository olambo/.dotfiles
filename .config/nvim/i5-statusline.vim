" i5-statusline.vim: Custom statusline configuration for Vim/Neovim
" Displays buffer info, mode, read-only status, undo position, and more

" Global dictionary to store initial undo numbers for each buffer
let g:initial_changenr = {}

" Autocommand group to capture initial undo number when a file is read
augroup StatusLineUndo
  autocmd!
  autocmd BufReadPost * let g:initial_changenr[bufnr('%')] = changenr()
augroup END

" Returns formatted string for undo status: [u initial cur:current]
fun! UndoStr()
  let current_nr = changenr()                        " Current change number
  let initial_nr = get(g:initial_changenr, bufnr('%'), 0) " Initial change number for buffer
  return printf('[u %d cur:%d]', initial_nr, current_nr)
endf

" Displays mode indicator (I for insert, V for visual) for active window
fun Xmo(isactive, inmode)
  let mode = mode()
  if (a:inmode == 'i' && a:isactive && (mode == 'i' || mode == 'R'))
    return '  I '                                    " Show 'I' for insert/replace mode
  elseif (a:inmode == 'v' && a:isactive && (mode == 'v' || mode == 'V' || mode == "\<C-V>")) 
    return '  V '                                    " Show 'V' for visual modes
  end
  return ''                                          " Empty for other modes
endf

" Define highlight groups for insert and visual mode indicators
highlight InsertColor guibg=green guifg=white
highlight VisualColor guibg=blue guifg=white

" Sets up window-specific statusline data (active/inactive window check)
fun! SetupStl(nr)
  return get(extend(w:, { "is_active": (winnr() == a:nr) }), "", "")
endf

" Warns about long lines based on cursor column position
fun! ColStr()
  let column = col('.')
  if (column >= 120)
    return '->120+'                                  " Warn for columns >= 120
  elseif (column >= 100)
    return '->100+'                                  " Warn for columns >= 100
  elseif (column >= 80)
    return '->80+'                                   " Warn for columns >= 80
  end
  return ''                                          " No warning for shorter lines
endf

" Builds the statusline with mode, buffer info, read-only, undo, and more
fun! BuildStatusLine(nr)
  let setup = '%{SetupStl(' . a:nr . ')}'           " Window setup
  let insert_mode = '%#InsertColor#%{Xmo(w:["is_active"], "i")}' " Insert mode indicator
  let visual_mode = '%#VisualColor#%{Xmo(w:["is_active"], "v")}' " Visual mode indicator
  let separator = '%#CursorIM#%{"  "}'               " Separator for readability
  let info = '%-5.3n %t%m%r%h%w %{&modifiable ? "" : "[RO]"} %{UndoStr()} %= [↓%l/%L] %{ColStr()} %{&filetype}'
  " Buffer number, file name, modified/readonly/help/preview flags, [RO] for nomodifiable,
  " undo status, line number/total, column warning, filetype
  return setup . insert_mode . visual_mode . separator . info
endf

" Apply the custom statusline to all windows
set statusline=%!BuildStatusLine(winnr())
