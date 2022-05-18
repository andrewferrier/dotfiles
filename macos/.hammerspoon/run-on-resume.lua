-- luacheck: globals hs

local log = hs.logger.new("run-on-resume", "debug")

log.i("Initializing...")

local M = {}

local function f(event)
    if event == hs.caffeinate.watcher.screensDidWake then
        log.i("Awoken")
        log.i("Running day-night-update")
        hs.execute("/Users/ferriera/.local/bin/common-dotfiles/day-night-update")
        log.i("day-night-update complete")
    end
end

M.init = function()
    local watcher = hs.caffeinate.watcher.new(f)
    watcher:start()
end

return M
