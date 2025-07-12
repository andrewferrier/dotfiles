vim.api.nvim_create_autocmd({ "BufReadPre", "BufWritePost" }, {
    callback = function(event)
        vim.system(
            { "/home/ferriera/memy/target/debug/memy", "--note", event.file },
            { detach = true },
            require("utils").system_on_exit
        )
    end,
})
