-- Based on https://github.com/wincent/wincent/blob/master/aspects/dotfiles/files/.hammerspoon/init.lua
local module = {}

-- From https://github.com/asmagill/hs._asm.undocumented.spaces
local spaces = require("hs._asm.undocumented.spaces")

hs.grid.setGrid("12x12") -- allows us to place on quarters, thirds and halves
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.window.animationDuration = 0 -- disable animations

local grid = {
    topHalf = "0,0 12x6",
    rightTwoThirds = "4,0 8x12",
    rightThird = "8,0 4x12",
    rightHalf = "6,0 6x12",
    bottomHalf = "0,6 12x6",
    leftTwoThirds = "0,0 8x12",
    leftThird = "0,0 4x12",
    leftHalf = "0,0 6x12",
    topLeft = "0,0 6x6",
    topRight = "6,0 6x6",
    bottomRight = "6,6 6x6",
    bottomLeft = "0,6 6x6",
    fullScreen = "0,0 12x12",
}

local chain = function(movements)
    local chainResetInterval = 2 -- seconds
    local cycleLength = #movements
    local sequenceNumber = 1

    return function()
        local win = hs.window.frontmostWindow()
        local id = win:id()
        local now = hs.timer.secondsSinceEpoch()
        local screen = win:screen()

        if
            LastSeenChain ~= movements
            or LastSeenAt < now - chainResetInterval
            or LastSeenWindow ~= id
        then
            sequenceNumber = 1
            LastSeenChain = movements
        elseif sequenceNumber == 1 then
            -- At end of chain, restart chain on next screen.
            screen = screen:next()
        end

        LastSeenAt = now
        LastSeenWindow = id

        hs.grid.set(win, movements[sequenceNumber], screen)
        sequenceNumber = sequenceNumber % cycleLength + 1
    end
end

local function moveToSpace(space)
    local win = hs.window.focusedWindow()
    local uuid = win:screen():spacesUUID()
    local spaceID = spaces.layout()[uuid][space]
    spaces.changeToSpace(spaceID)
    hs.alert.show("Desktop " .. space)
end

local function moveWindowToSpace(space)
    local win = hs.window.focusedWindow()
    local uuid = win:screen():spacesUUID()
    local spaceID = spaces.layout()[uuid][space]
    spaces.moveWindowToSpace(win:id(), spaceID)
    hs.alert.show(win:title() .. " moved to Desktop " .. space)
end

module.init = function(prefixAction, prefixShiftAction)
    hs.hotkey.bind(
        prefixAction,
        "up",
        chain({ grid.topHalf, grid.topLeft, grid.topRight })
    )

    hs.hotkey.bind(
        prefixAction,
        "down",
        chain({ grid.bottomHalf, grid.bottomLeft, grid.bottomRight })
    )

    hs.hotkey.bind(
        prefixAction,
        "right",
        chain({ grid.rightTwoThirds, grid.rightHalf, grid.rightThird, grid.topRight, grid.bottomRight })
    )

    hs.hotkey.bind(
        prefixAction,
        "left",
        chain({ grid.leftTwoThirds, grid.leftHalf, grid.leftThird, grid.topLeft, grid.bottomLeft })
    )

    hs.hotkey.bind(prefixAction, "=", chain({ grid.fullScreen }))

    hs.hotkey.bind(prefixAction, "[", function()
        hs.window.frontmostWindow():moveOneScreenWest(nil, true)
    end)

    hs.hotkey.bind(prefixAction, "]", function()
        hs.window.frontmostWindow():moveOneScreenEast(nil, true)
    end)

    -- Stop at 7 because Ctrl-Option-Cmd-8 inverts colors

    hs.hotkey.bind(prefixAction, "1", function()
        moveToSpace(1)
    end)
    hs.hotkey.bind(prefixAction, "2", function()
        moveToSpace(2)
    end)
    hs.hotkey.bind(prefixAction, "3", function()
        moveToSpace(3)
    end)
    hs.hotkey.bind(prefixAction, "4", function()
        moveToSpace(4)
    end)
    hs.hotkey.bind(prefixAction, "5", function()
        moveToSpace(5)
    end)
    hs.hotkey.bind(prefixAction, "6", function()
        moveToSpace(6)
    end)
    hs.hotkey.bind(prefixAction, "7", function()
        moveToSpace(7)
    end)

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
