"----------------------------------------------------------------------------------------------
" Yak visual region expand and contract. Only works on one line, though it
" will perform a final expand to a paragraph before ignoring more expansion
" requests.

nnoremap <right> <Cmd>lua _G.yakInit()<Cr>
xnoremap <right> <Cmd>lua _G.yakExpand()<Cr>
xnoremap <left> <Cmd>lua _G.yakContract()<Cr>
xnoremap = <Cmd>lua _G.yakExpand1Chr()<Cr>
xnoremap - <Cmd>lua _G.yakContract1Chr()<Cr>
 
noremap <leader>k <Cmd>lua _G.getYakPattern()<cr>

lua << EOF
local function existsIn(val, tab)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

yakStack = {}
yakLine = 1
function _G.yakInit()
    yakStack = {}
    vim.cmd('normal V')
    vim.cmd('normal v')
    yakExpand()
end

function yakIsMoved(tv)
  local tv1 = getVisualSelection()
  return tv1, tv['scol'] ~= tv1['scol'] or tv['ecol'] ~= tv1['ecol']
end

function yakMoved(tv, who)
  local tv1, isMoved = yakIsMoved(tv)
  if not isMoved then return false end
  yakLine = tv1['sline']
  local yak = {}
  yak["scol"] = tv1['scol']
  yak["ecol"] = tv1['ecol']
  ccol = tv1['ccol']
  table.insert(yakStack, yak) 
  return true
end

function yakWonkyQuotes(chr, tv) 
   -- todo: is vim's wonky selection of a inner quote, a bug or feature
   vim.cmd('normal i' .. chr)
   local tv1, isMoved = yakIsMoved(tv)
   if not isMoved then return end
   local stext1 = tv1["stext"]
   local c1, c2 = string.sub(stext1, 1, 1), string.sub(stext1, string.len(stext1))
   local isInner = not (c1 == chr and c2 == chr)
   if isInner then 
     vim.cmd('normal o')
     vim.cmd('normal h')
     vim.cmd('normal o')
     vim.cmd('normal l')
   end
end

function _G.yakExpand()
  local t = {'\'', '"', '(', '[', '{'}
  local quotes = {"'", '"'}
  local tv = getVisualSelection()

  if (tv['sline'] ~= tv['eline']) then return end

  if ( tv['scol'] == tv['ecol'] ) then 
    yakStack = {}
    local yak = {}
    yak["scol"] = tv['scol']
    yak["ecol"] = tv['ecol']
    table.insert(yakStack, yak) 
    vim.cmd('normal iw')
    if (yakMoved(tv)) then
        return
    end
  end
  local txt = tv['lineText']
  local col = tv['scol'] - 1
  for i = col, 1, -1 do 
     local chr = string.sub(txt, i, i)
     if (existsIn(chr, t)) then 
         if (existsIn(chr, quotes)) then 
           yakWonkyQuotes(chr, tv)
         else
           vim.cmd('normal a' .. chr)
         end
         if yakMoved(tv, 'textobject') then break end
     end
     if (i == 1) then
        vim.cmd('normal $o^')
        if yakMoved(tv, 'short line') then break end
        vim.cmd('normal $o0', 'line')
        if yakMoved(tv, 'whole line') then return end
     end
  end
  if (col <= 1) then vim.cmd('normal ip') end
end

function _G.yakExpand1Chr()
  local tv = getVisualSelection()
  local ccol, scol = tv["ccol"], tv["scol"] 
  if ccol > scol then
    vim.cmd('normal ohol')
  else
    vim.cmd('normal hol')
  end
end

function _G.yakContract1Chr()
  local tv = getVisualSelection()
  local ccol, scol = tv["ccol"], tv["scol"] 
  if ccol > scol then
    vim.cmd('normal oloh')
  else
    vim.cmd('normal loh')
  end
end

