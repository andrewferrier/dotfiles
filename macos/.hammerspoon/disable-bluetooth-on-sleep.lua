-- luacheck: globals hs

-- Based on https://gist.github.com/ysimonson/fea48ee8a68ed2cbac12473e87134f58

local log = hs.logger.new("disable-bluetooth-on-sleep", "debug")

log.i("Initializing...")

local M = {}

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

local function bluetooth(power)
    log.i("Setting bluetooth to " .. power)

    local t = hs.task.new(
        "/usr/local/bin/blueutil",
        check_bluetooth_result,
        { "--power", power }
    )

    t:start()
end

local function on_caffeinate_event(event)
    if event == hs.caffeinate.watcher.systemWillSleep then
        log.i("Sleeping, turning off Bluetooth...")
        bluetooth("off")
    elseif event == hs.caffeinate.watcher.screensDidWake then
        log.i("Awoken, turning on Bluetooth...")
        bluetooth("on")
    end
end

M.init = function()
    local watcher = hs.caffeinate.watcher.new(on_caffeinate_event)
    watcher:start()
end

return M
