if vim.fn.has("nvim-0.12.0") == 1 then
    vim.o.cmdheight = 0

    require("vim._extui").enable({
        msg = {
            pos = "box",
            box = {
                timeout = 3000,
            },
        },
    })
else
    vim.opt.showmode = false
end
