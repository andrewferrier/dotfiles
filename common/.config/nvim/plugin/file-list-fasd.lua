vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("file-list.lua", {}),
    callback = function()
        local file = vim.fn.expand("%:p")
        vim.fn.jobstart(
            { "fasd", "-A", file },
            { detach = true, on_stderr = require("utils").job_stderr }
        )
    end,
})
