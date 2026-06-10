if
    #vim.fn.globpath(vim.o.packpath, "pack/*/opt/debugprint.nvim", 0, 1) > 0
then
    vim.cmd.packadd("debugprint.nvim")
else
    vim.pack.add({ "https://github.com/andrewferrier/debugprint.nvim" })
end

---@type debugprint.GlobalOptions
local opts = {
    keymaps = {
        insert = {
            plain = false,
            variable = false,
        },
    },
    filetypes = {
        lf = require("debugprint.filetypes").bash,
    },
    picker = "fzf-lua",
}

require("debugprint").setup(opts)
