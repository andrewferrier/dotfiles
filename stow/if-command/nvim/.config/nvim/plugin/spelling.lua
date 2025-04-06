if vim.fn.has("nvim-0.12.0") == 0 then
    local spelldir = vim.fs.joinpath(vim.fn.stdpath("data"), "spell")
    local spelldir_expanded = vim.fn.expand(spelldir)
    ---@cast spelldir_expanded string
    vim.fn.mkdir(spelldir_expanded, "p")
    vim.opt.spellfile = vim.fn.expand(spelldir .. "/en.utf-8.add")
end

vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.dictionary:append(vim.opt.spellfile:get())

vim.opt.spelllang = "en_gb"
vim.opt.spelloptions:append("camel")

vim.keymap.set("n", "zg", "zg]szz", { unique = true })

vim.cmd.iabbrev("Reciept", "Receipt")
vim.cmd.iabbrev("Reciepts", "Receipts")
vim.cmd.iabbrev("reciept", "receipt")
vim.cmd.iabbrev("reciepts", "receipts")
vim.cmd.iabbrev("recieve", "receive")
vim.cmd.iabbrev("recieved", "received")
