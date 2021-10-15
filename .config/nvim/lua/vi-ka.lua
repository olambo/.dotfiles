vikaStack = {}
vikaLine = 1
vikaInd = 0
vikaOnKeyword = false
vikaWord = ''

local function existsIn(val, tab)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local function isKeyword()
  vikaWord = vim.fn.expand("<cword>")
  vikaInd = vim.fn.strridx(vim.fn.getline('.'), vim.fn.expand("<cword>"), vim.fn.col('.') - 1)
  vikaOnKeyword = (vikaInd >= 0 and (vikaInd + vim.fn.strlen(vim.fn.expand("<cword>"))) >= (vim.fn.col('.') - 1))
end

function _G.vikaInit()
  vikaStack = {}
  isKeyword()
  -- just in case it's called from visual mode to reinitialize
  vim.cmd('normal <c-v>')
  vim.cmd('normal v')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  if mode == 'v' then vikaExpand()
  else print("vikaInit: Not in correct mode:", mode)
  end
  --print('vikaWord', vikaWord, 'vikaInd:', vikaInd, "vikaOnKeyword:", vikaOnKeyword)
end

local function vikaIsMoved(tv)
  local tv1 = getVisualSelection()
  return tv1, tv['scol'] ~= tv1['scol'] or tv['ecol'] ~= tv1['ecol']
end

local function vikaMoved(tv, who)
  local tv1, isMoved = vikaIsMoved(tv)
  if not isMoved then return false end
  vikaLine = tv1['sline']
  local vika = {}
  vika["scol"] = tv1['scol']
  vika["ecol"] = tv1['ecol']
  ccol = tv1['ccol']
  table.insert(vikaStack, vika) 
  return true
end

local function vikaWonkyQuotes(chr, tv) 
  -- todo: is vim's wonky selection of a inner quote, a bug or feature
  vim.cmd('normal i' .. chr)
  local tv1, isMoved = vikaIsMoved(tv)
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

function _G.vikaExpand()
  local t = {'\'', '"', '(', '[', '{'}
  local quotes = {"'", '"'}
  local tv = getVisualSelection()

  if (tv['sline'] ~= tv['eline']) then return end

  if ( tv['scol'] == tv['ecol'] ) then 
    vikaStack = {}
    local vika = {}
    vika["scol"] = tv['scol']
    vika["ecol"] = tv['ecol']
    table.insert(vikaStack, vika) 
    vim.cmd('normal iw')
    if (vikaMoved(tv)) then
      return
    end
  end
  local txt = tv['lineText']
  local col = tv['scol'] - 1
  for i = col, 1, -1 do 
    local chr = string.sub(txt, i, i)
    if (existsIn(chr, t)) then 
      if (existsIn(chr, quotes)) then 
        vikaWonkyQuotes(chr, tv)
      else
        vim.cmd('normal a' .. chr)
      end
      if vikaMoved(tv, 'textobject') then break end
    end
    if (i == 1) then
      vim.cmd('normal $o^')
      if vikaMoved(tv, 'short line') then break end
      vim.cmd('normal $o0', 'line')
      if vikaMoved(tv, 'whole line') then return end
    end
  end
  if (col <= 1) then vim.cmd('normal ip') end
end

function _G.vikaExpand1Chr()
  local tv = getVisualSelection()
  local ccol, scol = tv["ccol"], tv["scol"] 
  if ccol > scol then
    vim.cmd('normal ohol')
  else
    vim.cmd('normal hol')
  end
end

function _G.vikaContract1Chr()
  local tv = getVisualSelection()
  local ccol, scol = tv["ccol"], tv["scol"] 
  if ccol > scol then
    vim.cmd('normal oloh')
  else
    vim.cmd('normal loh')
  end
end

function _G.vikaContract()
  local vika = table.remove(vikaStack)
  if (vika == nil) then return end
  local scol = vika['scol']
  local ecol = vika['ecol']
  local tv = getVisualSelection()
  if (tv['sline'] ~= tv['eline']) then 
    vim.cmd('normal VV')
    vim.cmd('normal v')
  end
  local ccol = tv['ccol']
  if (ccol > scol) then vim.cmd('normal o') end
  vim.fn.setpos(".", {0, vikaLine, scol})
  vim.cmd('normal o')
  vim.fn.setpos(".", {0, vikaLine, ecol})
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
  local pattern = vim.fn.input('vi-ka>')
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

-- todo: why wont esc, escape from visual mode 
local function strToNormal()
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  if mode == 'v' or mode == 'V' then 
    return mode
  elseif mode == 'CTRL-V' then
    return 'VV'
  else 
    return ''
  end
end

function _G.vikaChange(chr)
  local tv = getVisualSelection()
  local txt, col = tv["stext"], tv["scol"]
  if not txt or txt == '' then return end

  local command = 'c'
  if vikaOnKeyword and vikaWord == txt  then
    command = strToNormal() .. "ciw"
  end
  vim.api.nvim_feedkeys(command, 'n', false)
  -- vim.cmd('mess clear')
  -- print("command", command)
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
  if vikaOnKeyword and vikaWord == xtxt and osm .. oem == '??' then
    command = strToNormal() .. "ciw" .. sm .. xtxt .. em
  end
  vim.api.nvim_feedkeys(command, 'n', false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>',true,false,true),'n',false)
  vim.cmd('mess clear')
  print("command", command)
end

local function patternChange(chr, patternType)
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

function _G.vikaPatternTxt()
  patternChange('.', 't')
  vim.api.nvim_input('<left><left><left><left>')
end

function _G.vikaPattern()
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

function _G.vikaInsert()
  _G.getVisualSelection('start')
  vim.api.nvim_input('<c-[>i')
end

function _G.vikaAppend()
  _G.getVisualSelection('end')
  vim.api.nvim_input('<c-[>a')
end
