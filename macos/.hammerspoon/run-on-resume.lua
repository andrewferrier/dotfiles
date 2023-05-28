local log = hs.logger.new("run-on-resume", "debug")

log.i("Initializing...")

local M = {}

local HOME = os.getenv("HOME")

local function f(event)
    if event == hs.caffeinate.watcher.screensDidWake then
        log.i("Awoken")
        log.i("Running day-night-update")
        hs.execute(HOME .. "/.local/bin/common-dotfiles/day-night-update")
        log.i("day-night-update complete")
    end
end

M.init = function()
    local watcher = hs.caffeinate.watcher.new(f)
    watcher:start()
end

return M
