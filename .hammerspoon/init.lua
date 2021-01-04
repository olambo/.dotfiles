-- open/focus on the app or if its already focused, the previous app
local function focusToFromApp(appname)
    local curapp = hs.application.frontmostApplication():name()
    local appToRun
    if prvapp == nil then
        prvapp = "none"
    end
    if hs.application.get(appname) == nil then
        -- print(appname .. " NOT running open " .. appname)
        appToRun = appname
    elseif appname == curapp then
        -- print(appname .. " already frontmost goto " .. prvapp)
        appToRun = prvapp
        prvapp = appname
    else
        -- print("prvapp " .. prvapp .. " curapp " .. curapp .. " goto " .. appname)
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

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, 'e', function()
    focusToFromApp("Mail")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "d", function()
    focusToFromApp("Dash")
end)

hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "u", function()
    focusToFromApp("Finder")
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

-- position windows. If the width is already set, use an alternative.
-- keeps the number of keys to be bound to a minimum
local function winToPos(posLR, wx, hx, wxIfAlready) 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    local widthx = max.w * wx
    if math.abs(widthx - f.w) < 1 and math.abs(max.h * hx - f.h) < 1 then
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
    win:setFrame(f, 0)
end

-- position the window to left at 70% width, or if already this, left half of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "Left", function()
    winToPos("left", .7, 1, .5)
end)

-- position the window full width or if already full width, right half of screen
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "right", function()
    winToPos("right", 1, 1, .5)
end)

-- position to upper half of screen, or upper left
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "up", function()
    winToPos("left", 1, .5, .5)
end)

-- position to lower half of screen, or lower right
hs.hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "down", function()
    winToPos("right", 1, .5, .5)
end)
