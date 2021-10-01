curapp = hs.application.frontmostApplication():name()
prvapp = hs.application.frontmostApplication():name()
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.deactivated) then
        capp = hs.application.frontmostApplication():name()
        if capp ~= 'loginwindow' and appName ~= 'loginwindow' then
            prvapp = appName
            curapp = capp
        end
        -- print("prvapp " .. prvapp)
        -- print("curapp " .. curapp)
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- in iTerm2, open a low height split pane below the current one, Run vcommand-start and move back to previous pane
hs.hotkey.bind({}, 'f6', function()
    local function doKeyStroke(modifiers, character)
        local event = require("hs.eventtap").event
        event.newKeyEvent(modifiers, string.lower(character), true):post()
        event.newKeyEvent(modifiers, string.lower(character), false):post()
    end
    if hs.application.frontmostApplication():name() ~= "iTerm2" then return end
    -- doesnt appear to work remotely without an eventtap
    hs.eventtap.keyStroke({'cmd','shift'}, 'd')
    for i = 1,10,1 do
        doKeyStroke({'cmd','ctrl'}, 'down')
    end
    hs.eventtap.keyStrokes('vcommand-start\n')
    -- previous pane
    doKeyStroke({'cmd'}, '[')
end)

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
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "Left", function() winLeft() end)

-- move right
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "right", function() winRight() end)

-- position mid
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "up", function() winToPos("mid", .5, 1, .7) end)

-- position to lower right
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "down", function() winToPos("right", .5, .5, .3) end)

-- not hyperkey keys
-- maximize window
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Return", function() winToPos("left", 1, 1, .8) end)

-- smaller width
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "left", function() winSize(-20, 0) end, nil, function() winSize(-20, 0) end)

-- larger width
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "right", function() winSize(20, 0) end, nil, function() winSize(20, 0) end)

-- smaller height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "up", function() winSize(0, -20) end, nil, function() winSize(0, -20) end)

-- larger height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "down", function() winSize(0, 20) end, nil, function() winSize(0, 20) end)

-- 
-- https://stackoverflow.com/questions/56751409/paste-text-from-hs-chooser-in-hammerspoon
local chooser

local chooserDict = {
    ["u"] = "iTerm2",
    ["i"] = "Intellij IDEA",
    ["v"] = "Visual Studio Code",
    ["s"] = "Safari",
    ["m"] = "Mail",
    ["f"] = "Finder",
    ["n"] = "Alacritty",
}

local function chooserApp(appChar)
    local app = chooserDict[appChar]
    if (appChar == ';') then app = prvapp end
    if (app == nil) then return end
    if app == "iTerm2" then app = "iTerm" end
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
  { ["text"] = "Unix-iterm", ["command"] = 'u'},
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

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, ";", function() chooser:show() end)
