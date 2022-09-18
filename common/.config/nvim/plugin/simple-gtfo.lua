vim.keymap.set("n", "gof", function()
    require("open_terminal_fm").open_file_manager("%:p")
end, {})

vim.keymap.set("n", "goF", function()
    require("open_terminal_fm").open_file_manager(vim.fn.getcwd())
end, {})

vim.keymap.set("n", "got", function()
    require("open_terminal_fm").open_terminal(vim.o.shell, "%:p:h")
end, {})

vim.keymap.set("n", "goT", function()
    require("open_terminal_fm").open_terminal(vim.o.shell, vim.fn.getcwd())
end, {})
