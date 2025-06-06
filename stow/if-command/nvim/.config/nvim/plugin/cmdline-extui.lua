-- FIXME: vim.opt.diff is temporary because of https://github.com/neovim/neovim/issues/34348

if vim.fn.has("nvim-0.12.0") == 1 and not vim.opt.diff:get() then
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
