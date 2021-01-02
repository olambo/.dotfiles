hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function()
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
  hs.window.animationDuration=0
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "right", function()
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
  hs.window.animationDuration=0
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "up", function()
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
  hs.window.animationDuration=0
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "down", function()
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
  hs.window.animationDuration=0
  win:setFrame(f)
end)

local function tryapp(appname)
    local curapp = hs.application.frontmostApplication():name()
    if prvapp == nil then
        prvapp = "none"
    end
    print("prv:" .. prvapp .. " cur:".. curapp .. " appname:" .. appname)
    if appname == curapp and appname ~= "none" then
        -- print("go:" .. prvapp)
        if prvapp == "iTerm2" then
            hs.application.launchOrFocus("iTerm") 
        else
            hs.application.launchOrFocus(prvapp) 
        end
        prvapp = appname
    else 
        -- print("go:" .. appname)
        if appname == "iTerm2" then
            hs.application.launchOrFocus("iTerm") 
        else
            hs.application.launchOrFocus(appname) 
        end
        prvapp = curapp
    end
end

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, 'i', function() 
    tryapp("iTerm2") 
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, 's', function() 
    tryapp("Safari") 
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, 'b', function() 
    tryapp("Mail") 
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "f", function() 
    tryapp("Finder") 
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "a", function() 
    tryapp("Dash") 
end)

myDoKeyStroke = function(modifiers, character)
    local event = require("hs.eventtap").event
    event.newKeyEvent(modifiers, string.lower(character), true):post()
    event.newKeyEvent(modifiers, string.lower(character), false):post()
end

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "v", function() 
	local curapp = hs.application.frontmostApplication():name()
    -- print(" cur:".. curapp)
	if curapp ~= "iTerm2" then
		return
	end
	-- doesnt appear to work remotely without an eventtap
	hs.eventtap.keyStroke({'cmd','shift'}, 'd')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	myDoKeyStroke({'cmd','ctrl'}, 'down')
	hs.eventtap.keyStrokes('vcommand-start\n')
	myDoKeyStroke({'cmd'}, '[')
end)
