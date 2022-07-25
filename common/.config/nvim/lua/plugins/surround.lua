require("nvim-surround").setup({
    delimiters = {
        invalid_key_behavior = function(key)
            return { key, key }
        end,
    },
})

require("nvim-surround.buffer").format_lines = function(_, _)
    -- Disable indenting by nvim-surround; see
    -- https://github.com/kylechui/nvim-surround/issues/109#issuecomment-1194034971
end

local warn = function()
    vim.notify("Don't use 's'; use 'ys', 'ds', or 'cs'!", vim.log.levels.WARN)
end

vim.keymap.set("n", "sa", function()
    warn()
end)

vim.keymap.set("n", "sd", function()
    warn()
end)

vim.keymap.set("n", "sr", function()
    warn()
end)
