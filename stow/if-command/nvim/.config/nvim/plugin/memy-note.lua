vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    callback = function(event)
        local file = event.file

        if file:sub(1, 6) == "oil://" then
            file = file:sub(7)
        end

        vim.system(
            { "memy", "note", file },
            { detach = true },
            require("utils").system_on_exit
        )
    end,
})
