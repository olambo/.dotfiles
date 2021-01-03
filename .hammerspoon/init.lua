-- open/focus on the app or if its already focused, the previous app
local function focusToFromApp(appname)
    local curapp = hs.application.frontmostApplication():name()
    local appToRun
    if prvapp == nil then
        prvapp = "none"
    end
    if hs.application.get(appname) == nil then
        print(appname .. " NOT running open " .. appname)
        appToRun = appname
    elseif appname == curapp then
        print(appname .. " already frontmost goto " .. prvapp)
        appToRun = prvapp
        prvapp = appname
    else
        print("prvapp " .. prvapp .. " curapp " .. curapp .. " goto " .. appname)
        appToRun = appname
        prvapp = curapp
    end
    if appToRun == "iTerm2" then
        -- strange but needed
        appToRun = "iTerm"
    end
    hs.application.launchOrFocus(appToRun)
end

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'i', function()
    focusToFromApp("iTerm2")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 's', function()
    focusToFromApp("Safari")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'b', function()
    focusToFromApp("Mail")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "f", function()
    focusToFromApp("Finder")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "a", function()
    focusToFromApp("Dash")
end)

-- in iTerm2, open a low height split pane below the current one,
-- run vcommand-start and move back to previous pane
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "v", function()
    local function doKeyStroke(modifiers, character)
        local event = require("hs.eventtap").event
        event.newKeyEvent(modifiers, string.lower(character), true):post()
        event.newKeyEvent(modifiers, string.lower(character), false):post()
    end
    if hs.application.frontmostApplication():name() ~= "iTerm2" then
        return
    end
    -- doesnt appear to work remotely without an eventtap
    hs.eventtap.keyStroke({'cmd','shift'}, 'd')
    for i = 1,10,1 do
        doKeyStroke({'cmd','ctrl'}, 'down')
    end
    hs.eventtap.keyStrokes('vcommand-start\n')
    -- previous pane
    doKeyStroke({'cmd'}, '[')
end)

-- position the window to left at 70% width, or if already this, left half of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if math.abs(f.w - max.w*.7) < 1 then
      f.w = max.w * .5
  else
    f.w = max.w * .7
  end
  f.x = max.x
  f.y = max.y
  f.h = max.h
  win:setFrame(f, 0)
end)

-- position the window full width or if already full width, right half of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if f.w == max.w and f.h == max.h then
      local halfw = max.w / 2
      f.x = max.x + halfw
      f.y = max.y
      f.w = halfw
      f.h = max.h
  else
    f.x = max.x
      f.y = max.y
      f.w = max.w
      f.h = max.h
  end
  win:setFrame(f, 0)
end)

-- position to upper left of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local halfh = max.h / 2
  local halfw = max.w / 2

  f.x = max.x
  f.y = max.y
  f.w = halfw
  f.h = halfh
  win:setFrame(f, 0)
end)

-- position to lower right of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  local halfh = max.h / 2
  local halfw = max.w / 2

  f.x = halfw
  f.y = halfh
  f.w = halfw
  f.h = halfh
  win:setFrame(f, 0)
end)
