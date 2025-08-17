-- ============================
-- Hammerspoon Shortcuts Module
-- ============================

hs.alert.show("Hammerspoon config loaded")  -- optional startup alert

-- ============================
-- Helper functions for key events
-- ============================

local function keyStroke(mods, key)
    hs.eventtap.keyStroke(mods, key, 0)
end

local function keyCodem(mods, key)
    return function() keyStroke(mods, key) end
end

local function keyCodeFn(key)
    return function()
        hs.eventtap.event.newKeyEvent(key, true):post()
        hs.eventtap.event.newKeyEvent({}, key, false):post()
    end
end

-- ============================
-- Application Launcher / Chooser Setup
-- ============================

-- Maps a letter key to an application bundle ID
local apps = {
    b = "com.apple.iBooksX",
    f = "com.apple.finder",
    i = "com.microsoft.VSCode",
    m = "com.apple.mail",
    n = "com.apple.Notes",
    o = "md.obsidian",
    p = "com.jetbrains.pycharm",
    s = "com.apple.Safari",
    u = "dev.warp.Warp-Stable",
    z = "com.jetbrains.pycharm.ce",
}

-- Launch or focus app by letter
local function launchApp(char)
    local app = apps[char]
    if app then hs.application.launchOrFocusByBundleID(app) end
end

-- ============================
-- Running Apps Switcher
-- Shows running apps that AREN'T in your common apps list
-- Triggered by ctrl-space + j
-- ============================

local function showRunningApps()
    local runningApps = {}
    local commonAppBundles = {}
    
    -- Build set of common app bundle IDs for quick lookup
    -- This prevents duplicating apps you can already access via single letters
    for _, bundleID in pairs(apps) do
        commonAppBundles[bundleID] = true
    end
    
    -- Get all running apps, excluding common ones
    for _, app in pairs(hs.application.runningApplications()) do
        local title = app:title()
        local bundleID = app:bundleID()
        
        -- Only show apps that have a title, aren't hidden, and aren't in your common apps
        if title ~= "" and not app:isHidden() and not commonAppBundles[bundleID] then
            table.insert(runningApps, {
                text = title,
                app = app
            })
        end
    end
    
    -- Sort alphabetically for easier browsing
    table.sort(runningApps, function(a, b) return a.text < b.text end)
    
    -- Create and show chooser
    local runningChooser = hs.chooser.new(function(choice)
        if choice and choice.app then 
            choice.app:activate() 
        end
    end)
    
    runningChooser:choices(runningApps)
    runningChooser:rows(math.min(#runningApps, 10))  -- max 10 rows, adjust as needed
    runningChooser:width(25)
    runningChooser:show()
end

-- ============================
-- Main Application Chooser
-- ============================

-- Full chooser rows
local chooserRows = {
    {text="Books", command='b'},
    {text="Finder", command='f'},
    {text="Google", command='g'},
    {text="Mail", command='m'},
    {text="Notes", command='n'},
    {text="VSCode", command='i'},
    {text="Obsidian", command='o'},
    {text="PyCharm", command='p'},
    {text="Safari", command='s'},
    {text="Unix-term", command='u'},
}

-- Create chooser object
local chooser = hs.chooser.new(function(choice)
    if choice then launchApp(choice.command) end
end)

chooser:rows(3)
chooser:width(20)

-- Query changed callback for single-character launch and special commands
chooser:queryChangedCallback(function(query)
    if query == "j" then
        -- 'j' = show running apps (excluding common apps)
        chooser:query('')
        chooser:cancel()
        showRunningApps()
    elseif query ~= "" then
        -- Any other single character = launch corresponding app
        chooser:query('')
        chooser:cancel()
        launchApp(query)
    end
end)

-- Show chooser: type 1 = mini, else full
local function showChooser(type)
    if type == 1 then
        chooser:rows(1)
        chooser:choices({{text="F3 for list, 'j' for running apps", command='b'}})
    else
        chooser:rows(#chooserRows)
        chooser:choices(chooserRows)
    end
    chooser:show({0,0})
end

-- ============================
-- Vim-like key behavior
-- ============================

-- Apps where "vim-like" key behavior applies
local vimApps = {
    ["com.googlecode.iterm2"]=true,
    ["com.microsoft.VSCode"]=true,
    ["dev.zed.Zed"]=true,
    ["com.jetbrains.pycharm"]=true,
    ["com.jetbrains.pycharm.ce"]=true,
    ["dev.warp.Warp-Stable"]=true,
    ["md.obsidian"]=true,
}

-- vimLike: returns a function to send keys differently depending on app
local function vimLike(lMods, lKey, rMods, rKey)
    return function()
        local app = hs.application.frontmostApplication():bundleID()
        keyStroke(vimApps[app] and lMods or rMods, vimApps[app] and lKey or rKey)
    end
end

-- ============================
-- Hotkey Bindings
-- ============================

hs.hotkey.bind({'ctrl'}, '9', vimLike({}, 'home', {'ctrl'}, 'a'))
hs.hotkey.bind({'ctrl'}, '0', vimLike({}, 'end', {'ctrl'}, 'e'))
hs.hotkey.bind({'ctrl'}, ';', keyCodem({'cmd'}, 'tab'))
hs.hotkey.bind({'ctrl'}, 'm', keyCodem({'shift', 'cmd'}, ']'), nil, keyCodem({'shift', 'cmd'}, ']'))
hs.hotkey.bind({'shift', 'ctrl'}, 'm', keyCodem({'shift', 'cmd'}, '['), nil, keyCodem({'shift', 'cmd'}, '['))
hs.hotkey.bind({'ctrl'}, 'return', keyCodem({'shift','cmd'}, 'f12'))

-- Show chooser hotkeys
hs.hotkey.bind({'ctrl'}, 'space', function() showChooser(1) end)  -- mini menu
hs.hotkey.bind({}, 'f3', function() showChooser(2) end)           -- full menu

-- ============================
-- End of shortcuts.lua
-- ============================
