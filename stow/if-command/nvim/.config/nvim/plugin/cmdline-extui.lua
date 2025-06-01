if vim.fn.has("nvim-0.12.0") == 1 then
    vim.o.cmdheight = 0

    require("vim._extui").enable({
        msg = {
            pos = "box",
            box = {
                timeout = 2000,
            },
        },
    })

    vim.keymap.set("n", "gom", ":messages<CR>", { silent = true })
else
    vim.opt.showmode = false
end
