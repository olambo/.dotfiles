-- ============================
-- Hammerspoon Shortcuts Module
-- ============================

hs.alert.show("Hammerspoon config loaded") -- optional startup alert

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

    -- Build lookup set of common app bundle IDs
    for _, bundleID in pairs(apps) do
        commonAppBundles[bundleID] = true
    end

    local allRunningApps = hs.application.runningApplications()
    -- print("==== Checking running GUI apps (excluding common) ====")

    for _, app in ipairs(allRunningApps) do
        if app and type(app) == "userdata" and app:kind() == 1 then
            local name = app:name() or "(no name)"
            local bundleID = app:bundleID() or "(no bundle)"

            -- Only include proper GUI apps, not in the common list
            if bundleID ~= "(no bundle)" and not commonAppBundles[bundleID] then
                -- print(string.format("App: %s | Bundle: %s", name, bundleID))

                table.insert(runningApps, {
                    text = name,
                    subText = bundleID,
                    app = app
                })
            end
        end
    end

    table.sort(runningApps, function(a, b) return a.text < b.text end)
    -- print("==== End app list, total " .. #runningApps .. " ====")

    if #runningApps == 0 then
        runningApps = {{text = "No other running GUI apps found", app = nil}}
    end

    local runningChooser = hs.chooser.new(function(choice)
        if choice and choice.app then
            choice.app:activate()
        end
    end)

    runningChooser:choices(runningApps)
    runningChooser:rows(math.min(#runningApps, 12))
    runningChooser:width(40)
    runningChooser:show()
end

-- We need to declare showChooser first so it's visible to the chooser callback
local showChooser

-- ============================
-- Main Application Chooser
-- ============================

-- Full chooser rows, with special commands at the top
local chooserRows = {
    {text="full menu", command='full_menu'},
    {text="Jump other apps", command='j'},
    {text="Books", command='b'},
    {text="Finder", command='f'},
    {text="Google", command='g'},
    {text="Mail", command='m'},
    {text="Notes", command='n'},
    {text="Ide VSCode", command='i'},
    {text="Obsidian", command='o'},
    {text="PyCharm", command='p'},
    {text="Safari", command='s'},
    {text="Unix-term", command='u'},
}

-- Create chooser object
local chooser = hs.chooser.new(function(choice)
    if choice and choice.command then
        if choice.command == 'full_menu' then
            showChooser(2)
        elseif choice.command == 'j' then
            showRunningApps()
        else
            launchApp(choice.command)
        end
    end
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
    elseif query ~= "" and apps[query] then
        -- Any other single character = launch corresponding app
        chooser:query('')
        chooser:cancel()
        launchApp(query)
    end
end)

-- Now we can safely define showChooser after the chooser object
showChooser = function(type)
    if type == 1 then
        chooser:rows(2)
        -- The command names now match the callback's checks
        chooser:choices({
            {text="full menu", command='full_menu'},
            {text="Jump other apps", command='j'}
        })
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
hs.hotkey.bind({'ctrl'}, 'space', function() showChooser(1) end) -- mini menu

-- ============================
-- End of shortcuts.lua
-- ============================
