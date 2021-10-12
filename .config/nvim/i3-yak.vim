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
    -- just in case it's called from visual mode to reinitialize
    vim.cmd('normal <c-v>')
    vim.cmd('normal v')
    local modeInfo = vim.api.nvim_get_mode()
    local mode = modeInfo.mode
    if mode == 'v' then yakExpand()
    else print("yakInit: Not in correct mode:", mode)
    end
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

function _G.getVisualSelection(setCur)
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode

  local cursor = vim.api.nvim_win_get_cursor(0)
  -- todo: does this have to be global to get the cursor info
  local cline, ccol = cursor[1], cursor[2] + 1
  local vline, vcol = vim.fn.line('v'), vim.fn.col('v')

  local sline, scol = vline, vcol
  local eline, ecol = cline, ccol
  if ccol <= vcol or cline < vline  then
      sline, scol = cline, ccol
      eline, ecol = vline, vcol
  end
  if (setCur == 'start' and ccol > vcol) then
      vim.api.nvim_input('o') 
  elseif (setCur == 'end' and ccol < vcol) then 
      vim.api.nvim_input('o') 
  end

  local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, 0)
  local startText = string.sub(lines[1], scol, ecol)
  -- if #lines > 1 then endText = string.sub(lines[#lines], 1, ecol) end

  local tv = {}
  tv["ccol"] = ccol
  tv["sline"] = sline
  tv["eline"] = eline
  tv["scol"] = scol
  tv["ecol"] = ecol
  tv["stext"] = startText
  tv["lineText"] = lines[1]
  return tv
end

local function getInput()
  local curline = vim.fn.getline('.')
  vim.fn.inputsave()
  local pattern = vim.fn.input('Yak;')
  vim.fn.inputrestore()
  return pattern
end

local function squareBracketOpen()  
    return [===[\[]===]
end
local function squareBracketClose ()
    return [===[\]]===]
end

local function getOp(chr, isSearchTerm)
  if chr == '[' or chr == ']' then
    if isSearchTerm then
      return squareBracketOpen(), squareBracketClose()
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
  elseif chr == ';' then --todo: and isSearchTerm then
    return '', ''
  elseif chr == '.' then --todo: and isSearchTerm then
    return '.', '.'
  end
  return '?', '?'
end

local function oneTxtChange(chr)
  local tv = getVisualSelection()
  local txt, col = tv["stext"], tv["scol"]
  if not txt or txt == '' then return end
  local txtLen = string.len(txt)
  local xsm, xtxt, xem = string.sub(txt, 1, 1), txt, string.sub(txt, string.len(txt))
  local osm, oem = getOp(xsm, true)
  local sm, em = getOp(chr, false)

  if sm == '?' or (sm == ";" and osm == "?") then return end
  if (osm == '?' or oem == '?') and osm ~= oem then return end
  if osm ~= '?' then xtxt = string.sub(txt, 2, string.len(txt)-1) end
  
  local command = 'c' .. sm .. xtxt .. em
  --vim.cmd('mess clear')
  --print('oneTxtChange: mstr', mstr, 'txt=', txt, 'xtxt=', xtxt, 'sm=', sm, 'command=', command)
  vim.api.nvim_input(command)
  vim.api.nvim_input('<c-[>')
end

function patternChange(chr, patternType)
  local tv = getVisualSelection()
  local txt, col = tv["stext"], tv["scol"]
  if not txt or txt == '' then return end
  local txtLen = string.len(txt)
  local xsm, xtxt, xem = string.sub(txt, 1, 1), txt, string.sub(txt, string.len(txt))
  local osm, oem = getOp(xsm, true)

  local sm, em = getOp(chr, false)
  if sm == '?' or (sm == ";" and osm == "?") then return end
  if (osm == '?' or oem == '?') and osm ~= oem then return end
  if osm ~= '?' then xtxt = string.sub(txt, 2, string.len(txt)-1) end
  if chr == '.' then
    if osm == '?' or oem == '?' then
      osm, oem = '', ''
    end
    sm, em = osm, oem 
  end
  
  local mstr
  if patternType == 't' then
    xtxt = string.gsub(xtxt, "%[", squareBracketOpen())
    xtxt = string.gsub(xtxt, "%]", squareBracketClose())
    mstr = [[s/]] .. osm .. [[\(]] .. xtxt.. [[\)]] .. oem  .. '/' .. sm .. [[\1]]  .. em .. '/gIc' 
  elseif osm == '?' then
    mstr = [[s/\%]] .. col .. 'c' .. [[\(.\{]] .. txtLen .. [[}\)]]  .. '/' .. sm .. [[\1]]  .. em .. '/' 
  else 
    mstr = [[s/\%]] .. col .. 'c' .. osm .. [[\([^]] .. osm ..[[]*\)]] .. oem .. '/' .. sm .. [[\1]] .. em .. '/'
  end
  --vim.cmd('mess clear')
  --print('PatternChange: mstr', mstr, 'txt=', txt, 'osm=', osm, 'lineText=', tv["lineText"])
  vim.api.nvim_input(':' .. mstr)
end

function _G.getYakPatternTxt()
  patternChange('.', 't')
  vim.api.nvim_input('<left><left><left><left>')
end

function _G.getYakPattern()
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local pattern = getInput()
  local chr1 = string.sub(pattern, 1, 1)
  if mode ~= 'v' and chr1 ~= 't' then 
    patternChange(pattern, chr1) -- todo: logic here
  elseif chr1 == 'p' or chr1 == 't' then
    patternChange(string.sub(pattern, 2), chr1)
  else
    oneTxtChange(pattern)
  end
end

function _G.yakInsert()
  _G.getVisualSelection('start')
  vim.api.nvim_input('<c-[>i')
end

function _G.yakAppend()
    _G.getVisualSelection('end')
  vim.api.nvim_input('<c-[>a')
end
EOF
