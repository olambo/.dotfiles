vikeZeroOn = false

local function vikeDir(lnr, cnt, dir) 
  if cnt >= 100 then
    print('v:count too big ' .. cnt .. ' set to 0')
    cnt = 0
  end

  local unit = 10
  if cnt >= 10 then
    unit = 100
  end
  local roundedToUnit = math.floor(lnr/unit)*unit
  local l = roundedToUnit + cnt
  if dir == 1 and l < lnr then
    l = l + unit
  elseif dir == -1 and l > lnr then
    l = l - unit
  end
  return l
end

function _G.vikeZero()
  vikeZeroOn = true
  vim.api.nvim_feedkeys('0', 'n', false)
end

function _G.vikeSneak()
  local col = vim.fn.col('.')
  if col == 1 then
    -- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
    vim.fn.feedkeys(string.format('%c%c%cSneak_s', 0x80, 253, 83))
  else 
    vim.fn.feedkeys(string.format('%c%c%cSneak_;', 0x80, 253, 83))
  end
end

function _G.vikeUp()
  vikeUpOrDown(-1)
end

function _G.vikeDown()
  vikeUpOrDown(1)
end

function _G.vikeK()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt == 0 and (col > 1 or not vikeZeroOn) then
    vim.api.nvim_feedkeys('gk', 'n', false)
  else
    vikeUpOrDown(-1)
  end
end

function _G.vikeJ()
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  if cnt == 0 and (col > 1 or not vikeZeroOn) then
    vim.api.nvim_feedkeys('gj', 'n', false)
  else
    vikeUpOrDown(1)
  end
end

function vikeUpOrDown(dir)
  local cnt = vim.api.nvim_eval('v:count')
  local col = vim.fn.col('.')
  local curln = vim.fn.line('.')
  local ln
  if cnt == 0 and (col > 1 or not vikeZeroOn) then
    ln = curln + (10 * dir)
    print("vikeZeroOn", vikeZeroOn)
  else 
    ln = vikeDir(curln, cnt, dir)
    if (ln == curln) then
      ln = curln + (10 * dir)
    end
  end
  vikeZeroOn = false
  vim.api.nvim_feedkeys('0' .. ln .. 'G', 'n', false)
end
