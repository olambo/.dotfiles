hs.ipc.cliInstall()
curapp = hs.application.frontmostApplication():bundleID()
prvapp = hs.application.frontmostApplication():bundleID()
function applicationWatcher(appName, eventType, appObject)
    -- appName is no good. Want bundleID
    if (eventType == hs.application.watcher.deactivated) then
        capp = hs.application.frontmostApplication():bundleID()
        if capp ~= 'com.apple.loginwindow' and appName ~= 'loginwindow' then
            if (cap ~= curapp) then prvapp = curapp end
            curapp = capp
        end
        -- print("prvapp:" .. prvapp .. " curapp:" .. curapp)
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

local function keyStroke(modifiers, key)
    hs.eventtap.keyStroke(modifiers, key, 0)
end

local function keyCodem(modifiers, key)
  return function() hs.eventtap.keyStroke(modifiers, key, 0) end
end

local function keyCode(key)
  -- use newKeyEvent to get down and up working in chooser
  return function()
    hs.eventtap.event.newKeyEvent(key, true):post()
    hs.eventtap.event.newKeyEvent(key, false):post()
  end
end

-- https://stackoverflow.com/questions/56751409/paste-text-from-hs-chooser-in-hammerspoon
local chooser

local chooserDict = {
    ["u"] = "com.googlecode.iterm2",
    ["p"] = "com.jetbrains.pycharm.ce",
    ["v"] = "com.microsoft.VSCode",
    ["s"] = "com.apple.Safari",
    ["l"] = "com.apple.Safari",
    ["b"] = "com.apple.Safari",
    ["m"] = "com.apple.mail",
    ["f"] = "om.apple.finder",
    ["n"] = "com.apple.Notes",
    [" "] = " ",
}

local function chooserApp(appChar)
    local app = chooserDict[appChar]
    if (appChar == ' ') then app = prvapp end
    -- print ('switch to ' .. appChar ..':'.. app)
    if (app == nil) then return end
    if (appChar ~= 'b') then hs.application.launchOrFocusByBundleID(app) end
    if appChar == 'b' then keyStroke({'shift', 'ctrl', '⌥', '⌘'}, 'b') end
    if appChar == 'l' then keyStroke({'⌥', '⌘'}, 'f') end
end

local function chooserChoice(localchoice)
  if not localchoice then chooser:selectedRow(1); return end
  chooser:selectedRow(1)
  chooserApp(localchoice["command"])
end

chooser = hs.chooser.new(chooserChoice)

chooser:choices({
  { ["text"] = "Unix-iterm", ["command"] = 'u'},
  { ["text"] = "Pycharm",    ["command"] = 'p'},
  { ["text"] = "Vscode",     ["command"] = 'v'},
  { ["text"] = "Safari",     ["command"] = 's'},
  { ["text"] = "Lookup-safari",    ["command"] = 'l'},
  { ["text"] = "Brave",      ["command"] = 'b'},
  { ["text"] = "Mail",       ["command"] = 'm'},
  { ["text"] = "Finder",     ["command"] = 'f'},
  { ["text"] = "Notes-term", ["command"] = 'n'},
  { ["text"] = "<space> previous app",          ["command"] = ' '},
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

local function iTerm2VsKeyCode(l1, l2, r1, r2)
  return function()
   capp = hs.application.frontmostApplication():bundleID()
   if capp == 'com.googlecode.iterm2' or capp == 'com.microsoft.VSCode' or capp == 'dev.zed.Zed' or capp == 'com.jetbrains.pycharm.ce' then
     keyStroke(l1, l2)
   else
     keyStroke(r1, r2)
   end
 end
end

local function expandContract()
  return function()
   capp = hs.application.frontmostApplication():bundleID()
   if capp == 'PyCharm' then
     keyStroke({'shift', '⌘'}, 'f12')
   elseif capp == 'iTerm2' then
     keyStroke({'shift', '⌘'}, 'return') 
   else
     keyStroke({'⌘'}, 'b') 
   end
 end
end

hs.hotkey.bind({'ctrl'}, '9', iTerm2VsKeyCode({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', iTerm2VsKeyCode({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, 'j', keyCode('down'), nil, keyCode('down'))
hs.hotkey.bind({'ctrl'}, 'k', keyCode('up'), nil, keyCode('up'))
hs.hotkey.bind({'ctrl'}, 'l', keyCode('right'), nil, keyCode('right'))
hs.hotkey.bind({'ctrl'}, 'm', keyCodem({'shift', 'command'}, ']'), nil, keyCodem({'shift', 'command'}, ']'))
hs.hotkey.bind({'shift', 'ctrl'}, 'm', keyCodem({'shift', 'command'}, '['), nil, keyCodem({'shift', 'command'}, '['))
hs.hotkey.bind({'ctrl'}, 'return', expandContract())
hs.hotkey.bind({'ctrl'}, 'space', function() chooser:show() end)

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
      send_escape = false
      return true, {
        hs.eventtap.event.newKeyEvent('escape', true),
        hs.eventtap.event.newKeyEvent('escape', false),
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