function _G.yakContract()
  local yak = table.remove(yakStack)
  if (yak == nil) then return end
  local scol = yak['scol']
  local ecol = yak['ecol']
  local tv = getVisualSelection()
  if (tv['sline'] ~= tv['eline']) then 
      vim.cmd('normal VV')
      vim.cmd('normal v')
  end
  local ccol = tv['ccol']
  if (ccol > scol) then vim.cmd('normal o') end
  vim.fn.setpos(".", {0, yakLine, scol})
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, yakLine, ecol})
  vim.cmd('normal o')
  vim.cmd('normal o')
end

function _G.getVisualSelection()
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cline, ccol = cursor[1], cursor[2]
  local vline, vcol = vim.fn.line('v'), vim.fn.col('v')

  local sline, scol
  local eline, ecol
  if cline == vline then
    if ccol <= vcol then
      sline, scol = cline, ccol
      eline, ecol = vline, vcol
      scol = scol + 1
    else
      sline, scol = vline, vcol
      eline, ecol = cline, ccol
      ecol = ecol + 1
    end
  elseif cline < vline then
    sline, scol = cline, ccol
    eline, ecol = vline, vcol
    scol = scol + 1
  else
    sline, scol = vline, vcol
    eline, ecol = cline, ccol
    ecol = ecol + 1
  end

  --if mode == "V" or mode == "CTRL-V" or mode == "\22" then
  --  scol = 1
  --  ecol = nil
  --end

  local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, 0)
  if #lines == 0 then return end

  local startText, endText
  if #lines == 1 then
    startText = string.sub(lines[1], scol, ecol)
  else
    startText = string.sub(lines[1], scol, ecol)
    endText = string.sub(lines[#lines], 1, ecol)
  end

  local tb = {}
  tb["ccol"] = ccol + 1
  tb["sline"] = sline
  tb["eline"] = eline
  tb["scol"] = scol
  tb["ecol"] = ecol
  tb["stext"] = startText
  tb["lineText"] = lines[1]
  return tb
end

local function getInput()
  local curline = vim.fn.getline('.')
  vim.fn.inputsave()
  local pattern = vim.fn.input('Pattern;')
  vim.fn.inputrestore()
  return pattern
end

local function getOp(chr, isSearchTerm)
  if chr == '[' or chr == ']' then
    if isSearchTerm then
      return [===[\[]===], [===[\]]===]
    else 
      return '[', ']'
    end
  elseif chr == '{' or chr == '}' then
    return '{', '}'
  elseif chr == '(' or chr == ')' then
    return '(', ')'
  elseif chr == '(' or chr == ')' then
    return '(', ')'
  elseif chr == '"' then
    return '"', '"'
  elseif chr == "'" then
    return "'", "'"
  elseif chr == ';' and isSearchTerm then
    return '', ''
  end
  return '?', '?'
end

local function applySingle(chr)
  local tv = getVisualSelection()
  local txt, col = tv["stext"], tv["scol"]
  if not txt or txt == '' then return end
  local txtLen = string.len(txt)
  local xsm, xem = string.sub(txt, 1, 1), string.sub(txt, string.len(txt))
  local osm, oem = getOp(xsm, true)

  local sm, em = getOp(chr, false)
  if sm == '?' or (sm == ";" and osm == "?") then return end
  if (osm == '?' or oem == '?') and osm ~= oem then return end
  
   -- one two ("and" [then some] stuff) b
   -- one two ("and" [or some] cars) 
  local mstr = [[s/\%]] .. col .. 'c' .. osm .. [[\([^]] .. osm ..[[]*\)]] .. oem .. '/' .. sm .. [[\1]] .. em .. '/'
  if osm == '?' then
    mstr = [[s/\%]] .. col .. 'c' .. [[\(.\{]] .. txtLen .. [[}\)]]  .. '/' .. sm .. [[\1]]  .. em .. '/' 
  end
  vim.cmd('mess clear')
  print('mstr', mstr, 'txt=', txt, 'lineText=', tv["lineText"])
  vim.api.nvim_input(':' .. mstr)
end

function _G.getYakPattern()
  local pattern = getInput()
  applySingle(pattern)
end
EOF
