-- luacheck: globals hs

local log = hs.logger.new("power", "debug")

log.i("Initializing...")

local M = {}

local function batt_wrapper_changed()
    local percentage = hs.battery.percentage()
    local isCharging = hs.battery.isCharging()

    if percentage < 20 and not isCharging then
        hs.alert.show("Battery is low and is not charging.")
        log.i("Battery is low and is not charging.")
    else
        log.i("Battery has enough power and/or is charging.")
    end

    log.i("Battery percentage: " .. tostring(percentage))
    log.i("Battery charging: " .. tostring(isCharging))
end

M.init = function()
    batt_wrapper_changed()

    hs.battery.watcher.new(batt_wrapper_changed):start()
end

return M
