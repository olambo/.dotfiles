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
