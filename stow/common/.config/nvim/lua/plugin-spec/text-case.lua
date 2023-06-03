return {
    "johmsalas/text-case.nvim",
    config = function()
        -- Do NOT run setup, otherwise it creates default keybindings
        -- require("textcase").setup({})

        local map_key = function(key, operator_name, desc)
            vim.keymap.set("n", "gyc" .. key, function()
                require("textcase").operator(operator_name)
            end, { desc = "Convert to " .. desc })
        end

        map_key("_", "to_snake_case", "snake_case")
        map_key("-", "to_dash_case", "dash-case")
        map_key("C", "to_constant_case", "CONSTANT_CASE")
        map_key(".", "to_dot_case", "dot.case")
        map_key("c", "to_camel_case", "camelCase")
        map_key("t", "to_title_case", "Title Case")
        map_key("/", "to_path_case", "path/case")
        map_key("s", "to_phrase_case", "Sentence case")
        map_key("m", "to_pascal_case", "MixedCase")
    end,
    keys = "gyc",
}
