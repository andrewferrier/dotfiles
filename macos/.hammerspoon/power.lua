-- luacheck: globals hs
local log = hs.logger.new("ajf-power", "debug")
log.i("Initializing ajf-power...")

local M = {}

local function batt_wrapper_changed()
    if hs.battery.percentage() < 20 and not hs.battery.isCharging() then
        hs.alert.show("Battery is low and is not charging.")
        log.i("Battery is low and is not charging.")
    else
        log.i("Battery is fine.")
    end

    log.i("Battery percentage: " .. tostring(hs.battery.percentage()))
    log.i("Battery charging: " .. tostring(hs.battery.isCharging()))
end

M.init = function()
    batt_wrapper_changed()

    hs.battery.watcher.new(batt_wrapper_changed):start()
end

return M
