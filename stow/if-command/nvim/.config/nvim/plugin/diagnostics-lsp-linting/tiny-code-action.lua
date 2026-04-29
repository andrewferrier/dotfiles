vim.pack.add({ "https://github.com/rachartier/tiny-code-action.nvim" })
vim.pack.add({
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
        version = vim.version.range("*"),
    },
})
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("tiny-code-action").setup({ picker = "select" })

vim.keymap.set("n", "gra", function()
    require("tiny-code-action").code_action({})
end, { silent = true })
