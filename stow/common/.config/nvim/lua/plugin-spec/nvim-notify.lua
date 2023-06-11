local started = false

local function get_message(...)
    local print_safe_args = {}

    for _, arg in ipairs({ ... }) do
        table.insert(print_safe_args, tostring(arg))
    end

    return table.concat(print_safe_args, " ")
end

local previous_msg

return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = function(msg, level, opts)
            if not started then
                require("notify").setup({
                    timeout = 1500,
                    render = "minimal",
                    stages = "static",
                })

                started = true
            end

            msg = vim.trim(msg)

            -- Debounce notifications
            if msg == previous_msg then
                return
            else
                previous_msg = msg
            end

            if msg ~= "" then
                local filename = vim.trim(vim.fn.expand("%:t"))

                if filename ~= "" then
                    filename = filename .. ": "
                end

                msg = " " .. filename .. msg

                require("notify")(msg, level, opts)
            end
        end

        _G.print = function(...)
            vim.notify(get_message(...), vim.log.levels.INFO)
        end

        _G.error = function(...)
            vim.notify(get_message(...), vim.log.levels.ERROR)
        end

        vim.print = _G.print
    end,
    version = "*",
    -- Don't load this lazily, it causes issues when opening files straight away
    -- that generate notifications
}
