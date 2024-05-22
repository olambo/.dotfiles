-- https://github.com/Hammerspoon/hammerspoon/blob/0.9.54/SPOONS.md#how-do-i-install-a-spoon
--- === ControlEscape ===
---
--- Make the `control` key more useful: 
--- If the `control` key is tapped, treat it as the `escape` key. 
--- If the `control` key is held down and used in combination with another key, then provide the normal `control` key behavior.
-- based off https://github.com/jasonrudolph/ControlEscape.spoon

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "ControlEscape"
obj.version = "0.1"
obj.author = "olambo"
obj.homepage = "https://github.com/olambo/.dotfiles/tree/main/.hammerspoon/Spoons/ControlEscape.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
  self.sendEscape = false
  self.ctrlDownWithModifiers = false

  -- If `control` is held for this long, don't send `escape`
  local CANCEL_DELAY_SECONDS = 0.350
  self.controlKeyTimer = hs.timer.delayed.new(CANCEL_DELAY_SECONDS, function()
    self.sendEscape = false
  end)

  -- Create an eventtap to run each time the modifier keys change (i.e., each
  -- time a key like control, shift, option, or command is pressed or released)
  self.controlTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
    local modifiers = event:getFlags()

    -- only deal with control down key
    if modifiers["shift"] or modifiers["fn"] or modifiers["alt"] or modifiers["cmd"] then
      if self.sendEscape then
        self.sendEscape = false
        self.controlKeyTimer:stop()
      end
      if modifiers["ctrl"] then
        self.ctrlDownWithModifiers = true
      end
      return false
    end
    
    -- If the `control` key is held down then start the timer (other modifiers are not held down). 
    -- If the `control` key changes to the up state before the timer expires, then send `escape`.
    if modifiers["ctrl"] then 
      if not self.ctrlDownWithModifiers then
        self.sendEscape = true
        self.controlKeyTimer:start()
      end
    else
      if self.sendEscape then
        hs.eventtap.event.newKeyEvent("escape", true):post()
        hs.eventtap.event.newKeyEvent("escape", false):post()
        self.sendEscape = false
        self.controlKeyTimer:stop()
      end
      self.ctrlDownWithModifiers = false
    end
    return false
  end)

  -- Create an eventtap to run each time a normal key (i.e., a non-modifier key)
  -- enters the down state. We only want to send `escape` if `control` is
  -- pressed and released in isolation. If `control` is pressed in combination
  -- with any other key, we don't want to send `escape`.
  self.keyDownEventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    self.sendEscape = false
    return false
  end)
end

--- ControlEscape:start()
--- Method
--- Start sending `escape` when `control` is pressed and released in isolation
function obj:start()
  self.controlTap:start()
  self.keyDownEventTap:start()
end

--- ControlEscape:stop()
--- Method
--- Stop sending `escape` when `control` is pressed and released in isolation
function obj:stop()
  -- Stop monitoring keystrokes
  self.controlTap:stop()
  self.keyDownEventTap:stop()

  -- Reset state
  self.controlKeyTimer:stop()
  self.sendEscape = false
  self.lastModifiers = {}
end

return obj
