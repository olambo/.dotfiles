-- its a bit of a pain to reaload via the hammerspoon console. Uncomment this when adding new stuff
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

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

local chooserDict = {
    ["u"] = "com.googlecode.iterm2",
    ["p"] = "com.jetbrains.pycharm.ce",
    ["v"] = "com.microsoft.VSCode",
    ["s"] = "com.apple.Safari",
    ["l"] = "com.apple.Safari",
    ["b"] = "com.apple.Safari",
    ["m"] = "com.apple.mail",
    ["f"] = "com.apple.finder",
    ["n"] = "com.apple.Notes",
}

local function chooserApp(appChar)
    local app = chooserDict[appChar]
    -- print ('switch to ' .. appChar ..':'.. app)
    if (app == nil) then return end
    if (appChar ~= 'b') then hs.application.launchOrFocusByBundleID(app) end
    if appChar == 'b' then keyStroke({'shift', 'ctrl', '⌥', '⌘'}, 'b') end
    if appChar == 'l' then keyStroke({'⌥', '⌘'}, 'f') end
end

local function chooserChoice(localchoice)
  if not localchoice then chooser:selectedRow(1); return end
  chooser:selectedRow(1)
  chooserApp(localchoice["command"])
end

chooser = hs.chooser.new(chooserChoice)

chooser:choices({
  { ["text"] = "Unix-iterm", ["command"] = 'u'},
  { ["text"] = "Pycharm",    ["command"] = 'p'},
  { ["text"] = "Vscode",     ["command"] = 'v'},
  { ["text"] = "Safari",     ["command"] = 's'},
  { ["text"] = "Lookup-safari",    ["command"] = 'l'},
  { ["text"] = "Brave",      ["command"] = 'b'},
  { ["text"] = "Mail",       ["command"] = 'm'},
  { ["text"] = "Finder",     ["command"] = 'f'},
  { ["text"] = "Notes-term", ["command"] = 'n'},
})

local function queryChangedCallback(query)
  if query ~= '' then
     -- print("query " .. query)
     chooser:query('')
     chooser:selectedRow(1)
     chooser:cancel()
     chooserApp(query)
  end
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

hs.hotkey.bind({'ctrl'}, '9', iTerm2VsKeyCode({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', iTerm2VsKeyCode({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, ';', keyCodem({'command'}, 'tab'))
hs.hotkey.bind({'ctrl'}, 'j', keyCode('down'), nil, keyCode('down'))
hs.hotkey.bind({'ctrl'}, 'k', keyCode('up'), nil, keyCode('up'))
hs.hotkey.bind({'ctrl'}, 'l', keyCode('right'), nil, keyCode('right'))
hs.hotkey.bind({'ctrl'}, 'm', keyCodem({'shift', 'command'}, ']'), nil, keyCodem({'shift', 'command'}, ']'))
hs.hotkey.bind({'shift', 'ctrl'}, 'm', keyCodem({'shift', 'command'}, '['), nil, keyCodem({'shift', 'command'}, '['))
hs.hotkey.bind({'ctrl'}, 'return', expandContract())
hs.hotkey.bind({'ctrl'}, 'space', function() chooser:show() end)
