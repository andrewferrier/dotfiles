-- luacheck: ignore
local module = {}

-- From https://github.com/asmagill/hs._asm.spaces
local spaces = require("hs.spaces")

spaces.setDefaultMCwaitTime(0.5)

local function moveWindowToSpace(space)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local spaceID = hs.spaces.spacesForScreen(screen)[space]
    spaces.moveWindowToSpace(win:id(), spaceID)
    hs.alert.show(win:title() .. " moved to Desktop " .. space)
end

module.init = function(prefixAction, prefixShiftAction)
    hs.hotkey.bind(prefixAction, "[", function()
        hs.window.frontmostWindow():moveOneScreenWest(nil, true)
    end)

    hs.hotkey.bind(prefixAction, "]", function()
        hs.window.frontmostWindow():moveOneScreenEast(nil, true)
    end)

    -- Stop at 7 because Ctrl-Option-Cmd-8 inverts colors

    hs.hotkey.bind(prefixShiftAction, "1", function()
        moveWindowToSpace(1)
    end)
    hs.hotkey.bind(prefixShiftAction, "2", function()
        moveWindowToSpace(2)
    end)
    hs.hotkey.bind(prefixShiftAction, "3", function()
        moveWindowToSpace(3)
    end)
    hs.hotkey.bind(prefixShiftAction, "4", function()
        moveWindowToSpace(4)
    end)
    hs.hotkey.bind(prefixShiftAction, "5", function()
        moveWindowToSpace(5)
    end)
    hs.hotkey.bind(prefixShiftAction, "6", function()
        moveWindowToSpace(6)
    end)
    hs.hotkey.bind(prefixShiftAction, "7", function()
        moveWindowToSpace(7)
    end)
end

return module
