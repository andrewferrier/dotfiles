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

vim.keymap.set("n", "<C-W>gof", function()
    require("open_filedirterm").open_file_manager("%:p", {})
end, { desc = "Open file in lf", unique = true })

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p", { external = true })
end, { desc = "Open file in lf (external)", unique = true })

vim.keymap.set("n", "<C-W>goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd(0), {})
end, { desc = "Open lcd in lf", unique = true })

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(
        vim.fn.getcwd(0),
        { external = true }
    )
end, { desc = "Open lcd in lf (external)", unique = true })

vim.keymap.set("n", "<C-W>got", function()
    require("open_filedirterm").open_terminal(vim.o.shell, { cwd = "%:p:h" })
end, { desc = "Open filedir in terminal", unique = true })

vim.keymap.set("n", "got", function()
    require("open_filedirterm").open_terminal(
        vim.o.shell,
        { cwd = "%:p:h", external = true }
    )
end, { desc = "Open filedir in terminal (external)", unique = true })

vim.keymap.set("n", "<C-W>goT", function()
    require("open_filedirterm").open_terminal(
        vim.o.shell,
        { cwd = vim.fn.getcwd(0) }
    )
end, { desc = "Open lcd in terminal", unique = true })

vim.keymap.set("n", "goT", function()
    require("open_filedirterm").open_terminal(
        vim.o.shell,
        { cwd = vim.fn.getcwd(0), external = true }
    )
end, { desc = "Open lcd in terminal (external)", unique = true })

vim.keymap.set("n", "<C-W>god", function()
    require("open_filedirterm").open_split_oil("%:p:h")
end, { desc = "Open oil in directory of file", unique = true })

vim.keymap.set("n", "<C-W>goD", function()
    require("open_filedirterm").open_split_oil(vim.fn.getcwd(0))
end, { desc = "Open oil in lcd", unique = true })
