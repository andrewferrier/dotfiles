vim.cmd.packadd("debugprint.nvim")

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
