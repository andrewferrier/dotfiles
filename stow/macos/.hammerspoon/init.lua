-- TODO:
-- * Investigate using https://github.com/koekeishiya/skhd as an alternative to Hammerspoon.

local log = hs.logger.new("ajf", "debug")

local SHIFT_PREFIX_ACTION = { "ctrl", "cmd", "alt", "shift" }
local PREFIX_ACTION = { "ctrl", "cmd", "alt" }

local HOME = os.getenv("HOME")
local HOMEBREW_BIN = "/opt/homebrew/bin"

require("window-management").init(PREFIX_ACTION, SHIFT_PREFIX_ACTION)

hs.dockicon.hide()

local function caffeinate_watcher(event)
    if event == hs.caffeinate.watcher.screensDidWake then
        log.i("Awoken")
        log.i("Running day-night-update")
        hs.execute(HOME .. "/.local/bin/common-dotfiles/day-night-update")
        log.i("day-night-update complete")
    end
end

hs.caffeinate.watcher.new(caffeinate_watcher):start()

-- Action keys

local function web_search(key, message, url)
    hs.hotkey.bind(PREFIX_ACTION, key, function()
        hs.focus()
        local button, query =
            hs.dialog.textPrompt(message, "", "", "OK", "Cancel")
        if button == "OK" then
            query = hs.http.encodeForQuery(query)
            local finalUrl = url .. query
            hs.urlevent.openURL(finalUrl)
        end
    end)
end

local function launch(key, app_path)
    hs.hotkey.bind(PREFIX_ACTION, key, function()
        -- See
        -- https://arunvelsriram.dev/preventing-firefox-from-entering-safe-mode
        hs.execute("MOZ_DISABLE_SAFE_MODE_KEY=1 open --new " .. app_path)
    end)
end

local function launch_or_find(key, app_path)
    hs.hotkey.bind(PREFIX_ACTION, key, function()
        hs.application.launchOrFocus(app_path)
    end)
end

local function open_terminal(command)
    if command ~= nil then
        -- Note that the arguments will be ignored if kitty is not already running.
        -- Most of the time we don't expect this to be the case, because
        -- macos_quit_when_last_window_closed is not set in kitty's config, but it's
        -- possible.
        hs.execute("open -nF /Applications/kitty.app " .. " --args " .. command)
    else
        hs.execute("open -nF /Applications/kitty.app")
    end
end

local function open_bash_terminal(command)
    open_terminal("bash --login -c '" .. command .. "'")
end

hs.hotkey.bind(PREFIX_ACTION, "Return", function()
    open_terminal()
end)

hs.hotkey.bind(PREFIX_ACTION, "V", function()
    open_bash_terminal(HOMEBREW_BIN .. "/nvim")
end)

hs.hotkey.bind(PREFIX_ACTION, "F", function()
    open_terminal(HOME .. "/.local/bin/common/file-list-find-and-open -f")
end)

hs.hotkey.bind(PREFIX_ACTION, "G", function()
    open_terminal(HOME .. "/.local/bin/common/file-list-find-and-open -d")
end)

hs.hotkey.bind(PREFIX_ACTION, "O", function()
    open_bash_terminal(HOME .. "/bookmarks/bin/bookmark-select-and-open")
end)

hs.hotkey.bind(PREFIX_ACTION, "'", function()
    -- Pseudo-"paste" for webforms that don't allow passwords
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.hotkey.bind(PREFIX_ACTION, ",", function()
    hs.eventtap.keyStrokes("andrew@andrewferrier.com")
end)

hs.hotkey.bind(PREFIX_ACTION, ".", function()
    hs.eventtap.keyStrokes("andrew.ferrier@gmail.com")
end)

launch_or_find("C", "/System/Applications/Calendar.app")
launch_or_find("K", "/Applications/KeePassXC.app/")

launch("B", "/Applications/LibreWolf.app")

web_search("S", "DuckDuckGo Search:", "https://duckduckgo.com/?q=")

hs.alert.show("Hammerspoon loaded")
