-- selene: allow(mixed_table)
return {
    "folke/snacks.nvim",
    version = "*",
    lazy = false,
    config = function()
        -- See https://github.com/folke/snacks.nvim/issues/1022
        require("snacks").setup({
            bigfile = { enabled = true },
        })

        local bigfile_callback = function(regular_filetype)
            return function(path, buf)
                if
                    vim.bo[buf]
                    and vim.bo[buf].filetype ~= "bigfile"
                    and path
                    and vim.fn.getfsize(path) > 1.5 * 1024 * 1024
                then
                    return "bigfile"
                else
                    return regular_filetype
                end
            end
        end

        vim.filetype.add({
            filename = {
                COMMIT_EDITMSG = bigfile_callback("gitcommit"),
            },
        })
    end,
    keys = {
        {
            "<Leader>r",
            function()
                require("snacks").rename.rename_file()
            end,
            desc = "Rename File",
        },
    },
    priority = 1000, -- Recommended by README
}
