function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?''.l:branchname.' ':''
endfunction

function! s:strip(input_string)
     return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

if !exists('g:statusline_tealeaves')
  let g:statusline_tealeaves = "src/main/scala:sms, src/main/java:smj, src/main/resources:smr"
endif

function! StatuslineFilename()
  let fullpath = expand('%:p')
  let path = substitute(fullpath, $HOME, "~", "")

  let shorteningArr = split(g:statusline_tealeaves, ",")
  for shortening in shorteningArr
    let textShort = split(shortening, ":")
    let path = substitute(path, s:strip(textShort[0]), s:strip(textShort[1]), "")
  endfor
  return path
endfunction

function! StatuslineModified()
  return &ft =~ 'help' ? '' : &modified ? '++' : &modifiable ? '' : '-'
endfunction

set statusline=
set statusline+=%#CursorIM#     " colour
set statusline+=\%3l\           " line number 
set statusline+=%#CursorLine#   " colour
set statusline+=%R              " readonly flag
set statusline+=%M              " modified [+] flag
" set statusline+=%{StatuslineGit()}
" set statusline+=%{StatuslineFilename()}
set statusline+=\ 
set statusline+=%t              " filename
set statusline+=%=              " right align
set statusline+=\ %Y\            " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %-2c\         " column number
set statusline+=\%3p%%\         " percentage
