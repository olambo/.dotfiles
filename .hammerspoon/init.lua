hs.ipc.cliInstall()
curapp = hs.application.frontmostApplication():name()
prvapp = hs.application.frontmostApplication():name()
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.deactivated) then
        capp = hs.application.frontmostApplication():name()
        if capp ~= 'loginwindow' and appName ~= 'loginwindow' then
            prvapp = appName
            curapp = capp
        end
        -- print("prvapp " .. prvapp .. " curapp " .. curapp)
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- position windows. If the width is already set, use an alternative.
local function winToPos(posLR, wx, hx, wxIfAlready) 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    local widthx = math.floor(max.w * wx)

    if posLR == "mid" and math.floor((max.w - f.w) / 2) ~= f.x then
    elseif widthx == f.w then
        widthx = math.floor(max.w * wxIfAlready)
    end
    f.x = max.x
    f.y = max.y
    f.w = widthx
    f.h = max.h * hx
    if posLR == "right" and f.w ~= max.w then
        f.x = max.w - f.w 
    end
    if posLR == "right" and f.h ~= max.h then
        f.y = max.h - f.h 
    end
    if posLR == "left" and f.w ~= max.w then
        f.x = 10
    end
    if posLR == "mid"  then
        f.x = math.floor((max.w - f.w) / 2)
    end
    win:setFrame(f, 0)
end

local function winRight() 
    local win = hs.window.focusedWindow()
    local max = win:screen():frame()
    local f = win:frame()
    local ex = (max.w - f.w) / 4

    if f.x == 10 then
        f.x = 0
    end

    if f.x >= ex * 4 then
        f.x = 10
    else
        f.x = f.x + ex
    end
    win:setFrame(f, 0)
end

local function winLeft() 
    local win = hs.window.focusedWindow()
    local max = win:screen():frame()
    local f = win:frame()
    local ex = (max.w - f.w) / 4

    if f.x <= 10 then
        f.x = ex * 4
    else
        f.x = f.x - ex
    end
    if f.x < 10 then
        f.x = 10
    end
    win:setFrame(f, 0)
end

-- size the window
local function winSize(x, y) 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.w = f.w + x
    f.h = f.h + y
    win:setFrame(f, 0)
end

-- move left
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Left", function() winLeft() end)

-- move right
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "right", function() winRight() end)

-- position mid
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "up", function() winToPos("mid", .5, 1, .7) end)

-- position to lower right
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "down", function() winToPos("right", .5, .5, .3) end)

-- maximize window
hs.hotkey.bind({"alt", "ctrl"}, "Return", function() winToPos("left", 1, 1, .8) end)

-- smaller width
hs.hotkey.bind({"alt", "ctrl"}, "left", function() winSize(-20, 0) end, nil, function() winSize(-20, 0) end)

-- larger width
hs.hotkey.bind({"alt", "ctrl"}, "right", function() winSize(20, 0) end, nil, function() winSize(20, 0) end)

-- smaller height
hs.hotkey.bind({"alt", "ctrl"}, "up", function() winSize(0, -20) end, nil, function() winSize(0, -20) end)

-- larger height
hs.hotkey.bind({"alt", "ctrl"}, "down", function() winSize(0, 20) end, nil, function() winSize(0, 20) end)

-- 
-- https://stackoverflow.com/questions/56751409/paste-text-from-hs-chooser-in-hammerspoon
local chooser

local chooserDict = {
    [";"] = ";",
    ["d"] = "Dash",
    ["u"] = "iTerm2",
    ["p"] = "PyCharm",
    ["i"] = "IntelliJ IDEA",
    ["v"] = "Visual Studio Code",
    ["s"] = "Safari",
    ["m"] = "Mail",
    ["f"] = "Finder",
    ["n"] = "iTermN",
}

local function chooserApp(appChar)
    local app = chooserDict[appChar]
    -- print('appChar:'..appChar)
    if (appChar == ';') then app = prvapp end
    if (app == nil) then return end
    if app == "iTerm2" then app = "iTerm" end
    if app == "IntelliJ IDEA" then app = "IntelliJ IDEA CE" end
    if app == "PyCharm" then app = "PyCharm CE" end
    -- print ('chooserApp:'..app..'.')
    hs.application.launchOrFocus(app)
end

local function chooserChoice(localchoice)
  if not localchoice then chooser:selectedRow(1); return end
  chooser:selectedRow(1)
  chooserApp(localchoice["command"])
end

chooser = hs.chooser.new(chooserChoice)

chooser:choices({
  { ["text"] = ";",          ["command"] = ';'},
  { ["text"] = "Dash",       ["command"] = 'd'},
  { ["text"] = "Unix-iterm", ["command"] = 'u'},
  { ["text"] = "Pycharm",    ["command"] = 'p'},
  { ["text"] = "Intellij",   ["command"] = 'i'},
  { ["text"] = "Vscode",     ["command"] = 'v'},
  { ["text"] = "Safari",     ["command"] = 's'},
  { ["text"] = "Mail",       ["command"] = 'm'},
  { ["text"] = "Finder",     ["command"] = 'f'},
  { ["text"] = "Notes-term", ["command"] = 'n'},
})

local function queryChangedCallback(query)
  if query ~= '' then
     -- print("query " .. query)
     chooser:query('')
     chooser:selectedRow(1)
     chooser:cancel()
     chooserApp(query)
  end
end


chooser:queryChangedCallback(queryChangedCallback)

local function keyStroke(modifiers, key)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
end

local function keyCodem(modifiers, key)
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function keyCode(key)
  return keyCodem({}, key)
end

local function iTerm2VsKeyCode(l1, l2, r1, r2)
  return function()
   capp = hs.application.frontmostApplication():name()
   if capp == 'iTerm2' or capp == 'Code' then
     keyStroke(l1, l2)
   else
     keyStroke(r1, r2)
   end
 end
end

hs.hotkey.bind({'ctrl'}, '9', iTerm2VsKeyCode({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', iTerm2VsKeyCode({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, 'l', keyCode('right'), nil, keyCode('right'))
hs.hotkey.bind({'ctrl'}, 'p', keyCode('up'), nil, keyCode('up'))
hs.hotkey.bind({'ctrl'}, 'n', keyCode('down'), nil, keyCode('down'))
hs.hotkey.bind({'ctrl'}, 'space', function() chooser:show() end)
hs.hotkey.bind({'ctrl'}, 'return', function() 
  keyStroke({'⌘'}, 'b') 
  end)

send_escape = false
last_mods = {}

control_key_handler = function()
  send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
    return false
  end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    last_mods = new_mods
    control_key_timer:stop()
    if send_escape then
      return true, {
        hs.eventtap.event.newKeyEvent({}, 'escape', true),
        hs.eventtap.event.newKeyEvent({}, 'escape', false),
      }
    end
  end
  return false
end

control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
control_tap:start()

other_handler = function(evt)
  send_escape = false
  return false
end

other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
other_tap:start()
