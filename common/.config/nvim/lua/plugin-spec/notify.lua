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
    end,
    version = "*"
}
