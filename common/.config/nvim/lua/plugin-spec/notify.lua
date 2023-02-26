return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = function(msg, level, opts)
            msg = vim.trim(msg)

            if msg ~= "" then
                msg = " " .. vim.fn.expand("%:t") .. ": " .. msg
                require("notify")(msg, level, opts)
            end
        end

        require("notify").setup({
            timeout = 1500,
            render = "minimal",
            stages = "static",
        })

        vim.api.nvim_echo = function(chunks, _, _)
            for _, chunk in ipairs(chunks) do
                vim.notify(chunk[1])
            end
        end
    end,
    version = "*",
}
