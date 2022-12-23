vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("file-list.lua", {}),
    callback = function(event)
        vim.fn.jobstart(
            { "fasd", "-A", event.file },
            { detach = true, on_stderr = require("utils").job_stderr }
        )
    end,
})
