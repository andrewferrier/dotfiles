vim.keymap.set("n", "gbc", function()
    require("open_terminal_fm").open_terminal("git commit", "%:p:h")
end)

vim.keymap.set("n", "gbm", function()
    require("open_terminal_fm").open_terminal("git commit --amend", "%:p:h")
end)

vim.keymap.set("n", "gbp", function()
    require("open_terminal_fm").open_terminal("git push", "%:p:h")
end)

vim.keymap.set("n", "gbs", function()
    require("open_terminal_fm").open_terminal("tig status", "%:p:h")
end)

vim.keymap.set("n", "gbt", function()
    require("open_terminal_fm").open_terminal("tig", "%:p:h")
end)

vim.keymap.set("n", "gbo", function()
    vim.fn.jobstart({ "git", "open" }, {
        cwd = vim.fn.expand("%:p:h"),
        detach = true,
        on_stderr = require("utils").job_stderr,
    })
end)

vim.keymap.set("n", "[C", "gg]c", { remap = true })
vim.keymap.set("n", "]C", "G[c", { remap = true })
