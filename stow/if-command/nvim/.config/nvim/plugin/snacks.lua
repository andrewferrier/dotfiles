vim.pack.add({
    {
        src = "https://github.com/folke/snacks.nvim",
        version = vim.version.range("*"),
    },
})

---@type snacks.Config
local opts = {
    -- See https://github.com/folke/snacks.nvim/issues/1022
    bigfile = { enabled = true },
}

require("snacks").setup(opts)

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

vim.keymap.set("n", "<Leader>r", function()
    require("snacks").rename.rename_file()
end, { desc = "Rename File" })
