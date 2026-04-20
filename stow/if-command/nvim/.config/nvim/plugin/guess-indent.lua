vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })

require("guess-indent").setup({
    filetype_exclude = {
        "go",
        "tutor",
        "terraform",
    },
})
