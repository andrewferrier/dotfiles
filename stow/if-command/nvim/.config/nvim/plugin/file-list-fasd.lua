vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    callback = function(event)
        vim.system(
            { "fasd", "-A", event.file },
            { detach = true },
            require("utils").system_on_exit
        )
    end,
})
