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
    ["g"] = "com.apple.Safari",
    ["m"] = "com.apple.mail",
    ["n"] = "com.apple.Notes",
    ["p"] = "com.jetbrains.pycharm.ce",
    ["s"] = "com.apple.Safari",
    ["u"] = "com.googlecode.iterm2",
    ["v"] = "com.microsoft.VSCode",
}

local function chooserApp(appChar)
    local app = chooserAppDict[appChar]
    -- print ('switch to ' .. appChar ..':'.. app)
    if (app == nil) then return end
    if (appChar ~= 'g') then hs.application.launchOrFocusByBundleID(app) end
    if appChar == 'g' then keyStroke({'shift', 'ctrl', '⌥', '⌘'}, 'g') end
end

-- a row has been selected. Process the command. The chooser will be auto closed
local function chooserChoice(localchoice)
  if not localchoice then chooser:selectedRow(1); return end
  chooser:selectedRow(1)
  chooserApp(localchoice["command"])
end

chooser = hs.chooser.new(chooserChoice)
chooser:rows(1)
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

local function iTerm2VsKeyCode(l1, l2, r1, r2)
  return function()
   capp = hs.application.frontmostApplication():bundleID()
   if capp == 'com.googlecode.iterm2' or capp == 'com.microsoft.VSCode' or capp == 'dev.zed.Zed' or capp == 'com.jetbrains.pycharm.ce' then
     keyStroke(l1, l2)
   else
     keyStroke(r1, r2)
   end
 end
end

local function expandContract()
  return function()
   local capp = hs.application.frontmostApplication():bundleID()
   if capp == 'PyCharm' then
     keyStroke({'shift', '⌘'}, 'f12')
   elseif capp == 'iTerm2' then
     keyStroke({'shift', '⌘'}, 'return') 
   else
     keyStroke({'⌘'}, 'b') 
   end
 end
end

local function doChoose(typ)
  return function()
    if typ == 1 and chooser:rows() ~= 2 then
      chooser:rows(2)
      chooser:choices({
        { ["text"] = "F3 for list",      ["command"] = 'b'},
      })
    elseif typ ~= 1 and chooser:rows() == 2 then
       chooser:rows(9)
       chooser:choices({
         { ["text"] = "Books",      ["command"] = 'b'},
         { ["text"] = "Finder",     ["command"] = 'f'},
         { ["text"] = "Google",     ["command"] = 'g'},
         { ["text"] = "Mail",       ["command"] = 'm'},
         { ["text"] = "Notes",      ["command"] = 'n'},
         { ["text"] = "Pycharm",    ["command"] = 'p'},
         { ["text"] = "Safari",     ["command"] = 's'},
         { ["text"] = "Unix-iterm", ["command"] = 'u'},
         { ["text"] = "Vscode",     ["command"] = 'v'},
       })
    end
    chooser:show({0,0})
 end
end

hs.hotkey.bind({'ctrl'}, '9', iTerm2VsKeyCode({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', iTerm2VsKeyCode({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, 'j', keyCode('down'), nil, keyCode('down'))
hs.hotkey.bind({'ctrl'}, 'k', keyCode('up'), nil, keyCode('up'))
hs.hotkey.bind({'ctrl'}, 'l', keyCode('right'), nil, keyCode('right'))
hs.hotkey.bind({'ctrl'}, ';', keyCodem({'command'}, 'tab'))
hs.hotkey.bind({'ctrl'}, 'h', keyCodem({'shift'}, 'left'), nil, keyCodem({'shift'}, 'left'))
hs.hotkey.bind({'ctrl'}, 'a', keyCodem({'shift', '⌥'}, 'left'), nil, keyCodem({'shift', '⌥'}, 'left'))
hs.hotkey.bind({'ctrl'}, 'm', keyCodem({'shift', 'command'}, ']'), nil, keyCodem({'shift', 'command'}, ']'))
hs.hotkey.bind({'shift', 'ctrl'}, 'm', keyCodem({'shift', 'command'}, '['), nil, keyCodem({'shift', 'command'}, '['))
hs.hotkey.bind({'ctrl'}, 'return', expandContract())
hs.hotkey.bind({'ctrl'}, 'space', doChoose(1))
hs.hotkey.bind({}, 'f3', doChoose(2))
