-- luacheck: globals vim

vim.keymap.set("n", "gyr", function()
    vim.notify(
        "You need to visually select a region to refactor!",
        vim.log.levels.WARN
    )
end, {
    silent = true,
})

vim.keymap.set("v", "gyr", function()
    require("refactoring").select_refactor()
end, {
    silent = true,
})
