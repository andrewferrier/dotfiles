local opts = { silent = true }

vim.keymap.set("n", "gof", function()
    require("open_terminal_fm").open_file_manager("%:p")
end, opts)

vim.keymap.set("n", "goF", function()
    require("open_terminal_fm").open_file_manager(vim.fn.getcwd())
end, opts)

vim.keymap.set("n", "got", function()
    require("open_terminal_fm").open_terminal(vim.o.shell, "%:p:h")
end, opts)

vim.keymap.set("n", "goT", function()
    require("open_terminal_fm").open_terminal(
        vim.o.shell,
        vim.fn.getcwd()
    )
end, opts)
