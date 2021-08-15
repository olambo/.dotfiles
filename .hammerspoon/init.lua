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

-- open/focus on the app or if its already focused, the previous app
local function focusToFromApp(appname, bounce)
    local appToRun
    if hs.application.get(appname) == nil then
        -- print(appname .. " NOT running open " .. appname)
        appToRun = appname
    elseif appname == curapp then
        -- print(appname .. " already frontmost goto " .. prvapp)
        if bounce == nil then
            appToRun = appname
        else
            appToRun = prvapp
        end
    else
        -- print("prvapp " .. prvapp .. " curapp " .. curapp .. " goto " .. appname)
        appToRun = appname
    end
    if appToRun == "iTerm2" then
        -- strange but needed
        appToRun = "iTerm"
    end
    hs.application.launchOrFocus(appToRun)
end

local function spaceapp(appname, altapp)
    if appname == curapp then
        focusToFromApp(altapp)
    else
        focusToFromApp(appname)
    end
end

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'u', function() spaceapp("iTerm2", "Postman") end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'i', function() spaceapp("IntelliJ IDEA", "Asana") end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'o', function() spaceapp("Safari", "Calendar") end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'p', function() spaceapp("Mail", "Slack") end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, '8', function() focusToFromApp(prvapp, true) end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "m", function() focusToFromApp("Finder", true) end)

-- <hyp>-, this is been rebound by hammerspoon to prevent runnning of apple diagnostics
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "8", function() focusToFromApp("Terminal", true) end)

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

-- position windows. If the width is already set, use an alternative.
local function winToPos(posLR, wx, hx, wxIfAlready) 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    local widthx = max.w * wx
    if posLR == "left" and f.x > 90 then
        -- dont change width
    elseif math.abs(widthx - f.w) < 20 and math.abs(max.h * hx - f.h) < 20 then
        widthx = max.w * wxIfAlready
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
    win:setFrame(f, 0)
end

-- move the window to the right, or if at far right to far left
local function winMove() 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    local extrax = max.w - f.w
    if f.x < 50 and max.w > 3000 then
        f.x = extrax/2
    elseif max.w > 3000 and f.x + f.w < max.w then
        f.x = extrax
    elseif f.x < 50 then
        f.x = extrax
    else
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

-- position the window to left 
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "Left", function() winToPos("left", .5, 1, .7) end)

-- move the window to the right 
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "right", function() winMove() end)

-- position to upper left
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "up", function() winToPos("left", .5, .5, .3) end)

-- position to lower right
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "down", function() winToPos("right", .5, .5, .3) end)

-- not hyperkey keys
-- maximize window
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Return", function() winToPos("left", 1, 1, .8) end)

-- smaller width
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "left", function() winSize(-10, 0) end, nil, function() winSize(-10, 0) end)

-- larger width
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "right", function() winSize(10, 0) end, nil, function() winSize(10, 0) end)

-- smaller height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "up", function() winSize(0, -10) end, nil, function() winSize(0, -10) end)

-- larger height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "down", function() winSize(0, 10) end, nil, function() winSize(0, 10) end)

