-- TODO:
-- * Investigate using https://github.com/koekeishiya/skhd as an alternative to Hammerspoon.

local log = hs.logger.new("ajf", "debug")

local SHIFT_PREFIX_ACTION = { "ctrl", "cmd", "alt", "shift" }
local PREFIX_ACTION = { "ctrl", "cmd", "alt" }

local HOME = os.getenv("HOME")
local HOMEBREW_BIN = '/opt/homebrew/bin'

require("run-on-resume").init()
require("window-management").init(PREFIX_ACTION, SHIFT_PREFIX_ACTION)

hs.dockicon.hide()

for _, v in ipairs(hs.audiodevice.allOutputDevices()) do
    v:setOutputMuted(true)
    v:setOutputVolume(0)
end

local function check_bluetooth_result(rc, stdout, stderr)
    if rc ~= 0 then
        log.e(
            string.format(
                "Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s",
                rc,
                stderr,
                stdout
            )
        )
    end
end

local t = hs.task.new(
    HOMEBREW_BIN .. "/blueutil",
    check_bluetooth_result,
    { "--power", "on" }
)

t:start()

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

hs.hotkey.bind(PREFIX_ACTION, "M", function()
    open_terminal(HOMEBREW_BIN .. "/vimpc")
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

-- Enable hot corners by default
hs.execute("$HOME/.local/bin/macos/hot-corners -e")

hs.hotkey.bind(PREFIX_ACTION, "U", function()
    hs.osascript.applescript([[tell application "System Events"
    tell process "Webex Meetings"
    set muteMeItem to a reference to menu item "Mute Me" of menu "Participant" of menu bar 1
    if muteMeItem's enabled is false then
        click menu item "Unmute Me" of menu "Participant" of menu bar 1
        display notification "Unmuted" with title "WebEx"
    else
        click menu item "Mute Me" of menu "Participant" of menu bar 1
        display notification "Muted" with title "WebEx"
    end if
    end tell
end tell]])
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

launch_or_find("A", "/System/Applications/Mail.app")
launch_or_find("C", "/System/Applications/Calendar.app")
launch_or_find("K", "/Applications/KeePassXC.app/")
launch_or_find("L", "/Applications/Slack.app")
launch_or_find("R", "/Applications/Remember The Milk.app")

launch("B", "/Applications/Firefox.app")

web_search("S", "DuckDuckGo Search:", "https://duckduckgo.com/?q=")

hs.urlevent.bind("vimpc", function(eventName, params)
    open_terminal(HOMEBREW_BIN .. "/vimpc")
end)

hs.alert.show("Hammerspoon loaded")
