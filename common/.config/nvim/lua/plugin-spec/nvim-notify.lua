local started = false

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

                require("notify")(msg, level, opts)
            end
        end
    end,
    version = "*",
    event = "VeryLazy",
}
