vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    group = vim.api.nvim_create_augroup("file-list.lua", {}),
    callback = function(event)
        vim.system(
            { "fasd", "-A", event.file },
            { detach = true },
            require("utils").system_on_exit
        )
    end,
})
