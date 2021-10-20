-- Move up or down a file utilizing partial line numbers. 
-- Type a single digit followed by a movement key to move to the row ending with that digit.
-- Type two digits followed by a movement key to move to the row ending with the two digits.

local vike0Cnt = 0
local jkByOne = true

local function vikeDir(lnr, cnt, dir, zeroCnt) 
  if cnt >= 100 or cnt < 0 then
    print('v:count too big ' .. cnt .. ' set to 0')
    cnt = 0
  end

  local unit = 10
  if cnt >= 10 or zeroCnt > 1 or (cnt ~= 0 and zeroCnt > 0) then
    unit = 100
  end
  local roundedToUnit = math.floor(lnr/unit)*unit
  local l = roundedToUnit + cnt
  if dir == 1 and l < lnr then
    l = l + unit
  elseif dir == -1 and l > lnr then
    l = l - unit
  end
  local x = l
  if (l == lnr) then
    l = l + (unit*dir)
  end
  if l < 1 then
    l = 1
  end
  -- print("wantL unit roundedToUnit L nL:", cnt, unit, roundedToUnit, x, l, 'zeroCnt', zeroCnt)
  return l, unit
end

function _G.vike0()
  local col = vim.fn.col('.')
  vike0Cnt = vike0Cnt + 1
  vim.api.nvim_feedkeys('0', 'n', false)
end

function _G.vike0Sneak()
  local col = vim.fn.col('.')
  if col == 1 then
    -- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
    jkByOne = true
    vike0Cnt = 0
    vim.fn.feedkeys(string.format('%c%c%cSneak_s', 0x80, 253, 83))
  else 
    vim.fn.feedkeys(string.format('%c%c%cSneak_;', 0x80, 253, 83))
  end
end

function _G.vike0SneakUp()
  local col = vim.fn.col('.')
  if col == 1 then
    jkByOne = true
    vike0Cnt = 0
    vim.fn.feedkeys(string.format('%c%c%cSneak_S', 0x80, 253, 83))
  else 
    vim.fn.feedkeys(string.format('%c%c%cSneak_,', 0x80, 253, 83))
  end
end

function _G.vikeUp()
  vikeUpOrDown(-1)
end

function _G.vikeDown()
  vikeUpOrDown(1)
end

-- only for jkByOne, which may be removed
function _G.vikeL()
  jkByOne = true
  vim.api.nvim_feedkeys('l', 'n', false)
end

function _G.vikeK()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt == 0 and (col > 1 or (vike0Cnt == 0 and jkByOne)) then
    jkByOne = true
    vim.api.nvim_feedkeys('gk', 'n', false)
  else
    vikeUpOrDown(-1)
  end
end

function _G.vikeJ()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt == 0 and (col > 1 or (vike0Cnt == 0 and jkByOne)) then
    jkByOne = true
    vim.api.nvim_feedkeys('gj', 'n', false)
  else
    vikeUpOrDown(1)
  end
end

function vikeUpOrDown(dir, isBlockMode)
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  local curln = vim.fn.line('.')
  local ln, unit
  if cnt == 0 and (col > 1 or vike0Cnt == 0) then
    ln = curln + (10 * dir)
    if ln < 1 then 
      ln = 1
    end
  else 
    ln, unit = vikeDir(curln, cnt, dir, vike0Cnt)
    jkByOne = true -- unit ~= 10
  end
  vike0Cnt = 0
  local col1Cmd = '0'
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local cv = vim.api.nvim_replace_termcodes('<c-v>',true,false,true)
  if mode == cv or isBlockMode then
    col1Cmd = ''
  end
  vim.api.nvim_feedkeys(col1Cmd .. ln .. 'G', 'n', false)
end

function _G.vikeV()
  local cnt = vim.api.nvim_eval('v:count')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  if cnt == 0 then
    if mode == 'v' then 
      vim.api.nvim_feedkeys('V', 'n', false)
    else 
      vim.api.nvim_feedkeys('v', 'n', false)
    end
  else
    if mode ~= 'V' then 
      vim.api.nvim_feedkeys('V', 'n', false)
    end
    vikeUpOrDown(1)
  end
  jkByOne = true
end

function _G.vikeVB()
  local cnt = vim.api.nvim_eval('v:count')
  local modeInfo = vim.api.nvim_get_mode()
  local mode = modeInfo.mode
  local cv = vim.api.nvim_replace_termcodes('<c-v>',true,false,true)
  if mode ~= cv then
    vim.api.nvim_feedkeys(cv,'n',false)
  end
  if cnt > 0 then
    vikeUpOrDown(1, true)
  elseif mode == 'n' then
    -- select an extra line to start
    vim.api.nvim_feedkeys('j','n',false)
  end
  jkByOne = true
end

