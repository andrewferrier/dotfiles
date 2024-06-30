return {
    "cvigilv/esqueleto.nvim",
    config = function()
        local DATA_SKELETON = vim.fn.stdpath("data") .. "/skeleton"
        local CONFIG_SKELETON = vim.fn.stdpath("config") .. "/skeleton"

        if vim.fn.isdirectory(DATA_SKELETON) == 1 then
            require("esqueleto").setup({
                directories = { CONFIG_SKELETON, DATA_SKELETON },
                patterns = vim.list_extend(
                    vim.fn.readdir(CONFIG_SKELETON),
                    vim.fn.readdir(DATA_SKELETON)
                ),
            })
        else
            require("esqueleto").setup({
                directories = { CONFIG_SKELETON },
                patterns = vim.fn.readdir(CONFIG_SKELETON),
            })
        end
    end,
    version = "*",
}
