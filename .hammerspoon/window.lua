-- ============================
-- Window Management Module
-- ============================

-- Move or resize windows on the screen
-- f = current window frame
-- max = screen frame
-- wx, hx = width/height fractions
-- wxIfAlready = alternate width if already at desired width

local function winToPos(posWanted, wx, hx, wxIfAlready) 
    local win = hs.window.focusedWindow()
    if not win then return end  -- safety check
    local f = win:frame()
    local max = win:screen():frame()
    local widthx = math.floor(max.w * wx)
    local posLR = posWanted

    -- If 'leftright', decide whether to go left or right based on current position
    if posLR == 'leftright' then
      if f.x == 0 then
        posLR = 'left'
      else
        posLR = 'right'
      end
    end

    -- Adjust width if already at desired width
    if posLR == "mid" and math.floor((max.w - f.w) / 2) ~= f.x then
    elseif widthx == f.w then
        widthx = math.floor(max.w * wxIfAlready)
    end

    -- Set initial position and size
    f.x = max.x
    f.y = max.y
    f.w = widthx
    f.h = max.h * hx

    -- Adjust X and Y depending on left/mid/right alignment
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

-- ============================
-- Move window right by a fraction
-- ============================

local function winRight() 
    local win = hs.window.focusedWindow()
    if not win then return end
    local max = win:screen():frame()
    local f = win:frame()
    local ex = (max.w - f.w) / 4  -- step size

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

-- ============================
-- Move window left by a fraction
-- ============================

local function winLeft() 
    local win = hs.window.focusedWindow()
    if not win then return end
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

-- ============================
-- Move window down or half-height toggle
-- ============================

local function winDown() 
    local win = hs.window.focusedWindow()
    if not win then return end
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

-- ============================
-- Resize window by delta
-- ============================

local function winSize(x, y) 
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    f.w = f.w + x
    f.h = f.h + y
    win:setFrame(f, 0)
end

-- ============================
-- Hotkey Bindings
-- ============================

-- Move left / right
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Left", function() winLeft() end)
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Right", function() winRight() end)

-- Half / half-height
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Up", function() winToPos("leftright", .5, 1, .75) end)
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Down", function() winDown() end)

-- Maximize window
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Return", function() winToPos("left", 1, 1, .98) end)

-- Resize (hold alt+ctrl)
hs.hotkey.bind({"alt", "ctrl"}, "Left", function() winSize(-20, 0) end, nil, function() winSize(-20, 0) end)
hs.hotkey.bind({"alt", "ctrl"}, "Right", function() winSize(20, 0) end, nil, function() winSize(20, 0) end)
hs.hotkey.bind({"alt", "ctrl"}, "Up", function() winSize(0, -20) end, nil, function() winSize(0, -20) end)
hs.hotkey.bind({"alt", "ctrl"}, "Down", function() winSize(0, 20) end, nil, function() winSize(0, 20) end)

