-- position windows. If the width is already set, use an alternative.
local function winToPos(posWanted, wx, hx, wxIfAlready) 
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    local widthx = math.floor(max.w * wx)
    local posLR = posWanted

    if posLR == 'leftright' then
      if f.x == 0 then
        posLR = 'left'
      else
        posLR = 'right'
      end
    end

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
        f.x = 0
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
        f.x = 0
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
        f.x = 0
    end
    win:setFrame(f, 0)
end

local function winDown() 
    local win = hs.window.focusedWindow()
    local max = win:screen():frame()
    local f = win:frame()
    local ywant = max.h / 2

    if f.h > ywant then
      f.h = ywant
    else
      if f.y < 100 then
        f.y = max.h - f.h + max.y
      else
        f.y = 0
      end
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

-- position half
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "up", function() winToPos("leftright", .5, 1, .75) end)

-- position half height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "down", function() winDown() end)

-- maximize window
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Return", function() winToPos("left", 1, 1, .98) end)

-- smaller width
hs.hotkey.bind({"alt", "ctrl"}, "left", function() winSize(-20, 0) end, nil, function() winSize(-20, 0) end)

-- larger width
hs.hotkey.bind({"alt", "ctrl"}, "right", function() winSize(20, 0) end, nil, function() winSize(20, 0) end)

-- smaller height
hs.hotkey.bind({"alt", "ctrl"}, "up", function() winSize(0, -20) end, nil, function() winSize(0, -20) end)

-- larger height
hs.hotkey.bind({"alt", "ctrl"}, "down", function() winSize(0, 20) end, nil, function() winSize(0, 20) end)
