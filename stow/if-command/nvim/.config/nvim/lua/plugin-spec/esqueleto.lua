return {
    "cvigilv/esqueleto.nvim",
    config = function()
        require("esqueleto").setup({
            directories = {
                vim.fn.stdpath("config") .. "/skeleton",
                vim.fn.stdpath("data") .. "/skeleton",
            },
            patterns = vim.list_extend(
                vim.fn.readdir(vim.fn.stdpath("config") .. "/skeleton"),
                vim.fn.readdir(vim.fn.stdpath("data") .. "/skeleton")
            ),
        })
    end,
    version = "*",
}
