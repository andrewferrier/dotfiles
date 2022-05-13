-- luacheck: globals hs
local log = hs.logger.new("ajf-yabai", "debug")
log.i("Initializing ajf-yabai...")

local M = {}

-- Don't use 8 spaces, as that conflicts with Ctrl-Opt-Alt-8 used to invert
-- colors.
local NUMBER_OF_SPACES = 7

local YABAI_CMD = "/usr/local/bin/yabai"

local function get_number_of_spaces()
    local output, status = hs.execute(
        YABAI_CMD .. " -m query --spaces | /usr/local/bin/jq 'length'"
    )
    if status ~= true then
        -- This happens sometimes on OS startup
        log.e("Could not get number of spaces")
        return nil
    else
        return tonumber(output)
    end
end

M.init = function(SHIFT_PREFIX_ACTION, PREFIX_ACTION)
    local yabai_keys = {
        { PREFIX_ACTION, "down", "-m window --focus south" },
        { PREFIX_ACTION, "left", "-m window --focus west" },
        { PREFIX_ACTION, "right", "-m window --focus east" },
        { PREFIX_ACTION, "space", "-m window --toggle float" },
        { PREFIX_ACTION, "up", "-m window --focus north" },
        { SHIFT_PREFIX_ACTION, "R", "-m space --rotate 90" },
        { SHIFT_PREFIX_ACTION, "down", "-m window --swap south" },
        { SHIFT_PREFIX_ACTION, "left", "-m window --swap west" },
        { SHIFT_PREFIX_ACTION, "right", "-m window --swap east" },
        { SHIFT_PREFIX_ACTION, "up", "-m window --swap north" },
    }

    for i = 1, NUMBER_OF_SPACES, 1 do
        table.insert(yabai_keys, {
            PREFIX_ACTION,
            tostring(i),
            "-m space --focus " .. tostring(i),
        })

        table.insert(yabai_keys, {
            SHIFT_PREFIX_ACTION,
            tostring(i),
            "-m window --space " .. tostring(i),
        })
    end

    for _, obj in pairs(yabai_keys) do
        hs.hotkey.bind(obj[1], obj[2], function()
            hs.execute(YABAI_CMD .. " " .. obj[3])
        end)
    end

    local current_number_of_spaces = get_number_of_spaces()

    if current_number_of_spaces ~= nil then
        if current_number_of_spaces < NUMBER_OF_SPACES then
            local difference = NUMBER_OF_SPACES - current_number_of_spaces

            for _ = 1, difference, 1 do
                hs.execute(YABAI_CMD .. " -m space --create")
            end
        end

        if current_number_of_spaces > NUMBER_OF_SPACES then
            local difference = current_number_of_spaces - NUMBER_OF_SPACES

            for _ = 1, difference, 1 do
                hs.execute(YABAI_CMD .. " -m space --destroy")
            end
        end
    end
end

return M
