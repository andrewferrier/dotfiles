vim.pack.add({ "https://github.com/NMAC427/guess-indent.nvim" })

require("guess-indent").setup({
    filetype_exclude = {
        "go",
        "tutor",
        "terraform",
    },
})
