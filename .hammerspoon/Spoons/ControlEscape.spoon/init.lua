--- ControlEscape 
---
--- Make the `control` handle control and escape
--- If the `control` key is tapped, treat it as the `escape` key. 
--- If the `control` key is held down and used in combination with another key, then provide the normal `control` key behavior.
--- based on https://github.com/jasonrudolph/ControlEscape.spoon

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

  -- Create an eventtap to run each time the modifier keys change (i.e. each
  -- time a key like shift, function, control, option, or command is pressed or released)
  self.controlTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
    local modifiers = event:getFlags()

    -- only deal with control key in isolation (i.e. no other modifiers are pressed or released)
    if modifiers["shift"] or modifiers["fn"] or modifiers["alt"] or modifiers["cmd"] then
      self.sendEscape = false
      if modifiers["ctrl"] then
        self.ctrlDownWithModifiers = true
      end
      return false
    end
    
    -- If the `control` key is pressed down in isolation, prime sendEscape
    -- if the `control` key is released in isolation, send an escape keyStroke
    if modifiers["ctrl"] then 
      if not self.ctrlDownWithModifiers then
        self.sendEscape = true
      end
    else
      if self.sendEscape then
        hs.eventtap.keyStroke({}, "escape", 0)
      end
      -- reset state
      self.sendEscape = false
      self.ctrlDownWithModifiers = false
    end
    return false
  end)

  -- Create an eventtap to run each time a normal key (i.e. a non-modifier key)
  -- enters the down state. We only want to send `escape` if `control` is pressed and released in isolation. 
  self.keyDownEventTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    -- reset state
    self.sendEscape = false
    self.ctrlDownWithModifiers = false
    return false
  end)
end

--- ControlEscape:start()
--- Start sending `escape` when `control` is pressed and released in isolation
function obj:start()
  -- reset state
  self.sendEscape = false
  self.ctrlDownWithModifiers = false
  self.controlTap:start()
  self.keyDownEventTap:start()
end

--- ControlEscape:stop()
--- Stop sending `escape` when `control` is pressed and released in isolation
function obj:stop()
  -- Stop monitoring keystrokes
  self.controlTap:stop()
  self.keyDownEventTap:stop()
  -- reset state
  self.sendEscape = false
  self.ctrlDownWithModifiers = false
end

return obj
