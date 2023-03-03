return {
    "NvChad/nvim-colorizer.lua",
    config = function()
        vim.o.termguicolors = true

        require("colorizer").setup({
            user_default_options = { RGB = false, names = false },
        })
    end,
    event = "BufEnter",
}
