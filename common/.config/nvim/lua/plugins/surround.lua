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
