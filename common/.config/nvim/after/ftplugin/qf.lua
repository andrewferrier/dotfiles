-- luacheck: globals vim

vim.opt_local.cursorline = true

vim.keymap.set("n", "q", function()
    vim.cmd("cclose")
end, { buffer = true })
