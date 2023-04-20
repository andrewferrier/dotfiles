local started = false

local function get_message(...)
    local print_safe_args = {}

    for _, arg in ipairs({ ... }) do
        table.insert(print_safe_args, tostring(arg))
    end

    return table.concat(print_safe_args, " ")
end

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

            if msg ~= "" then
                local filename = vim.trim(vim.fn.expand("%:t"))

                if filename ~= "" then
                    filename = filename .. ": "
                end

                msg = " " .. filename .. msg

                -- The schedule() seems to be needed to avoid errors with some
                -- vim.notify() calls, e.g. when debugprint doesn't have a
                -- filetype definition
                vim.schedule(function()
                    require("notify")(msg, level, opts)
                end)
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
    event = "VeryLazy",
}
