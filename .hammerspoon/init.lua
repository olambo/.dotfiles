-- ============================
-- Hammerspoon Init
-- ============================

-- Load modules
-- ----------------------------

-- Handles custom key shortcuts and application chooser
require("shortcuts")

-- Handles window positioning, resizing, and movement
require("window")

-- Optional: Control-Escape behavior (commented out here)
-- This was previously done via Karabiner-Elements
-- hs.loadSpoon("ControlEscape"):start()

-- ============================
-- End of init.lua
-- ============================

-- Notes:
-- - init.lua just loads your two modules; all functionality lives in shortcuts.lua and window.lua
-- - Keeping modules separate keeps the config modular and maintainable
-- - Reloading Hammerspoon will automatically load these files

