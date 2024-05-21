vim.opt.path:remove("/usr/include")

vim.api.nvim_create_autocmd({ "BufNew", "BufRead" }, {
    callback = function(ctx)
        local root = vim.fs.root(ctx.buf, { ".git", "Makefile" })
        if root then
            vim.cmd.lcd(root)
        end
    end,
})

vim.keymap.set(
    "n",
    "cdf",
    ":lcd %:p:h<CR>",
    { silent = true, desc = "cd to directory of file", unique = true }
)

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p")
end, { desc = "Open lf in directory of file", unique = true })

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd(0))
end, { desc = "Open lf in lcd", unique = true })

vim.keymap.set("n", "got", function()
    require("open_filedirterm").open_terminal(vim.o.shell, "%:p:h")
end, { desc = "Open terminal in directory of file", unique = true })

vim.keymap.set("n", "goT", function()
    require("open_filedirterm").open_terminal(vim.o.shell, vim.fn.getcwd(0))
end, { desc = "Open terminal in lcd", unique = true })

vim.keymap.set("n", "god", function()
    require("open_filedirterm").open_split_oil("%:p:h")
end, { desc = "Open oil in directory of file", unique = true })

vim.keymap.set("n", "goD", function()
    require("open_filedirterm").open_split_oil(vim.fn.getcwd(0))
end, { desc = "Open oil in lcd", unique = true })
