vim.pack.add({ { src = "https://github.com/chentoast/marks.nvim" } })

require("marks").setup({
    mappings = {
        next = "]m",
        prev = "[m",
    },
})
