-- its a bit of a pain to reaload via the hammerspoon console. Uncomment this when adding new stuff
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
--   hs.reload()
-- end)
hs.alert.show("Hammerspoon config loaded")

-- key events
--
local function keyStroke(modifiers, key)
    hs.eventtap.keyStroke(modifiers, key, 0)
end

local function keyCodem(modifiers, key)
  return function() hs.eventtap.keyStroke(modifiers, key, 0) end
end

local function keyCode(key)
  -- use newKeyEvent to get down and up working in chooser. note I'm not adding empty modifiers for the first event
  return function()
    hs.eventtap.event.newKeyEvent(key, true):post()
    hs.eventtap.event.newKeyEvent({}, key, false):post()
  end
end

-- chooser stuff
--
local chooser

chooserAppDict = {
    ["b"] = "com.apple.iBooksX",
    ["f"] = "com.apple.finder",
    ["i"] = "com.microsoft.VSCode",
    ["m"] = "com.apple.mail",
    ["n"] = "com.apple.Notes",
    ["o"] = "com.jetbrains.pycharm",
    ["s"] = "com.apple.Safari",
    ["u"] = "dev.warp.Warp-Stable",
    ["z"] = "com.jetbrains.pycharm.ce",
}

local function chooserApp(appChar)
    local app = chooserAppDict[appChar]
    -- print ('switch to ' .. appChar ..':'.. app)
    if (app == nil) then return end
    hs.application.launchOrFocusByBundleID(app) 
end

-- a row has been selected. Process the command. The chooser will be auto closed
local function chooserChoice(localchoice)
  if not localchoice then chooser:selectedRow(1); return end
  chooser:selectedRow(1)
  chooserApp(localchoice["command"])
end

chooser = hs.chooser.new(chooserChoice)
chooser:rows(3)
chooser:width(20)

-- query will be the character that was typed. Want to close the chooser and process the single queryChar
local function queryChangedCallback(queryChar)
  if queryChar == '' then return end
  chooser:query('')
  chooser:selectedRow(1)
  chooser:cancel()
  chooserApp(queryChar)
end
chooser:queryChangedCallback(queryChangedCallback)

local function vimLikeKeyCode(l1, l2, r1, r2)
  return function()
   capp = hs.application.frontmostApplication():bundleID()
   if capp == 'com.googlecode.iterm2' or capp == 'com.microsoft.VSCode' or capp == 'dev.zed.Zed' or capp == 'com.jetbrains.pycharm' or capp == 'com.jetbrains.pycharm.ce' or capp == 'dev.warp.Warp-Stable' then
     keyStroke(l1, l2)
   else
     keyStroke(r1, r2)
   end
 end
end

local function expandContract()
  return function()
   -- local capp = hs.application.frontmostApplication():bundleID()
   -- print ('app  '  ..':'.. capp)
   --if capp == 'iTerm2' or capp == 'dev.warp.Warp-Stable' then
     -- this wont work, binding return with modifier to return with different modifiers, hammerspoon doesnt support this easily
     -- keyStroke({'shift', '⌘'}, 'return') 
   --else
     keyStroke({'shift', '⌘'}, 'f12')
   --end
 end
end

local function doChoose(typ)
  return function()
    if typ == 1 and chooser:rows() >= 3 then
      chooser:rows(1)
      chooser:choices({
        { ["text"] = "F3 for list",      ["command"] = 'b'},
      })
    elseif typ ~= 1 and chooser:rows() <= 3 then
       chooser:rows(9)
       chooser:choices({
         { ["text"] = "Books",      ["command"] = 'b'},
         { ["text"] = "Finder",     ["command"] = 'f'},
         { ["text"] = "Google",     ["command"] = 'g'},
         { ["text"] = "Mail",       ["command"] = 'm'},
         { ["text"] = "Notes",      ["command"] = 'n'},
         { ["text"] = "Ide Pycharm",    ["command"] = 'i'},
         { ["text"] = "Safari",     ["command"] = 's'},
         { ["text"] = "Unix-term",  ["command"] = 'u'},
         { ["text"] = "Vscode",     ["command"] = 'v'},
       })
    end
    chooser:show({0,0})
 end
end

hs.hotkey.bind({'ctrl'}, '9', vimLikeKeyCode({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', vimLikeKeyCode({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, ';', keyCodem({'command'}, 'tab'))
hs.hotkey.bind({'ctrl'}, 'm', keyCodem({'shift', 'command'}, ']'), nil, keyCodem({'shift', 'command'}, ']'))
hs.hotkey.bind({'shift', 'ctrl'}, 'm', keyCodem({'shift', 'command'}, '['), nil, keyCodem({'shift', 'command'}, '['))
hs.hotkey.bind({'ctrl'}, 'return', keyCodem({'shift', '⌘'}, 'f12'))
hs.hotkey.bind({'ctrl'}, 'space', doChoose(1))
hs.hotkey.bind({}, 'f3', doChoose(2))
