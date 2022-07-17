require("nvim-surround").setup({
    delimiters = {
        invalid_key_behavior = function(key)
            return { key, key }
        end,
    },
})
